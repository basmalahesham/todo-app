import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/network_layer/firestore_utils.dart';
import 'package:untitled3/core/theme/app_theme.dart';
import 'package:untitled3/moduls/tasks_list/widgets/task_item_widget.dart';
import 'package:untitled3/provider/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 40, left: 20),
          width: mediaQuery.width,
          height: mediaQuery.height * 0.15,
          color: AppTheme.primaryColor,
          child: Text(
            AppLocalizations.of(context)!.todolist,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 30)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate = date;
            setState(() {});
          },
          leftMargin: 20,
          monthColor: provider.isDark() ? Colors.white : Colors.black,
          dayColor: provider.isDark() ? Colors.white : Colors.black,
          activeDayColor:
              provider.isDark() ? Colors.white : AppTheme.primaryColor,
          activeBackgroundDayColor:
              provider.isDark() ? const Color(0xFF141922) : Colors.white,
          dotColor: provider.isDark() ? Colors.white : AppTheme.primaryColor,
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirestoreUtils.getRealTimeDataFromFirestore(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error Eccoured');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                );
              }
              var tasksList = snapshot.data?.docs.map((e) => e.data()).toList();
              return ListView.builder(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                itemBuilder: (context, index) => TaskItemWidget(
                  model: tasksList![index],
                ),
                itemCount: tasksList?.length ?? 0,
              );
            },
          ),
        ),
      ],
    );
  }
}
