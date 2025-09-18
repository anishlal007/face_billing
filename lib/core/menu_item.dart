import 'package:flutter/material.dart';

class MenuItemData {
  final String title;
  final IconData icon;
  final Widget? page; // <-- make this optional
  final List<MenuItemData>? subItems;

  MenuItemData({
    required this.title,
    required this.icon,
    this.page, // <-- no longer required
    this.subItems,
  });
}
