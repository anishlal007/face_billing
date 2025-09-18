import 'package:facebilling/ui/screens/pages/Item_location_master.dart';
import 'package:facebilling/ui/screens/pages/country_master.dart';
import 'package:flutter/material.dart';
import '../../../../core/menu_item.dart';
import '../../pages/Unit_master.dart';
import '../../pages/dashboard_page.dart';
import '../../pages/item_group_master.dart';
import '../../pages/item_make_master.dart';
import '../../pages/transactions_page.dart';
import 'side_menu.dart';
import 'top_navbar.dart';
import 'home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedParentIndex = 0;
  int? _selectedSubIndex; // null means no sub-item selected

  final List<MenuItemData> menuItems = [
    MenuItemData(
      title: "Dashboard",
      icon: Icons.dashboard,
      page: const DashboardPage(),
    ),
    MenuItemData(
      title: "Masters",
      icon: Icons.account_balance,
      subItems: [
        MenuItemData(
          title: "Country Master",
          icon: Icons.savings,
          page: const CountryMasterScreen(),
        ),
        MenuItemData(
          title: "Group Master",
          icon: Icons.group,
          page: const ItemGroupMasterScreen(),
        ),
        MenuItemData(
          title: "Unit Master",
          icon: Icons.ac_unit,
          page: const UnitMasterScreen(),
        ),
        MenuItemData(
          title: "Item make master",
          icon: Icons.ac_unit,
          page: const ItemMakeMasterScreen(),
        ),
        MenuItemData(
          title: " Location Master",
          icon: Icons.ac_unit,
          page: const ItemLocationMasterScreen(),
        ),
      ],
    ),
    MenuItemData(
      title: "Transactions",
      icon: Icons.swap_horiz,
      page: const TransactionsPage(),
    ),
  ];

  Widget _getSelectedPage() {
    final parent = menuItems[_selectedParentIndex];

    if (_selectedSubIndex != null &&
        parent.subItems != null &&
        _selectedSubIndex! < parent.subItems!.length) {
      return parent.subItems![_selectedSubIndex!].page ??
          const Center(child: Text("No page available"));
    }

    return parent.page ?? const Center(child: Text("No page available"));
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: TopNavBar(
        title: _selectedSubIndex != null
            ? menuItems[_selectedParentIndex]
                .subItems![_selectedSubIndex!]
                .title
            : menuItems[_selectedParentIndex].title,
      ),
      drawer: isMobile
          ? SideMenu(
              menuItems: menuItems,
              selectedParentIndex: _selectedParentIndex,
              selectedSubIndex: _selectedSubIndex,
              onItemSelected: (parentIndex, [subIndex]) {
                setState(() {
                  _selectedParentIndex = parentIndex;
                  _selectedSubIndex = subIndex;
                });
              },
            )
          : null,
      body: Row(
        children: [
          if (!isMobile)
            SideMenu(
              menuItems: menuItems,
              selectedParentIndex: _selectedParentIndex,
              selectedSubIndex: _selectedSubIndex,
              onItemSelected: (parentIndex, [subIndex]) {
                setState(() {
                  _selectedParentIndex = parentIndex;
                  _selectedSubIndex = subIndex;
                });
              },
            ),
          Expanded(child: HomeBody(page: _getSelectedPage())),
        ],
      ),
    );
  }
}
