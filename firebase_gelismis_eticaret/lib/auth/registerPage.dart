import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_gelismis_eticaret/viewModel/authbaseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/myTextField.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    AuthBaseViewModel authBaseViewModel=Provider.of<AuthBaseViewModel>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white, // Arka plan rengi beyaz
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
                SizedBox(height: 25,),
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: authBaseViewModel.emailControllerregister,
                ),
                SizedBox(height: 15,),
                MyTextField(
                  hintText: "user".tr(),
                  obscureText: false,
                  controller: authBaseViewModel.userNameController,
                ),
                SizedBox(height: 15,),
                MyTextField(
                  hintText: "pasword".tr(),
                  obscureText: true,
                  controller: authBaseViewModel.passwordControllerregister,
                ),
                SizedBox(height: 15,),
                MyTextField(
                  hintText: "confp".tr(),
                  obscureText: true,
                  controller: authBaseViewModel.confirmPasswordController,
                ),
                SizedBox(height: 25,),
                ElevatedButton(
                  onPressed: (){
                    authBaseViewModel.register(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "reg".tr(),
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
                      "acc".tr(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: (){
                        widget.onTap();
                      },
                      child: Text(
                        "now".tr(),
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
