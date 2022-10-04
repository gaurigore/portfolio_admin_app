import 'package:flutter/material.dart';

import 'bottom_navigation_bar_controller.dart';

class BottomNavigationBarView extends StatelessWidget {
  const BottomNavigationBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 2,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex:BottomNavigationBarController.selectedIndex.value,
      onTap: BottomNavigationBarController.onChanged,

      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.chat,
                size: 34,
                color: BottomNavigationBarController.selectedIndex.value == 0
                    ? Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor
                    : Theme.of(context).iconTheme.color),
            label: "chat"),
        BottomNavigationBarItem(
            icon: Icon(Icons.topic,
                size: 34,
                color: BottomNavigationBarController.selectedIndex.value == 1
                    ? Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor
                    : Theme.of(context).iconTheme.color),
            label: "project"),
        BottomNavigationBarItem(
            icon: Icon(Icons.computer,
                size: 34,
                color: BottomNavigationBarController.selectedIndex.value == 2
                    ? Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor
                    : Theme.of(context).iconTheme.color),
            label: "skills"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,
                size: 34,
                color: BottomNavigationBarController.selectedIndex.value == 3
                    ? Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor
                    : Theme.of(context).iconTheme.color),
            label: "profile"),
      ],
    );
  }
}
