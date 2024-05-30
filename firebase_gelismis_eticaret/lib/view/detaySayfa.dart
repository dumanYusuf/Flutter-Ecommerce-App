import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_gelismis_eticaret/viewModel/detaySayfaViewModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_gelismis_eticaret/model/productModel.dart';
import 'package:provider/provider.dart';

class DetaySayfa extends StatefulWidget {
  DetaySayfa({Key? key, required this.productModel}) : super(key: key);

  final ProductModel productModel;

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel.productTitle),
      ),
      body: Consumer<DetaySayfaViewModel>(builder: (context,detayviewModel,child){
         return SingleChildScrollView(
           child: Column(
             children: [
               Container(
                 width: double.infinity,
                 height: 230,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: NetworkImage(widget.productModel.productImage),
                     fit: BoxFit.cover,
                   ),
                 ),
               ),
               const SizedBox(height: 15),
                Text(
                 "pd".tr()
                     + widget.productModel.productPrice.toString(),
                 style:const  TextStyle(fontSize: 24),
               ),
              const  SizedBox(height: 10),
               Text(
                 widget.productModel.productTitle,
                 style: const TextStyle(fontSize: 24),
               ),
               Text(widget.productModel.productDescription),
              const  SizedBox(height: 30),
               Center(
                 child: ElevatedButton(onPressed: () {
                   detayviewModel.sepeteEkle(widget.productModel);
                   ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                         backgroundColor: Colors.grey,
                           content: Row(
                             children: [
                               Text("${widget.productModel.productTitle}"),
                             const  SizedBox(width: 5,),
                              const  Text("addcard").tr()
                             ],
                           ),
                         action: SnackBarAction(label: "", onPressed: (){

                         }),
                       ));
                 }, child:const  Text("adcard").tr()
                 ),
               )
             ],
           ),
         );
      })
    );
  }
}
