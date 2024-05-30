import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_gelismis_eticaret/viewModel/anaSayfaViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnaSayfaViewModel>(builder: (context,viewModel,child){
     return ListView(
        children: [

          Container(
            height: 150,
            child: ClipRect(
                child: Swiper(
                    itemCount: 3,
                itemBuilder: (context, index){
                      return Image.asset(
                        index==0
                            ? "assets/resim1.jpg"
                            : index==1
                            ? "assets/cola.webp"
                            : "assets/borek.jpg"
                            ,fit: BoxFit.cover,
                      );
                },
                  pagination: const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.green, color: Colors.red)),

                ),
            ),
          ),
          Padding(
            padding: const  EdgeInsets.all(16.0),
            child: CupertinoSearchTextField(
              controller: viewModel.arama,
              onChanged: (value) {
                viewModel.urunAra(value);
                print("arama consumer calıstı");
              },
            ),

          ),
          GridView.builder(
              shrinkWrap: true,
              physics:const  NeverScrollableScrollPhysics(),
              itemCount: viewModel.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 230
              ),
              itemBuilder: (context, index){
                var oankiUrun=viewModel.products[index];
                return Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      InkWell(
                        onTap:(){
                            viewModel.DetaySayfaAc(context, oankiUrun);
                        },
                        child: Container(
                          width: 150,
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(oankiUrun.productImage)
                                  ,fit: BoxFit.cover)
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(oankiUrun.productTitle,style:const  TextStyle(fontSize: 20),),
                            Row(
                            children: [
                            const  Padding(
                               padding:  EdgeInsets.only(left: 15),
                               child:   Icon(Icons.bike_scooter,),
                             ),
                             const SizedBox(width: 15,),
                             const  Text("free").tr()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                 const  Text("pd",style: TextStyle(fontSize: 20),).tr(),
                                 const  SizedBox(width: 2,),
                                  Text("${oankiUrun.productPrice}"
                                    ,style:const  TextStyle(fontSize: 19),),
                                ],
                              ),
                              IconButton(onPressed: (){
                                Provider.of<AnaSayfaViewModel>(context,listen: false).favoriEkle(oankiUrun);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.grey,
                                    duration: const Duration(seconds: 2),
                                    content: Row(
                                      children: [
                                        Text("${oankiUrun.productTitle}"),
                                       const  SizedBox(width: 5,),
                                        Text("addFavorites".tr(),
                                          style: const TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                      action: SnackBarAction(label: "", onPressed:(){
                                        Provider.of<AnaSayfaViewModel>(context,listen: false).favoriEkle(oankiUrun);
                                      }),
                                    ),
                                );
                                print("favoriekle consumer calıstı");
                              }, icon:const  Icon(Icons.favorite_outline)),
                              IconButton(onPressed: (){
                                Provider.of<AnaSayfaViewModel>(context,listen: false).sepeteEkle(oankiUrun);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.grey,
                                    duration: const Duration(seconds: 2),
                                    content: Row(
                                      children: [
                                        Text("${oankiUrun.productTitle}"),
                                       const  SizedBox(width: 5,),
                                        Text("addcard".tr(),
                                          style:const  TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    action: SnackBarAction(label: "", onPressed:(){
                                      Provider.of<AnaSayfaViewModel>(context,listen: false).sepeteEkle(oankiUrun);
                                    }),
                                  ),
                                );
                                print("Sepete ekle consumer calıstı");
                              }, icon:const  Icon(Icons.shopping_basket_outlined)
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              })
        ],
      );
    });

  }
}
