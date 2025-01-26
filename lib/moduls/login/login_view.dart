import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/services/snackbar_service.dart';
import 'package:untitled3/core/theme/app_theme.dart';
import 'package:untitled3/core/widgets/custom_text_form_field.dart';
import 'package:untitled3/layout/home_layout.dart';
import 'package:untitled3/moduls/register/register_view.dart';
import 'package:untitled3/provider/settings_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String routeName = "login_screen";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //String name = '';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFDFECDB),
        image: DecorationImage(
          image: AssetImage(
            'assets/images/SIGN IN – 1.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Login',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  top: mediaQuery.height * 0.06,
                  left: 20,
                  right: 20,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: mediaQuery.height * 0.2,
                      ),
                      Text(
                        'Welcome back!',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.015,
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        label: 'Email Address',
                        hint: 'Enter your email address',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email address';
                          }
                          var regex = RegExp(
                              r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9]+\.[a-zA-Z0-9-.]+$)");
                          if (!regex.hasMatch(value)) {
                            return 'enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        label: 'Password',
                        hint: 'Enter your Password',
                        obscureText: isObscure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            isObscure = !isObscure;
                            setState(() {});
                          },
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your password';
                          }
                          var regex = RegExp(
                              r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");
                          if (!regex.hasMatch(value)) {
                            return 'enter a valid password';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "if you don't have an account?.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: provider.isDark()
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterView.routeName);
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.normal,
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
          ],
        ),
      ),
    );
  }

  void register() async {
    // print(nameController.text);
    // formKey.currentState?.validate();
    if (formKey.currentState!.validate()) {
      // authenticate with firebase
      try {
        EasyLoading.show();
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        log(userCredential.user as String);
        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage(
            'The account was registered successfully');
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'The password provided is too weak.');
          log('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'The account already exists for that email.');
          log('The account already exists for that email.');
        }
      } catch (e) {
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage(
            'no network please check internet connection');
        log(e as String);
      }
    }
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        EasyLoading.show();
        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage('you are login successfully');
        Navigator.pushNamedAndRemoveUntil(
            context, HomeLayoutView.routeName, (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'Wrong password provided for that user.');
        }
      }
    }
  }
}
