import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_gelismis_eticaret/repo/databaseRepository.dart';
import 'package:firebase_gelismis_eticaret/view/dilPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/Users.dart';
import '../tools/locator.dart';
import 'dilPagViewModel.dart';

class ProfilViewModel with ChangeNotifier{

  final _servis=locator<DatabaseRepository>();
 final  FirebaseFirestore _firestore=FirebaseFirestore.instance;

  List<Users>_users=[];

  List<Users> get users => _users;

  ProfilViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUsers();
    });
  }

  Stream<List<Users>> getUsers(){
      return _servis.kullaniciGetir();
  }

  void kameradanResimSec()async{

    User? curentUser=FirebaseAuth.instance.currentUser;

    final ImagePicker _picker=ImagePicker();

  XFile? _file=await _picker.pickImage(source: ImageSource.camera);

  var _profilRef=FirebaseStorage.instance.ref('Users/profil_resimleri/${curentUser!.uid}');
  var _task=_profilRef.putFile(File(_file!.path));
  
  _task.whenComplete(()async{
     var _url=await _profilRef.getDownloadURL();
     _firestore.collection("Users").doc(curentUser.uid).set({
        'profil_url':_url.toString(),
     },
       SetOptions(merge: true),
     );
     debugPrint(_url);
  });

  }

  void galeridenResimSec()async{

    User? curentUser=FirebaseAuth.instance.currentUser;

    final ImagePicker _picker=ImagePicker();

    XFile? _file=await _picker.pickImage(source: ImageSource.gallery);

    var _profilRef=FirebaseStorage.instance.ref('Users/profil_resimleri/${curentUser!.uid}');
    var _task=_profilRef.putFile(File(_file!.path));

    _task.whenComplete(()async{
      var _url=await _profilRef.getDownloadURL();
      _firestore.collection("Users").doc(curentUser.uid).set({
        'profil_url':_url.toString(),
      },
        SetOptions(merge: true),
      );
      debugPrint(_url);
    });

  }

  void buildShowBottomSheetProfil(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(16.0),
          child:    Column   (
            mainAxisSize: MainAxisSize.min,
            children:  [
              const Text(
                'Şeçim Yap',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const  SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListTile(
                  title:const  Text("Kameradan Çek"),
                    leading: IconButton(onPressed: (){
                      kameradanResimSec();
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.camera_alt)),
              ),
                  ListTile(
                    title:const Text("Galeriden  seç"),
                    leading: IconButton(onPressed: (){
                      galeridenResimSec();
                      Navigator.pop(context);
                    }, icon:const  Icon(Icons.file_copy)),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void DilPageGit(BuildContext context){
    MaterialPageRoute pageRoute=MaterialPageRoute(builder: (context){
      return ChangeNotifierProvider<DilPageViewModel>(create: (context)=>
      DilPageViewModel(),child: DilPage(),);
    });
    Navigator.push(context, pageRoute);
  }
}