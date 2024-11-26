import 'package:flutter/material.dart';
import 'package:untitled3/moduls/settings/settings_view.dart';
import 'package:untitled3/moduls/tasks_list/tasks_list_view.dart';

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
    var mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      body: screens[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
        color: Colors.white,
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
}
