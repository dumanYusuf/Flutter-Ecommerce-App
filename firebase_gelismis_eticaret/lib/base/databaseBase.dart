import 'package:firebase_gelismis_eticaret/model/Users.dart';
import 'package:firebase_gelismis_eticaret/model/productModel.dart';

abstract class DatabaseBase{
  Future<dynamic>urunleriYukle();
  Future<dynamic>urunAra(String aramaKelimesi);
  Future<dynamic>sepeteEkle(ProductModel productModel);
  Stream<List<ProductModel>>sepetiGetir();
  Future<dynamic>sepetSil(ProductModel productModel);
  Future<dynamic>favoriEkle(ProductModel productModel);
  Stream<List<ProductModel>>favoriGetir();
  Future<dynamic>favoriSil(ProductModel productModel);
  Stream<List<Users>>kullaniciGetir();
}