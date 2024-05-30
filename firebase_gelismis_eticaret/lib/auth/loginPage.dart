import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_gelismis_eticaret/viewModel/authbaseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/myTextField.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    AuthBaseViewModel authBaseViewModel=Provider.of<AuthBaseViewModel>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Text(
                  "shop".tr(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
               const  SizedBox(height: 25,),
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: authBaseViewModel.emailController,
                ),
               const  SizedBox(height: 15,),
                MyTextField(
                  hintText: "pasword".tr(),
                  obscureText: true,
                  controller: authBaseViewModel.passwordController,
                ),
                SizedBox(height: 25,),
                ElevatedButton(
                  onPressed: (){
                    authBaseViewModel.login(context);
                  },
                  style: ElevatedButton.styleFrom(
                   // primary: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "log".tr(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "member".tr(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: (){
                        widget.onTap();
                      },
                      child: Text(
                        "nowreg".tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
