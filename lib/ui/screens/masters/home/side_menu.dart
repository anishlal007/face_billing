import 'package:flutter/material.dart';
import '../../../../core/colors.dart' hide Colors;
import '../../../../core/menu_item.dart';

class SideMenu extends StatelessWidget {
  final List<MenuItemData> menuItems;
  final int selectedParentIndex;
  final int? selectedSubIndex;
  final Function(int parentIndex, [int? subIndex]) onItemSelected;
  final bool isCollapsed;
  final Color primary;

  const SideMenu({
    super.key,
    required this.menuItems,
    required this.selectedParentIndex,
    required this.onItemSelected,
    this.selectedSubIndex,
    this.isCollapsed = false,
    this.primary = const Color.fromARGB(255, 20, 41, 84),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? 70 : 220,
      color: primary,
      child: isCollapsed ? _buildCollapsedMenu(context) : _buildExpandedMenu(context),
    );
  }

  /// 🔹 COLLAPSED MENU — only icons, popups for subitems
  Widget _buildCollapsedMenu(BuildContext context) {
    return ListView.builder(
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: IconButton(
            icon: Icon(item.icon, color: Colors.white),
            tooltip: item.title,
            onPressed: () async {
              if (item.subItems != null && item.subItems!.isNotEmpty) {
                // Show subitems on right side
                final subIndex = await showMenu<int>(
                  context: context,
                  position: const RelativeRect.fromLTRB(70, 80, 0, 0),
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
                if (subIndex != null) onItemSelected(index, subIndex);
              } else {
                onItemSelected(index);
              }
            },
          ),
        );
      },
    );
  }

  /// 🔹 EXPANDED MENU — full titles and expansion tiles
  Widget _buildExpandedMenu(BuildContext context) {
    return ListView.builder(
      itemCount: menuItems.length,
      itemBuilder: (context, parentIndex) {
        final item = menuItems[parentIndex];
        final isExpanded = selectedParentIndex == parentIndex;
        final isSelected = selectedParentIndex == parentIndex && selectedSubIndex == null;

        if (item.subItems != null && item.subItems!.isNotEmpty) {
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: isExpanded,
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              leading: Icon(item.icon, color: Colors.white),
              title: Text(item.title,
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
              trailing: const Icon(Icons.expand_more, color: Colors.white),
              children: [
                for (int subIndex = 0; subIndex < item.subItems!.length; subIndex++)
                  SizedBox(
                    width: double.infinity,
                    child: ListTile(
                      minLeadingWidth: 24,
                      dense: true,
                      leading: Icon(item.subItems![subIndex].icon,
                          size: 18, color: Colors.white),
                      title: Text(item.subItems![subIndex].title,
                          style: const TextStyle(color: Colors.white)),
                      onTap: () => onItemSelected(parentIndex, subIndex),
                    ),
                  ),
              ],
            ),
          );
        }

        return SizedBox(
          width: double.infinity,
          child: ListTile(
            minLeadingWidth: 24,
            leading: Icon(item.icon, color: Colors.white),
            title: Text(item.title, style: const TextStyle(color: Colors.white)),
            onTap: () => onItemSelected(parentIndex),
          ),
        );
      },
    );
  }
}
