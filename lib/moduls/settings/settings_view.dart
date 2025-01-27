import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/moduls/login/login_view.dart';
import 'package:untitled3/moduls/settings/theme_bottom_sheet.dart';

import '../../core/theme/app_theme.dart';
import '../../provider/settings_provider.dart';
import 'language_bottom_sheet.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          alignment:
              provider.isEn() ? Alignment.centerLeft : Alignment.centerRight,
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          width: mediaQuery.width,
          height: mediaQuery.height * 0.15,
          color: AppTheme.primaryColor,
          child: Text(
            AppLocalizations.of(context)!.settings,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                InkWell(
                  onTap: () {
                    showLanguageBottomSheet();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 10,
                      right: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    height: 55,
                    decoration: BoxDecoration(
                      color: provider.isDark()
                          ? const Color(0xFF141922)
                          : Colors.white,
                      border: Border.all(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          provider.currentLocal == 'en'
                              ? AppLocalizations.of(context)!.english
                              : AppLocalizations.of(context)!.arabic,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppTheme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  AppLocalizations.of(context)!.mode,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                InkWell(
                  onTap: () {
                    showThemeBottomSheet();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 10,
                      right: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    height: 55,
                    decoration: BoxDecoration(
                      color: provider.isDark()
                          ? const Color(0xFF141922)
                          : Colors.white,
                      border: Border.all(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          provider.isDark()
                              ? AppLocalizations.of(context)!.dark
                              : AppLocalizations.of(context)!.light,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppTheme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginView.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.logout,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => const ThemeBottomSheet(),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => const LanguageBottomSheet(),
    );
  }
}
