// ignore_for_file: must_be_immutable

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:learnify/screens/home/home_screen.dart';
import 'package:learnify/screens/home/enrolled_screen.dart';
import 'package:learnify/screens/home/profile_screen.dart';

class BottomNavbar extends StatefulWidget {
  String? choose;
   BottomNavbar({super.key,this.choose});

  @override
  State<BottomNavbar> createState() => _BottomNavBarState();
}

enum _SelectedTab { home, explore, save, profile }

class _BottomNavBarState extends State<BottomNavbar> {
  _SelectedTab _selectedTab = _SelectedTab.home;

  @override
  void initState() {
    if(widget.choose=="explore"){
      _selectedTab=_SelectedTab.explore;
    }
    super.initState();
  }

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = _SelectedTab.values[index];
    });
  }

  Widget _getSelectedScreen() {
    switch (_selectedTab) {
      case _SelectedTab.home:
        return const HomeScreen();
      case _SelectedTab.explore:
        return const HomeScreen();
      case _SelectedTab.save:
        return const EnrolledScreen();
      case _SelectedTab.profile:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _getSelectedScreen(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.2),
          onTap: _handleIndexChanged,
          items: [
            CrystalNavigationBarItem(
              icon: Icons.home,
              unselectedIcon: Icons.home,
              selectedColor: Colors.teal,
            ),
            CrystalNavigationBarItem(
              icon: Icons.explore,
              unselectedIcon: Icons.explore,
              selectedColor: Colors.teal,
            ),
            CrystalNavigationBarItem(
              icon: Icons.book_outlined,
              unselectedIcon: Icons.book_outlined,
              selectedColor: Colors.teal,
            ),
            CrystalNavigationBarItem(
              icon: Icons.person,
              unselectedIcon: Icons.person,
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
