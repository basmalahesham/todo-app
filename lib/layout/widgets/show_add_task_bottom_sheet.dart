import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/network_layer/firestore_utils.dart';
import 'package:untitled3/core/services/snackbar_service.dart';
import 'package:untitled3/core/theme/app_theme.dart';
import 'package:untitled3/core/utils/my_date_time.dart';
import 'package:untitled3/models/task_model.dart';
import 'package:untitled3/provider/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //TextEditingController dueDateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  //var valid = true;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: provider.isDark() ? const Color(0xFF141922) : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.addNewTask,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: provider.isDark() ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.001,
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
                  height: mediaQuery.height * 0.001,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.enterYourTaskTitle;
                    } else if (value.length < 8) {
                      return AppLocalizations.of(context)!
                          .titleMustBeAtLeastCharacters;
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                      color: provider.isDark() ? Colors.white : Colors.black),
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
                  height: mediaQuery.height * 0.001,
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .descriptionCantBeEmpty;
                    } else {
                      return null;
                    }
                  },
                  minLines: 2,
                  maxLines: 2,
                  style: TextStyle(
                      color: provider.isDark() ? Colors.white : Colors.black),
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
                  height: mediaQuery.height * 0.001,
                ),
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.selectTime} :',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: provider.isDark() ? Colors.white : Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectDateTime();
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
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  onPressed: () {
                    addTask();
                    /*if (formKey.currentState!.validate()) {
                      setState(
                            () => valid = true,
                      );
                      EasyLoading.show();
                      FirebaseUtils.addTaskToFirestore(
                        TaskModel(
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          selectedDate: externalDateOnly(selectedDate),
                        ),
                      ).then(
                            (value) {
                          //provider.changeDate(selectedDate);
                          Navigator.pop(context);
                          EasyLoading.dismiss();
                        },
                      );
                    } else {
                      setState(
                            () => valid = false,
                      );
                    }*/
                  },
                  child: Text(
                    AppLocalizations.of(context)!.addTask,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectDateTime() async {
    // select date
    // day month year
    var currentDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (currentDate == null) {
      return;
    }
    selectedDate = currentDate;
    setState(() {});
  }

  void addTask() async {
    if (formKey.currentState!.validate()) {
      TaskModel taskModel = TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        isDone: false,
        selectedDate: externalDateOnly(selectedDate),
        //dateTime: (externalDateOnly(selectedDate)).millisecondsSinceEpoch,
      );
      try {
        EasyLoading.show();
        await FirebaseUtils.addTaskToFirestore(taskModel);
        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage(
            AppLocalizations.of(context)!.taskAddedSuccessfully);
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage(
            AppLocalizations.of(context)!.taskAddedFailed);
        Navigator.pop(context);
      }
    }
  }
}
