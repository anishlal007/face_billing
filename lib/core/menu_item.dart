import 'package:flutter/material.dart';


class MenuItemData {
  final String title;
  final IconData icon;
  final Widget? page;
  final List<MenuItemData>? subItems;

  MenuItemData({
    required this.title,
    required this.icon,
    this.page,
    this.subItems,
  });
}
