import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../servis/base/authServis/authServis.dart';

class AuthBaseViewModel with ChangeNotifier{

  final AuthServis _authServis=AuthServis();

  TextEditingController _emailController=TextEditingController();
  TextEditingController get emailController => _emailController;
  TextEditingController _passwordController=TextEditingController();
  TextEditingController get passwordController => _passwordController;


  TextEditingController _emailControllerregister=TextEditingController();
  TextEditingController get emailControllerregister => _emailControllerregister;
  TextEditingController _passwordControllerregister=TextEditingController();
  TextEditingController get passwordControllerregister =>_passwordControllerregister;
  TextEditingController _confirmPasswordController=TextEditingController();
  TextEditingController get confirmPasswordController =>_confirmPasswordController;
  TextEditingController _userNameController=TextEditingController();
  TextEditingController get userNameController => _userNameController;

  void login(BuildContext context)async{
    try{
      await _authServis.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      _emailController.clear();
      _passwordController.clear();
    }
    catch(e){
       showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Text(e.toString()),
            content: Text("Hata cıktı"),
          ));
    }
  }


  void logOut()async{
    try{
      await _authServis.logOut();
    }
    catch(e){
      print("hata cıktı $e");
    }
  }

 /* void register(BuildContext context)async{
    try{
      if(_passwordControllerregister.text==_confirmPasswordController.text){
        await _authServis.signUpWithEmailAndPassword(_emailControllerregister.text, _passwordControllerregister.text,_userNameController.text);
      }
      else{
        showDialog(context: context,
            builder: (context) {
              return Text("hata cıktı");
            });
      }
    }
    catch(e){
     print(e.toString());
    }
  }*/




  void register(BuildContext context) async {
    try {
      String email = _emailControllerregister.text;
      String password = _passwordControllerregister.text;
      String confirmPassword = _confirmPasswordController.text;
      String username = _userNameController.text;

      // Email format validation
      if (!email.contains('@')) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:const  Text("eror").tr(),
              content:const  Text("adress").tr(),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:const  Text("okk").tr(),
                ),
              ],
            );
          },
        );
        return;
      }

      if (password.length < 6) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("eror").tr(),
              content:const  Text("char").tr(),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:const  Text("okk").tr(),
                ),
              ],
            );
          },
        );
        return;
      }

      // Password match validation
      if (password != confirmPassword) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("eror").tr(),
              content:const  Text("charr").tr(),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:const  Text("okk").tr(),
                ),
              ],
            );
          },
        );
        return;
      }

      await _authServis.signUpWithEmailAndPassword(email, password, username);

    } catch (e) {
      String errorMessage;

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = "Bu email adresi zaten kullanılıyor.";
            break;
          case 'weak-password':
            errorMessage = "Şifreniz çok zayıf.";
            break;
          case 'invalid-email':
            errorMessage = "Geçersiz email adresi. Email adresinde '@' olmalı.";
            break;
          default:
            errorMessage = "Bir hata oluştu. Lütfen tekrar deneyin.";
        }
      } else {
        errorMessage = "Bir hata oluştu. Lütfen tekrar deneyin.";
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("eror").tr(),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:const  Text("okk").tr(),
              ),
            ],
          );
        },
      );
    }
  }


 /* void googleGiris()async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
     await FirebaseAuth.instance.signInWithCredential(credential);
  }*/
}
