import 'package:firebase_gelismis_eticaret/model/productModel.dart';
import 'package:firebase_gelismis_eticaret/model/sepet.dart';
import 'package:firebase_gelismis_eticaret/repo/databaseRepository.dart';
import 'package:flutter/foundation.dart';

import '../tools/locator.dart';

class DetaySayfaViewModel with ChangeNotifier {

  final _servis=locator<DatabaseRepository>();

  ProductModel productModel;
  DetaySayfaViewModel({required this.productModel});
  int _adet = 0;

  int get adet => _adet;

  set adet(int value) {
    _adet = value;
    notifyListeners();
  }

  int toplamFiyat(ProductModel productModel) {
      final toplamFiyat = _adet * productModel.productPrice;
      return toplamFiyat;
  }


  void artir() {
    adet++;
  }

  void azalt() {
    if (adet > 0) {
      adet--;
    }
  }



  void sepeteEkle(ProductModel productModel)async{
    try{
      await _servis.sepeteEkle(productModel);
    }
    catch(e){
      print("sepet ekle viewModalda hata cıktı$e");
    }
  }
}
