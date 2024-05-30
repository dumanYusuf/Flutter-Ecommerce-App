import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_gelismis_eticaret/view/anaSayfa.dart';
import 'package:firebase_gelismis_eticaret/view/favoriSayfa.dart';
import 'package:firebase_gelismis_eticaret/view/hesabimSayfa.dart';
import 'package:firebase_gelismis_eticaret/view/sepetSayfa.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModel/curentIndexProvider.dart';

class BodySayfa extends StatefulWidget {
  const BodySayfa({super.key});

  @override
  State<BodySayfa> createState() => _BodySayfaState();
}

class _BodySayfaState extends State<BodySayfa> {
  late List<Widget>tumSayfalar;
  late AnaSayfa anaSayfa;
  late SepetSayfa sepetSayfa;
  late FavoriSayfa favoriSayfa;
  late HesabimSayfa hesabimSayfa;

  @override
  void initState() {
    super.initState();
    anaSayfa=AnaSayfa();
    sepetSayfa=SepetSayfa();
    favoriSayfa=FavoriSayfa();
    hesabimSayfa=HesabimSayfa();

    tumSayfalar=[anaSayfa,sepetSayfa,favoriSayfa,hesabimSayfa];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CurentIndexProvider>(builder: (context,viewModel,child){
        return tumSayfalar[viewModel.secilenMenuItem];
      }),
      bottomNavigationBar:  Consumer<CurentIndexProvider>(builder: (context,viewModel,child){
        return BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,),
              label: "home".tr()
          ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined),
              label: "cardes".tr()),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),
              label: "favories".tr()),
          BottomNavigationBarItem(icon: Icon(Icons.person),
              label: "my".tr()),
        ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          currentIndex: viewModel.secilenMenuItem,
          onTap: (yeniItem){
              viewModel.secilenMenuItem=yeniItem;
          },
        );
      })
    );
  }
}
