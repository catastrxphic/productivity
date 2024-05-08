import 'package:blissfullden_app/pages/events/events_page.dart';
import 'package:blissfullden_app/pages/profile/profile_page.dart';
import 'package:blissfullden_app/pages/schedule/schedule_page.dart';
import 'package:blissfullden_app/pages/tasks/task_page.dart';
import 'package:blissfullden_app/pages/timing/timing_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget{
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    // Dashboard Page
    ProfilePage(),
    // Tasks Page
    MyHomePage(),
    // Events Page
    EventsPage(),
    // Timing Page
    TimingPage(),
    // Schedule Page
    SchedulePage(),
    // Profile Page
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to the Homepage")),
      body:  _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue, // Color of the selected item
        unselectedItemColor: Colors.black, // Color of the unselected items
        selectedLabelStyle: const TextStyle(color: Colors.blue), // Style of the selected label
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: [
          // Dashboard Page
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.black,),
            label: "Dashboard"
          ),
          // Tasks Page
          BottomNavigationBarItem(
            icon: Icon(Icons.task, color: Colors.black,),
            label: "Task Hub"
          ),
          // Events Page
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined, color: Colors.black,),
            label: "Events Hub"
          ),
          // Timing Page 
          BottomNavigationBarItem(
            icon: Icon(Icons.punch_clock_rounded, color: Colors.black,),
            label: "Timed Sessions"
          ),
          // Schedule Page
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_week, color: Colors.black,),
            label: "Schedule"
          ),
          // Profile page
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black,),
            label: "Profile"
          ),
        ],
      ),
    );
  }
}
