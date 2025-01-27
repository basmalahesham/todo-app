
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      decoration: BoxDecoration(
        color: provider.isDark() ? AppTheme.darkColor : AppTheme.lightColor,
        image: const DecorationImage(
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
            AppLocalizations.of(context)!.login,
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
                        AppLocalizations.of(context)!.welcome,
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
                        label: AppLocalizations.of(context)!.email,
                        hint:
                            AppLocalizations.of(context)!.enterYourEmailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterYourEmailAddress;
                          }
                          var regex = RegExp(
                              r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9]+\.[a-zA-Z0-9-.]+$)");
                          if (!regex.hasMatch(value)) {
                            return AppLocalizations.of(context)!
                                .enterValidEmailAddress;
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        label: AppLocalizations.of(context)!.password,
                        hint: AppLocalizations.of(context)!.enterYourPassword,
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
                            return AppLocalizations.of(context)!
                                .pleaseEnterYourPassword;
                          }
                          var regex = RegExp(
                              r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");
                          if (!regex.hasMatch(value)) {
                            return AppLocalizations.of(context)!
                                .enterValidPassword;
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
                            AppLocalizations.of(context)!.login,
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
                            AppLocalizations.of(context)!
                                .ifYouDontHaveAnAccount,
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
                            child: Text(
                              AppLocalizations.of(context)!.registration,
                              style: const TextStyle(
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

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        EasyLoading.show();
         await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage(
            AppLocalizations.of(context)!.youAreLoginSuccessfully);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeLayoutView.routeName, (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          SnackBarService.showErrorMessage(
              AppLocalizations.of(context)!.noUserFoundForThatEmail);
        } else if (e.code == 'wrong-password') {
          SnackBarService.showErrorMessage(
              AppLocalizations.of(context)!.wrongPasswordProvidedForThatUser);
        } else if (e.code == 'invalid-credential') {
          SnackBarService.showErrorMessage(
              AppLocalizations.of(context)!.invalidEmailOrPassword);
        }
      } catch (e) {
        SnackBarService.showErrorMessage('there was an error');
      }
      EasyLoading.dismiss();
      setState(() {});
    }
  }
}
