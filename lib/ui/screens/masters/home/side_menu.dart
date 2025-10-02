import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/menu_item.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final List<MenuItemData> menuItems;
  final int selectedParentIndex;
  final int? selectedSubIndex;
  final Function(int parentIndex, [int? subIndex]) onItemSelected;
  final bool isCollapsed;

  const SideMenu({
    super.key,
    required this.menuItems,
    required this.selectedParentIndex,
    required this.onItemSelected,
    this.selectedSubIndex,
    this.isCollapsed = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isCollapsed ? 70 : 220,
      color: white,
      child: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, parentIndex) {
          final item = menuItems[parentIndex];
          final isParentSelected =
              selectedParentIndex == parentIndex && selectedSubIndex == null;

          // 🔹 COLLAPSED MODE
          if (isCollapsed) {
            if (item.subItems != null && item.subItems!.isNotEmpty) {
              // Show popup when clicking parent icon
              return IconButton(
                icon:
                    Icon(item.icon, color: isParentSelected ? primary : black),
                tooltip: item.title,
                onPressed: () async {
                  final subIndex = await showMenu<int>(
                    context: context,
                    position: const RelativeRect.fromLTRB(80, 100, 0, 0),
                    items: [
                      for (int i = 0; i < item.subItems!.length; i++)
                        PopupMenuItem<int>(
                          value: i,
                          child: Row(
                            children: [
                              Icon(item.subItems![i].icon, size: 18),
                              const SizedBox(width: 8),
                              Text(item.subItems![i].title),
                            ],
                          ),
                        ),
                    ],
                  );

                  if (subIndex != null) {
                    onItemSelected(parentIndex, subIndex);
                  }
                },
              );
            } else {
              // Parent without subItems → normal tap
              return IconButton(
                icon:
                    Icon(item.icon, color: isParentSelected ? primary : black),
                tooltip: item.title,
                onPressed: () => onItemSelected(parentIndex),
              );
            }
          }

          // 🔹 EXPANDED MODE
          if (item.subItems != null && item.subItems!.isNotEmpty) {
            final isExpanded = selectedParentIndex == parentIndex;
            return ExpansionTile(
              initiallyExpanded: isExpanded,
              leading: Icon(item.icon),
              title: Text(item.title),
              children: [
                for (int subIndex = 0;
                    subIndex < item.subItems!.length;
                    subIndex++)
                  ListTile(
                    leading: Icon(item.subItems![subIndex].icon, size: 18),
                    title: Text(item.subItems![subIndex].title),
                    selected: selectedParentIndex == parentIndex &&
                        selectedSubIndex == subIndex,
                    onTap: () => onItemSelected(parentIndex, subIndex),
                  ),
              ],
            );
          }

          return ListTile(
            leading: Icon(item.icon),
            title: Text(
              item.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            selected: isParentSelected,
            onTap: () => onItemSelected(parentIndex),
          );
        },
      ),
    );
  }
}
