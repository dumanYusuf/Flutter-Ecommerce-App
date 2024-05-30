import 'package:flutter/cupertino.dart';

class Sepet with ChangeNotifier{

  dynamic basketId;

  Sepet({this.basketId});

  factory Sepet.fromMap (Map<String,dynamic> map,{dynamic key}){
    return Sepet(basketId: key ?? map["basketId"]);
  }

  Map<String,dynamic> toMap({dynamic key}){
    return {
      "basketId":key ?? basketId,
    };
  }

}