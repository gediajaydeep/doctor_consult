import 'package:consultations_app_test/application/presentation/main/view/widgets/app_bottom_navigation_bar.dart';
import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../chat/list/view/chat_list_screen.dart';
import '../../home/view/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      bottomNavigationBar: AppBottomNavigationBar(
        items: const [Icons.home, Icons.note_alt, Icons.chat, Icons.settings],
        onSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
      ),
      body: _getScreenFromIndex(_selectedIndex),
    );
  }

  _getScreenFromIndex(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return HomeScreen(
          onOpenChatScreen: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
        );
      case 2:
        return const ChatListScreen();
      default:
        return const SizedBox();
    }
  }
}
