import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/network_layer/firestore_utils.dart';
import 'package:untitled3/core/services/snackbar_service.dart';
import 'package:untitled3/core/theme/app_theme.dart';
import 'package:untitled3/core/widgets/custom_text_form_field.dart';
import 'package:untitled3/moduls/login/login_view.dart';
import 'package:untitled3/provider/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  bool isPasswordObscure = true;
  bool isConfirmationPasswordObscure = true;

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
            AppLocalizations.of(context)!.createAnAccount,
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
                  top: mediaQuery.height * 0.02,
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
                        label: AppLocalizations.of(context)!.fullName,
                        hint: AppLocalizations.of(context)!.enterYourFullName,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterYourName;
                          }
                          if (value.trim().length < 6) {
                            return AppLocalizations.of(context)!
                                .yourNameMustBeAtLeastCharacters;
                          }
                          return null;
                        },
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
                        obscureText: isPasswordObscure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            isPasswordObscure = !isPasswordObscure;
                            setState(() {});
                          },
                          icon: Icon(
                            isPasswordObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
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
                      CustomTextFormField(
                        controller: confirmPasswordController,
                        label: AppLocalizations.of(context)!.confirmPassword,
                        hint: AppLocalizations.of(context)!
                            .enterYourConfirmationPassword,
                        obscureText: isPasswordObscure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            isConfirmationPasswordObscure =
                                !isConfirmationPasswordObscure;
                            setState(() {});
                          },
                          icon: Icon(
                            isConfirmationPasswordObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterYourConfirmationPassword;
                          }
                          if (passwordController.text != value) {
                            return AppLocalizations.of(context)!
                                .enterCorrectPasswordPasswordNotMatch;
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            register(context);
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.registration,
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
                            AppLocalizations.of(context)!.alreadyHaveAnAccount,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: provider.isDark()
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginView.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(
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

  void register(BuildContext context) {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      FirebaseUtils.createAccount(
        nameController.text,
        emailController.text,
        passwordController.text,
        context,
      ).then(
        (value) {
          if (value) {
            EasyLoading.dismiss();
            SnackBarService.showSuccessMessage(
                AppLocalizations.of(context)!.aVerificationMessageHasBeenSent);
            Navigator.pop(context);
          }
        },
      );
    }
  }
}
