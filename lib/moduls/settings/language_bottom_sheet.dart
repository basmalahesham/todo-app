import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/theme/app_theme.dart';

import '../../provider/settings_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: provider.isDark() ? const Color(0xFF141922) : Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              provider.changeLanguage("en");
            },
            child: provider.currentLocal == 'en'
                ? getSelectItem(AppLocalizations.of(context)!.english)
                : getUnselectedItem(
                    AppLocalizations.of(context)!.english,
                  ),
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              provider.changeLanguage("ar");
            },
            child: provider.currentLocal == 'ar'
                ? getSelectItem(AppLocalizations.of(context)!.arabic)
                : getUnselectedItem(
                    AppLocalizations.of(context)!.arabic,
                  ),
          ),
        ],
      ),
    );
  }

  Widget getSelectItem(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.check,
            color: Theme.of(context).canvasColor,
          ),
        ],
      ),
    );
  }

  Widget getUnselectedItem(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}
