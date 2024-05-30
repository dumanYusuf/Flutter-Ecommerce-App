import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_gelismis_eticaret/base/authBase.dart';
import 'package:firebase_gelismis_eticaret/model/Users.dart';

class AuthServis extends AuthBase{
  final FirebaseAuth auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  @override
  Future signInWithEmailAndPassword(String email, String password)async {
   try{
     UserCredential userCredential=await auth.signInWithEmailAndPassword(
         email: email, password: password);

   /*  var favorites = await  _firestore.collection("Users").doc(userCredential.user!.uid).collection("favoriler").doc(userCredential.user!.uid).set({
       "favoriId" : userCredential.user!.uid
     },
       SetOptions(merge: true),
     );


     var sepets =  await _firestore.collection("Users").doc(userCredential.user!.uid).collection("Sepet").doc(userCredential.user!.uid).set(
         {
           "basketId":userCredential.user!.uid
         },
       SetOptions(merge: true),
         ).whenComplete(() => favorites);


     await _firestore.collection("Users").doc(userCredential.user!.uid).set(
       {
         'email': email,
         'id': userCredential.user!.uid,
       }
     ).then((value) => sepets);*/

     return userCredential;
   }
   catch(e){
     print("hata cıktı $e");
   }
  }

  @override
  Future<void> logOut()async {
    return await auth.signOut();
  }

  @override
  Future signUpWithEmailAndPassword(String email, String password,String userName)async {
    try{
      UserCredential userCredential=await auth.createUserWithEmailAndPassword(
          email: email, password: password,);

      var favorites=await _firestore.collection("Users").doc(userCredential.user!.uid)
      .collection("favoriler").doc(userCredential.user!.uid)
      .set({
        "favoriId":userCredential.user!.uid
      },
        SetOptions(merge: true)
      );

      var sepets=await _firestore.collection("Users").doc(userCredential.user!.uid)
      .collection("Sepet").doc(userCredential.user!.uid)
      .set({
        "basketId":userCredential.user!.uid
      },
        SetOptions(merge: true)
      ).whenComplete(() => favorites);

      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'email':email,
        'userName':userName,
        'id':userCredential.user!.uid,
        'profil_url':"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShB7IwN9gr4q2Tn-1CRfbgANRN-8SWlYMMy9iq467T1A&s"

      }).whenComplete(() => sepets);
    }
    catch(e){
      print("kayıt olma işleminde bir hata olustu");
    }
  }
}