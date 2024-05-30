
import 'package:firebase_gelismis_eticaret/repo/databaseRepository.dart';
import 'package:firebase_gelismis_eticaret/servis/base/authServis/authServis.dart';
import 'package:firebase_gelismis_eticaret/servis/base/firestoreServis/firestoreServis.dart';
import 'package:get_it/get_it.dart';

GetIt locator=GetIt.instance;

setUpLocator(){
  locator.registerLazySingleton(() => DatabaseRepository());
  locator.registerLazySingleton(() => FirestoreServis());
  locator.registerLazySingleton(() => AuthServis());
}
