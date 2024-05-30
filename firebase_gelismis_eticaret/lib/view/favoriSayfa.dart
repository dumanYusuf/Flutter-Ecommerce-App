import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_gelismis_eticaret/viewModel/favoiViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModel/curentIndexProvider.dart';

class FavoriSayfa extends StatefulWidget {
  const FavoriSayfa({super.key});

  @override
  State<FavoriSayfa> createState() => _FavoriSayfaState();
}

class _FavoriSayfaState extends State<FavoriSayfa> {
  @override
  Widget build(BuildContext context) {
    FavoriViewModel viewModel=Provider.of<FavoriViewModel>(context,listen: false);
     return StreamBuilder(
         stream: viewModel.favoriGetir(),
         builder: (context, snapshot){
           if(snapshot.hasError){
             return Text(snapshot.hasError.toString());
           }
           else if(snapshot.connectionState==ConnectionState.waiting){
             return const  Center(child: CircularProgressIndicator(),);
           }
           else{
             var favoriler=snapshot.data;
             return favoriler!.isEmpty  ?
             Center(
                 child: Row(
                   children: [
                     Padding(
                       padding:  EdgeInsets.all(16.0),
                       child: const  Text("empyt_favorite",style: TextStyle(fontSize: 20),).tr()
                     ),
                     IconButton(onPressed: (){
                       context.read<CurentIndexProvider>().secilenMenuItem=0;
                     }, icon: const Icon(Icons.shopping_basket_outlined,size: 30,)
                     )
                   ],
                 )
             )
                 : ListView.builder(
                 itemCount:favoriler.length,
                 itemBuilder: (context, index){
                   var oankiFavori=favoriler[index];
                   return Card(
                     elevation: 2,
                     child: ListTile(
                       title: Text(oankiFavori.productTitle),
                       subtitle: Text(oankiFavori.productDescription),
                       leading: CircleAvatar(
                         radius: 30,
                         backgroundImage: NetworkImage(oankiFavori.productImage),
                       ),
                       trailing: SizedBox(
                         width: 50,
                         child: Row(
                           children: [
                             IconButton(onPressed: (){
                               viewModel.favoriSil(oankiFavori);
                             }, icon:const Icon(Icons.dangerous))
                           ],
                         ),
                       ),
                     ),
                   );
                 });
           }
         });
  }
}
