import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/core/theme/app_theme.dart';
import 'package:untitled3/moduls/tasks_list/widgets/task_item_widget.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          width: mediaQuery.width,
          height: mediaQuery.height * 0.15,
          color: AppTheme.primaryColor,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 40, left: 20),
          child: Text(
            'To Do List',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
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
          monthColor: Colors.black,
          dayColor: Colors.black,
          activeDayColor: AppTheme.primaryColor,
          activeBackgroundDayColor: Colors.white,
          dotColor: AppTheme.primaryColor,
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemBuilder: (context, index) => const TaskItemWidget(),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
