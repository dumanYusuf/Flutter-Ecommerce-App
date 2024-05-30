import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_gelismis_eticaret/auth/loginOrRegisterPage.dart';
import 'package:firebase_gelismis_eticaret/view/bodySayfa.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return  BodySayfa();
            }
            else{
              return const LoginOrRegisterPage();
            }
          }),
    );
  }
}
