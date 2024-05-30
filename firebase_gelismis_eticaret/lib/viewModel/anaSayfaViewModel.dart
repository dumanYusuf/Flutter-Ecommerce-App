import 'package:firebase_gelismis_eticaret/model/productModel.dart';
import 'package:firebase_gelismis_eticaret/repo/databaseRepository.dart';
import 'package:firebase_gelismis_eticaret/tools/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/detaySayfa.dart';
import 'detaySayfaViewModel.dart';


class AnaSayfaViewModel with ChangeNotifier {
  final _servis = locator<DatabaseRepository>();


  TextEditingController _arama = TextEditingController();
  TextEditingController get arama => _arama;

  Stream<List<ProductModel>>? _stream;
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;


  AnaSayfaViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      urunleriYukle();
    });
  }

  void urunleriYukle() async {
    try {
      _stream = await _servis.urunleriYukle();
      _stream!.listen((event) {
        _products = event;
        notifyListeners();
      });
    } catch (e) {
      print("hata cıktı yukma işleminde$e");
    }
  }

  void urunAra(String aramaKelimesi) async {
    try {
      _products = await _servis.urunAra(aramaKelimesi);
      notifyListeners();
    } catch (e) {
      print("hata cıktı arama işleminde $e");
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

  void favoriEkle(ProductModel productModel)async{
    try{
      await _servis.favoriEkle(productModel);
    }
    catch(e){
      print("favori ekle de hata cıktı viewModelda $e");
    }
  }

   void DetaySayfaAc(BuildContext context, ProductModel productModel) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider<DetaySayfaViewModel>(
        create: (context) => DetaySayfaViewModel(productModel: productModel),
        child: DetaySayfa(productModel: productModel),
      ),
    );
    Navigator.push(context, pageRoute);
  }
}
