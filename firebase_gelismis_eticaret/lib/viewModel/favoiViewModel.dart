import 'package:firebase_gelismis_eticaret/model/favori.dart';
import 'package:firebase_gelismis_eticaret/model/productModel.dart';
import 'package:firebase_gelismis_eticaret/repo/databaseRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../tools/locator.dart';

class FavoriViewModel with ChangeNotifier{

  final _servis=locator<DatabaseRepository>();

 late Stream<List<ProductModel>>? _stream;
  List<ProductModel>_favoriler=[];

  List<ProductModel> get favoriler => _favoriler;

  FavoriViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      favoriGetir();
    });
  }

  Stream<List<ProductModel>> favoriGetir(){
    return _servis.favoriGetir();
  }

  void favoriSil(ProductModel productModel)async{
  /*  ProductModel productModel=_favoriler[index];
    await _servis.favoriSil(productModel); stream builder kullanmdan önceki hali Consumer kullandıgımda kullanılan kod
    notifyListeners();*/

    _servis.favoriSil(productModel);
  }
}