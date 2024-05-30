import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_gelismis_eticaret/auth/authGate.dart';
import 'package:firebase_gelismis_eticaret/tools/locator.dart';
import 'package:firebase_gelismis_eticaret/viewModel/anaSayfaViewModel.dart';
import 'package:firebase_gelismis_eticaret/viewModel/authbaseViewModel.dart';
import 'package:firebase_gelismis_eticaret/viewModel/curentIndexProvider.dart';
import 'package:firebase_gelismis_eticaret/viewModel/favoiViewModel.dart';
import 'package:firebase_gelismis_eticaret/viewModel/profilViewModel.dart';
import 'package:firebase_gelismis_eticaret/viewModel/sepetViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Theme/themeProvider.dart';

void main() async{
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: EasyLocalization(
        supportedLocales:const  [Locale('en', 'US'), Locale('tr', 'TR')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp())
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.deviceLocale,// uygulama cihazın dili ile başlar
         home:MultiProvider(providers: [
           ChangeNotifierProvider(create: (context)=>CurentIndexProvider()),
           ChangeNotifierProvider(create: (context)=>AnaSayfaViewModel()),
           ChangeNotifierProvider(create: (context)=>SepetViewModel()),
           ChangeNotifierProvider(create: (context)=>FavoriViewModel()),
           ChangeNotifierProvider(create: (context)=>AuthBaseViewModel()),
           ChangeNotifierProvider(create: (context)=>ProfilViewModel()),
         ],
         child: AuthGate(),
         ),
        theme: Provider.of<ThemeProvider>(context).themeData
    );
  }
}
