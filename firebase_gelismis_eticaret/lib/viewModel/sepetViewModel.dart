import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_gelismis_eticaret/model/productModel.dart';
import 'package:firebase_gelismis_eticaret/repo/databaseRepository.dart';
import 'package:firebase_gelismis_eticaret/servis/base/firestoreServis/firestoreServis.dart';
import 'package:firebase_gelismis_eticaret/tools/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SepetViewModel with ChangeNotifier {


  final _servis = locator<DatabaseRepository>();


  int _adet=1;
  double _toplamFiyat=0;


  double get toplamFiyat => _toplamFiyat;

  set toplamFiyat(double value) {
    _toplamFiyat = value;
    notifyListeners();
  }

  set adet(int value) {
    _adet = value;
    notifyListeners();
  }

  int get adet => _adet;
  List<ProductModel>_sepet=[];
  List<ProductModel> get sepet => _sepet;


  /*SepetViewModel(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sepetiGetir();

    });
  }*/

  SepetViewModel() {
    _servis.sepetiGetir().listen((sepetListesi) {
      _sepet = sepetListesi;
      notifyListeners();
    });
  }

  Stream<List<ProductModel>> sepetiGetir(){
   return _servis.sepetiGetir();

  }

  void sepetiSil(ProductModel productModel)async{
    await _servis.sepetSil(productModel);
  }

  void arrtir(ProductModel product) {
    product.adet++;
    notifyListeners();
  }

  void azalt(ProductModel product) {
    if (product.adet > 1) {
      product.adet--;
      notifyListeners();
    }
  }

  int toplamfiyat(ProductModel product) {
    return product.adet * product.productPrice;
  }

  double sepetToplamFiyat(ProductModel product) {
    double totalSepet = 0;
    totalSepet+=product.adet*product.productPrice;
    return totalSepet;
  }


  void buildShowBottomSheet(BuildContext context,ProductModel product) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(16.0),
          child:   Column  (
            mainAxisSize: MainAxisSize.min,
            children:  [
               Text(
                'cardok'.tr(),
                style:const  TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
             const  SizedBox(height: 16),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text  (
                    'total:'.tr(),
                    style:const  TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text("${ sepetToplamFiyat(product)}"+"pd".tr(),
                    style:const TextStyle(fontSize:24 ,color: Colors.grey),)
                ],
              ),
             const  SizedBox(height: 16),
              ElevatedButton(onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar  (
                        elevation: 2,
                        backgroundColor: Colors.grey,
                        content: Text("confirmed".tr(),
                          style:const  TextStyle(fontSize: 24),)
                    )
                );
              }, child: Text("cardok".tr()
                ,style:const TextStyle(color: Colors.grey,fontSize: 20,),)
              )
            ],
          ),
        );
      },
    );
  }

}
