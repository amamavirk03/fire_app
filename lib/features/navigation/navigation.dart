import 'package:fire_app/features/home/views/homeScreen.dart';
import 'package:fire_app/features/postscreen/views/postscreen.dart';
import 'package:fire_app/features/profilescreen/profilescreen.dart';
import 'package:fire_app/features/saved/saved.dart';
import 'package:fire_app/features/search/search.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  final String token;

  const MainNavigation({super.key, required this.token});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const SearchScreen(),
      PostScreen(token: widget.token), // Pass token to PostScreen
      const SavedScreen(),
      const ProfilePageScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: TColors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: TColors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
