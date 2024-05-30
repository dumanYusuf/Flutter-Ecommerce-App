import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_gelismis_eticaret/Theme/themeProvider.dart';
import 'package:firebase_gelismis_eticaret/model/Users.dart';
import 'package:firebase_gelismis_eticaret/viewModel/authbaseViewModel.dart';
import 'package:firebase_gelismis_eticaret/viewModel/curentIndexProvider.dart';
import 'package:firebase_gelismis_eticaret/viewModel/profilViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../Widgets/animasyonWidget.dart';

class HesabimSayfa extends StatefulWidget {
  const HesabimSayfa({super.key});

  @override
  State<HesabimSayfa> createState() => _HesabimSayfaState();
}

class _HesabimSayfaState extends State<HesabimSayfa> {
  @override
  Widget build(BuildContext context) {
    ProfilViewModel profilViewModel =
        Provider.of<ProfilViewModel>(context, listen: false);
    return Container(
      color: Colors.black12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            const  Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(child:ShopAnimasyon()
          ),
           ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
                stream: profilViewModel.getUsers(),
                builder: (context, snapshot){
                   if(snapshot.hasError){
                     return Text(snapshot.hasError.toString());
                   }
                   else if(snapshot.connectionState==ConnectionState.waiting){
                     return const Center(child: CircularProgressIndicator(),);
                   }
                   else{
                     var kullaniciBilgisi=snapshot.data as List<Users>;
                     return ListTile(
                       leading: GestureDetector(
                         onTap: (){
                            profilViewModel.buildShowBottomSheetProfil(context);
                         },
                         child: CircleAvatar(
                           radius: 30,
                           backgroundImage: NetworkImage(kullaniciBilgisi[0].profil_url),
                         ),
                       ),
                       title: Text(kullaniciBilgisi[0].userName),
                       subtitle: Text(kullaniciBilgisi[0].email),
                     );
                   }
                }),
          ),
          const SizedBox(
            height: 10,
          ),
           Text(
            "info".tr(),
            style:const  TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://imzalikitabim.com/wp-content/uploads/2018/02/S%C4%B0TE-%C4%B0CON-03-min.png"),
                        fit: BoxFit.cover)),
              ),
            ),
            title: Text(
              "products".tr(),
              style: TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
                onPressed: () {
                  context.read<CurentIndexProvider>().secilenMenuItem = 0;
                },
                icon: const Icon(
                  Icons.navigate_next_outlined,
                  size: 30,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            title:  Text(
              "favories".tr(),
              style: TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
                onPressed: () {
                  context.read<CurentIndexProvider>().secilenMenuItem = 2;
                },
                icon: const Icon(
                  Icons.navigate_next_outlined,
                  size: 30,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.shopping_basket,
                color: Colors.red,
              ),
            ),
            title:  Text(
              "cardes".tr(),
              style: TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
                onPressed: () {
                  context.read<CurentIndexProvider>().secilenMenuItem = 1;
                },
                icon: const Icon(
                  Icons.navigate_next_outlined,
                  size: 30,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                "Theme".tr(),
                style: TextStyle(fontSize: 20),
              ),
              CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context).isDarkMod,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toogleTheme(),
              ),
            ],
          ),
         /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const  Text(
                "Dil Seçimi",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                    onPressed: (){
                      profilViewModel.DilPageGit(context);
                    },
                    icon:const  Icon(Icons.navigate_next,size:30 ,)),
              )
            ],
          ),*/
          Center(
            child: ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthBaseViewModel>().logOut();
                  context.read<CurentIndexProvider>().secilenMenuItem = 0;
                  Future.delayed(Duration(seconds: 4));
                },
                icon: const Icon(Icons.login),
                label:  Text("out").tr()
            ),
          ),
        ],
      ),
    );
  }
}
