import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_gelismis_eticaret/base/authBase.dart';
import 'package:firebase_gelismis_eticaret/base/databaseBase.dart';
import 'package:firebase_gelismis_eticaret/model/Users.dart';
import 'package:firebase_gelismis_eticaret/model/productModel.dart';
import 'package:firebase_gelismis_eticaret/model/sepet.dart';
import 'package:firebase_gelismis_eticaret/servis/base/firestoreServis/database_servis.dart';
import 'package:firebase_gelismis_eticaret/servis/base/firestoreServis/firestoreServis.dart';
import 'package:firebase_gelismis_eticaret/tools/locator.dart';

import '../servis/base/authServis/authServis.dart';

class DatabaseRepository implements DatabaseBase,AuthBase{

  final DatabaseServis _servis=locator<FirestoreServis>();
  final AuthBase _authBase=locator<AuthServis>();

  @override
  Future urunleriYukle()async {
    return await _servis.urunleriYukle();
  }

  @override
  Future urunAra(String aramaKelimesi) async{
    return await _servis.urunAra(aramaKelimesi);
  }

  @override
  Future sepeteEkle(ProductModel productModel)async {
    return await _servis.sepeteEkle(productModel);
  }



  @override
  Future signInWithEmailAndPassword(String email, String password) async{
    return await _authBase.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> logOut()async {
    return await _authBase.logOut();

  }

  @override
  Future signUpWithEmailAndPassword(String email, String password,String userName) async{
    return await _authBase.signUpWithEmailAndPassword(email, password,userName);
  }

  @override
  Stream<List<ProductModel>> sepetiGetir()async* {
    yield* _servis.sepetiGetir();
  }

  @override
  Future favoriEkle(ProductModel productModel) async{
    return await _servis.favoriEkle(productModel);
  }

  @override
  Stream<List<ProductModel>> favoriGetir() async*{
    yield* _servis.favoriGetir();
  }

  @override
  Future favoriSil(ProductModel productModel)async {
    return await _servis.favoriSil(productModel);
  }

  @override
  Future sepetSil(ProductModel productModel)async {
    return await _servis.sepetSil(productModel);
  }

  @override
  Stream<List<Users>> kullaniciGetir()async* {
    yield* _servis.kullaniciGetir();
  }
}