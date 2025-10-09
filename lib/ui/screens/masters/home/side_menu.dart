import 'package:flutter/material.dart';
import '../../../../core/colors.dart' hide Colors;
import '../../../../core/menu_item.dart';

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
      color: primary,
      child: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, parentIndex) {
          final item = menuItems[parentIndex];
          final isExpanded = selectedParentIndex == parentIndex;

          // 🔹 COLLAPSED MENU
          if (isCollapsed) {
            if (item.subItems != null && item.subItems!.isNotEmpty) {
              return IconButton(
                icon: Icon(item.icon, color: Colors.white),
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
                  if (subIndex != null) onItemSelected(parentIndex, subIndex);
                },
              );
            } else {
              return IconButton(
                icon: Icon(item.icon, color: Colors.white),
                tooltip: item.title,
                onPressed: () => onItemSelected(parentIndex),
              );
            }
          }

          // 🔹 EXPANDED MENU (with white dropdown icon)
          if (item.subItems != null && item.subItems!.isNotEmpty) {
            return Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: isExpanded,
                iconColor: Colors.white, // <-- makes dropdown arrow white
                collapsedIconColor: Colors.white, // <-- also white when collapsed
                leading: Icon(item.icon, color: Colors.white),
                title: Text(
                  item.title,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.expand_more, color: Colors.white), // <-- custom white arrow
                children: [
                  for (int subIndex = 0; subIndex < item.subItems!.length; subIndex++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: (selectedParentIndex == parentIndex &&
                                  selectedSubIndex == subIndex)
                              ? Colors.white.withOpacity(0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          dense: true,
                          leading: Icon(
                            item.subItems![subIndex].icon,
                            size: 18,
                            color: Colors.white,
                          ),
                          title: Text(
                            item.subItems![subIndex].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () => onItemSelected(parentIndex, subIndex),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }

          // 🔹 PARENT ITEM (no subitems)
          final isSelected =
              selectedParentIndex == parentIndex && selectedSubIndex == null;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                leading: Icon(item.icon, color: Colors.white),
                title: Text(
                  item.title,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () => onItemSelected(parentIndex),
              ),
            ),
          );
        },
      ),
    );
  }
}