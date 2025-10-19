import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/students_page.dart';
import 'pages/drives_page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  // ❌ Remove const here – these pages are not const constructors
  final List<Widget> _pages = [
    DashboardPage(),
    StudentsPage(),
    DrivesPage(),
  ];

  final List<String> _titles = [
    "Dashboard",
    "Students",
    "Drives",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF2980B9),
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: 'Students'),
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outline), label: 'Drives'),
        ],
      ),
    );
  }
}
