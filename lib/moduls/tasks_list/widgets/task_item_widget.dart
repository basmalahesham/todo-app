import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/network_layer/firestore_utils.dart';
import 'package:untitled3/core/theme/app_theme.dart';
import 'package:untitled3/models/task_model.dart';
import 'package:untitled3/moduls/edit/edit_view.dart';
import 'package:untitled3/provider/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItemWidget extends StatefulWidget {
  final TaskModel model;

  // final String title;
  // final String description;
  const TaskItemWidget({super.key, required this.model});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.4,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: provider.isEn()
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    )
                  : BorderRadius.zero,
              onPressed: (context) {
                FirebaseUtils.deleteTask(widget.model);
                //FirestoreUtils.deleteData(widget.model);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              borderRadius: provider.isEn()
                  ? BorderRadius.zero
                  : const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
              onPressed: (context) {
                Navigator.pushNamed(
                  context,
                  EditView.routeName,
                  arguments: widget.model,
                );
              },
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: provider.isDark() ? const Color(0xFF141922) : Colors.white,
            borderRadius: BorderRadius.only(
              bottomRight: provider.isEn()
                  ? const Radius.circular(15)
                  : const Radius.circular(0),
              topRight: provider.isEn()
                  ? const Radius.circular(15)
                  : const Radius.circular(0),
              bottomLeft: provider.isEn()
                  ? const Radius.circular(0)
                  : const Radius.circular(15),
              topLeft: provider.isEn()
                  ? const Radius.circular(0)
                  : const Radius.circular(15),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 4,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: widget.model.isDone
                      ? Colors.green
                      : AppTheme.primaryColor,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: Text(
                      widget.model.title,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: widget.model.isDone
                            ? Colors.green
                            : AppTheme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: Text(
                      widget.model.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: provider.isDark() ? Colors.white : Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 20,
                        color: provider.isDark() ? Colors.white : Colors.black,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        (DateFormat.yMMMEd().format(selectedDate)),
                        style: GoogleFonts.roboto(
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  FirebaseUtils.isDoneTask(widget.model);
                  setState(() {});
                },
                child: widget.model.isDone
                    ? Text(
                        AppLocalizations.of(context)!.done,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppTheme.primaryColor,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
