import 'package:firebase_gelismis_eticaret/model/Users.dart';

abstract class AuthBase{
  Future<dynamic>signInWithEmailAndPassword(String email,String password);
  Future<void>logOut();
  Future<dynamic>signUpWithEmailAndPassword(String email,String password,String userName);
}