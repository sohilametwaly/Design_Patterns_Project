import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:design_patterns_project/Manager/reports.dart';
import 'package:design_patterns_project/Room_list_screen.dart';
import 'package:design_patterns_project/view-resident.dart';
import 'package:design_patterns_project/workerList.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final bool isManager;
  final Manager manager;
  const NavBar({super.key,required this.isManager, required this.manager});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
 
    final List<Widget> managerPages = [
      WorkerListPage(manager: widget.manager),
      RoomListScreen(manager: widget.manager),
      viewResidentListPage(manager: widget.manager),
      IncomeReportPage(manager: widget.manager),
    ];


    final List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Workers'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.meeting_room), label: 'Rooms'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person), label: 'Residents'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.attach_money), label: 'Reports'),
    ];

    return Scaffold(
      body: managerPages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        items: navItems,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
