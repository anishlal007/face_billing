import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/menu_item.dart';

class SideMenu extends StatelessWidget {
  final List<MenuItemData> menuItems;
  final int selectedParentIndex;
  final int? selectedSubIndex;
  final Function(int parentIndex, [int? subIndex]) onItemSelected;

  const SideMenu({
    super.key,
    required this.menuItems,
    required this.selectedParentIndex,
    required this.onItemSelected,
    this.selectedSubIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        width: 220,
        color: white,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, parentIndex) {
              final item = menuItems[parentIndex];
              final isParentSelected = selectedParentIndex == parentIndex &&
                  selectedSubIndex == null;

              // Has sub-items → Expandable list
              if (item.subItems != null && item.subItems!.isNotEmpty) {
                final isExpanded = selectedParentIndex == parentIndex;

                return ExpansionTile(
                  initiallyExpanded: isExpanded,
                  leading: Icon(item.icon),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontWeight:
                          isExpanded ? FontWeight.bold : FontWeight.normal,
                      color: isExpanded ? primary : black,
                    ),
                  ),
                  children: [
                    for (int subIndex = 0;
                        subIndex < item.subItems!.length;
                        subIndex++)
                      Container(
                        color: (selectedParentIndex == parentIndex &&
                                selectedSubIndex == subIndex)
                            ? primary
                            : transperent,
                        child: ListTile(
                          leading: Icon(
                            item.subItems![subIndex].icon,
                            size: 18,
                            color: (selectedParentIndex == parentIndex &&
                                    selectedSubIndex == subIndex)
                                ? white
                                : black,
                          ),
                          title: Text(
                            item.subItems![subIndex].title,
                            style: TextStyle(
                              fontSize: 14,
                              color: (selectedParentIndex == parentIndex &&
                                      selectedSubIndex == subIndex)
                                  ? white
                                  : black,
                            ),
                          ),
                          selected: selectedParentIndex == parentIndex &&
                              selectedSubIndex == subIndex,
                          selectedTileColor: primary,
                          onTap: () => onItemSelected(parentIndex, subIndex),
                        ),
                      ),
                  ],
                );
              }

              // Normal item (no subItems)
              return Container(
                color: isParentSelected ? primary : transperent,
                child: ListTile(
                  leading:
                      Icon(item.icon, color: isParentSelected ? white : black),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      color: isParentSelected ? white : black,
                    ),
                  ),
                  selected: isParentSelected,
                  onTap: () => onItemSelected(parentIndex),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
