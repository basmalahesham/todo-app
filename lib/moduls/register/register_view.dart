import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/services/snackbar_service.dart';
import 'package:untitled3/core/theme/app_theme.dart';
import 'package:untitled3/core/widgets/custom_text_form_field.dart';
import 'package:untitled3/moduls/login/login_view.dart';
import 'package:untitled3/provider/settings_provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static const String routeName = "register_screen";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //String name = '';
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Create Account',
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
                  top: mediaQuery.height * 0.03,
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
                      CustomTextFormField(
                        controller: nameController,
                        label: 'Full Name',
                        hint: 'Enter your Full Name',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          if (value.trim().length < 6) {
                            return 'your name must be at least 6 characters';
                          }
                          return null;
                        },
                        /*onChanged: (value){
                    name = value;
                    print(name);
                  },*/
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
                      CustomTextFormField(
                        controller: confirmPasswordController,
                        label: 'Confirm Password',
                        hint: 'Enter your confirmation password',
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
                            return 'Please enter your confirmation password';
                          }
                          if (passwordController.text != value) {
                            return 'enter correct password, password not match';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            register();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: provider.isDark() ? Colors.white : Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginView.routeName);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
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
}
