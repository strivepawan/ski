import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex; // Index of the currently selected item
  final List<Widget> children; // List of icons for each navigation item
  final Function(int) onTap; // Callback function for handling item taps

  const BottomNavBar({
    required this.currentIndex,
    required this.children,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Fixed number of items
      selectedItemColor: Colors.blue, // Color of the selected item
      unselectedItemColor: Colors.grey, // Color of unselected items
      currentIndex: currentIndex, // Set the currently selected item
      items: children.asMap().entries.map((entry) {
        int index = entry.key;
        Widget child = entry.value;
        return BottomNavigationBarItem(
          icon: child,
          label: '', // Remove labels for cleaner look (optional)
        );
      }).toList(),
      onTap: onTap,
    );
  }
}
