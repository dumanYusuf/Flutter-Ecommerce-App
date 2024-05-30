import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_gelismis_eticaret/viewModel/curentIndexProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModel/sepetViewModel.dart';

class SepetSayfa extends StatefulWidget {
  SepetSayfa({super.key,});


  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  double toplamFiyat=0;

  @override
  Widget build(BuildContext context) {
    SepetViewModel sepetViewModel = Provider.of<SepetViewModel>(context, listen: false);
    return Stack(
      children: [
        StreamBuilder(
          stream: sepetViewModel.sepetiGetir(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else {
              var sepet = snapshot.data;
              if (sepet == null || sepet.isEmpty) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Padding(
                        padding: EdgeInsets.all(20.0),
                        child:const  Text("empyt_card", style: TextStyle(fontSize: 20)).tr()
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<CurentIndexProvider>().secilenMenuItem = 0;
                        },
                        icon: const Icon(Icons.shopping_basket_outlined, size: 30),
                      ),
                    ],
                  ),
                );
              } else {
                return Stack(
                  children: [
                    ListView.builder(
                      itemCount: sepet.length,
                      itemBuilder: (context, index) {
                        var oankiUrun = sepet[index];
                        toplamFiyat=sepetViewModel.sepetToplamFiyat(oankiUrun);
                        return SizedBox(
                          height: 190,
                          child: Card(
                            elevation: 2,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(oankiUrun.productTitle),
                                  subtitle: Row(
                                    children: [
                                      Text("${oankiUrun.productPrice}"),
                                     const  Text("pd").tr(),
                                    ],
                                  ),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(oankiUrun.productImage),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      sepetViewModel.sepetiSil(oankiUrun);
                                    },
                                    icon: const Icon(Icons.dangerous),
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        sepetViewModel.azalt(oankiUrun);
                                      },
                                      child: const Text("-", style: TextStyle(fontSize: 35)),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Consumer<SepetViewModel>(
                                        builder: (context, viewModel, child) {
                                          return Text(
                                            "${oankiUrun.adet}",
                                            style: const TextStyle(fontSize: 35),
                                          );
                                        },
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        sepetViewModel.arrtir(oankiUrun);
                                      },
                                      child: const Text("+", style: TextStyle(fontSize: 35)),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 22),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Consumer<SepetViewModel>(
                                          builder: (context,sepetViewModel,child){
                                            return  Row(
                                              children: [
                                                 Text("price".tr(),
                                                   style:const  TextStyle(fontSize: 20),),
                                               const  Text(":",style: TextStyle(fontSize: 20),),
                                                Text(
                                                  "${sepetViewModel.toplamfiyat(oankiUrun)}",
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                                const Text("pd").tr()
                                              ],
                                            );
                                          }
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 700,
                      right: 10,
                      child: TextButton(
                        onPressed: () {
                          if (sepet.isNotEmpty) {
                            sepetViewModel.buildShowBottomSheet(context,sepet[0]);
                            toplamFiyat;
                          }
                        },
                        child: const Icon(Icons.navigation, size: 50),
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ],
    );
  }
}
