import 'package:flutter/material.dart';
import 'package:nmsastros/models/user/user_local.dart';
import 'package:nmsastros/screens/admin/admin_screen.dart';
import 'package:nmsastros/screens/profile/profile_list_screen.dart';
import 'package:nmsastros/tabbars/user_tab_page_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final List<Widget> _pages = [];
  int _currentIndex = 0;
  @override
  void initState() {
    _currentIndex = 0;
    _pages.add(
      const UserTabPageScreen(),
    );
    _pages.add(const AdminMain("Administração"));
    _pages.add(
      const ProfileListScreen(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pages,
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: "Administração",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Perfil do usuário",
          ),
        ],
      ),
    );
  }

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
