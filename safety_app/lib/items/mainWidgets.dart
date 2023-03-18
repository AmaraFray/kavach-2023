import 'package:flutter/material.dart';
import 'colors.dart' as colors;
import 'textStyles.dart' as textStyles;

class BottomNavBarUI extends StatefulWidget {
  const BottomNavBarUI({Key? key}) : super(key: key);

  @override
  State<BottomNavBarUI> createState() => _BottomNavBarUIState();
}

class _BottomNavBarUIState extends State<BottomNavBarUI> {
  int currenIndex_ = 3;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currenIndex_,
      iconSize: 30,
      backgroundColor: colors.bottomNavBarColor,
      onTap: (int index) {
        setState(() {
          currenIndex_ = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Status",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.phone_outlined),
          label: "Calls",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: "Communities",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: "Chats",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: "Settings",
        ),
      ],
      selectedItemColor: colors.primaryHighlight,
      unselectedItemColor: colors.lowGrey,
      selectedLabelStyle: textStyles.bottomNavBarText,
      unselectedLabelStyle: textStyles.bottomNavBarText,
      showUnselectedLabels: true,
    );
  }
}
