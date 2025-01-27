import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/network_layer/firestore_utils.dart';
import 'package:untitled3/core/theme/app_theme.dart';
import 'package:untitled3/models/task_model.dart';
import 'package:untitled3/provider/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditView extends StatefulWidget {
  const EditView({
    super.key,
  });

  static const String routeName = 'edit_screen';

  // final TaskModel model;

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    var args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 40, left: 20),
            width: mediaQuery.width,
            height: mediaQuery.height * 0.15,
            color: AppTheme.primaryColor,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.todolist,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            height: mediaQuery.height * 0.7,
            decoration: BoxDecoration(
              color: provider.isDark() ? const Color(0xFF141922) : Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.editTasks,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: provider.isDark() ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.002,
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: provider.isDark() ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.01,
                ),
                TextFormField(
                  initialValue: args.title,
                  onChanged: (value) {
                    args.title = value;
                  },
                  //controller: titleController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.titleCantBeEmpty;
                    } else if (value.length < 8) {
                      return AppLocalizations.of(context)!
                          .titleMustBeAtLeastCharacters;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterYourTaskTitle,
                    hintStyle: TextStyle(
                      color: provider.isDark() ? Colors.white : Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.01,
                ),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: provider.isDark() ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.01,
                ),
                TextFormField(
                  initialValue: args.description,
                  onChanged: (value) {
                    args.description = value;
                  },
                  //controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .descriptionCantBeEmpty;
                    } else {
                      return null;
                    }
                  },
                  minLines: 3,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)!.enterYourTaskDescription,
                    hintStyle: TextStyle(
                      color: provider.isDark() ? Colors.white : Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.01,
                ),
                Text(
                  AppLocalizations.of(context)!.selectTime,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: provider.isDark() ? Colors.white : Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.fromMillisecondsSinceEpoch(
                                args.dateTime!),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now()
                                .add(const Duration(days: 365))) ??
                        DateTime.now();
                    setState(() {
                      args.dateTime = selectedDate.millisecondsSinceEpoch;
                    });
                  },
                  child: Text(
                    (DateFormat.yMMMEd().format(selectedDate)),
                    //"${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.08,
                ),
                ElevatedButton(
                  onPressed: () {
                    FirestoreUtils.updateTask(args);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.saveChanges,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
