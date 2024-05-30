import 'package:firebase_gelismis_eticaret/viewModel/dilPagViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DilPage extends StatefulWidget {
  const DilPage({super.key});

  @override
  State<DilPage> createState() => _DilPageState();
}

class _DilPageState extends State<DilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const  Text("Dil Değiştir"),),
      body:Column(
        children: [
          Text("Merhaba duman"),
          Consumer<DilPageViewModel>(
            builder: (context, value, child){
              return DropdownButton(
                value: value.selectedLanguageCode,
                  items: value.languages.keys.map((languageCode) =>
                      DropdownMenuItem<String>(
                        value: languageCode,
                          child:Text(value.languages[languageCode]) )).toList(),
                  onChanged: (String? newLanguageCode){
                     if(newLanguageCode != null){
                       value.selectedLanguageCode=newLanguageCode;
                     }
                  });
            }),
        ],
      )
    );
  }
}
