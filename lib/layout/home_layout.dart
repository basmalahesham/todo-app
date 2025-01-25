import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/layout/widgets/show_add_task_bottom_sheet.dart';
import 'package:untitled3/moduls/settings/settings_view.dart';
import 'package:untitled3/moduls/tasks_list/tasks_list_view.dart';
import 'package:untitled3/provider/settings_provider.dart';

class HomeLayoutView extends StatefulWidget {
  const HomeLayoutView({super.key});
  static const String routeName = "home_layout";

  @override
  State<HomeLayoutView> createState() => _HomeLayoutViewState();
}

class _HomeLayoutViewState extends State<HomeLayoutView> {
  int selectedIndex = 0;

  List<Widget> screens = [
    const TasksListView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      body: screens[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTasksBottomSheet();
        },
        elevation: 5,
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        height: mediaQuery.height * .093,
        padding: EdgeInsets.zero,
        notchMargin: 8,
        color: provider.isDark() ? const Color(0xFF141922) : Colors.white,
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "settings"),
          ],
        ),
      ),
    );
  }

  showAddTasksBottomSheet() {
    showModalBottomSheet(
      context: context,
      //isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => const AddTaskBottomSheet(),
    );
  }
}
