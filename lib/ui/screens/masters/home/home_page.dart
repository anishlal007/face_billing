import 'package:facebilling/ui/screens/pages/location_master.dart';
import 'package:facebilling/ui/screens/pages/country_master.dart';
import 'package:facebilling/ui/screens/pages/purchase_master_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/menu_item.dart';
import '../../../../demo_page.dart';
import '../../../../google_sheet.dart';
import '../../pages/Unit_master.dart';
import '../../pages/area_master_page.dart';
import '../../pages/company_master_page.dart';
import '../../pages/customer_group_master_page.dart';
import '../../pages/customer_master_page.dart';
import '../../pages/dashboard_page.dart';
import '../../pages/finance_year_master.dart';
import '../../pages/generics_master_page.dart';
import '../../pages/hns_master_page.dart';
import '../../pages/item_group_master.dart';
import '../../pages/item_make_master.dart';
import '../../pages/item_make_master_page.dart';
import '../../pages/product_master_page.dart';
import '../../pages/sales_entry_page.dart';
import '../../pages/sales_order_entry_page.dart';
import '../../pages/state_master_page.dart';
import '../../pages/supplier_grpup_master_page.dart';
import '../../pages/supplier_master_page.dart';
import '../../pages/transactions_page.dart';
import '../../pages/tax_master_page.dart';
import '../../pages/user_master_page.dart';
import '../report_master/report_master_page.dart';
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
  int? _selectedSubIndex;
  bool _isMenuCollapsed = false;

  final List<MenuItemData> menuItems = [
    ///dashboard
    MenuItemData(
      title: "Dashboard",
      icon: Icons.dashboard,
      page: const DashboardPage(title: 'Dashboard',),
    ),
    ///appointment
    MenuItemData(
      title: "Appointment",
      icon: Icons.dashboard,
      page: const DemoPage(title: 'Appointment',),
      
    ),
    ///product
    MenuItemData(
      title: "Products",
      icon: Icons.dashboard,
   //   page: const DemoPage(title: 'Appointment',),
      subItems: [
         MenuItemData(
      title: "Product",
      icon: Icons.production_quantity_limits_rounded,
      page: const ProductMasterPage(),
    ),
           MenuItemData(
          title: "Group Master",
          icon: Icons.group,
          page: const ItemGroupMasterScreen(),
        ),
          MenuItemData(
          title: "Item make master",
          icon: Icons.ac_unit,
          page: const ItemMakeMasterPage(),
        ),
        MenuItemData(
          title: " Location Master",
          icon: Icons.ac_unit,
          page: const ItemLocationMasterScreen(),
        ),
          MenuItemData(
          title: "Generics Master",
          icon: Icons.money,
          page: const GenericsMasterPage(),
        ),
          MenuItemData(
          title: "Unit Master",
          icon: Icons.ac_unit,
          page: const UnitMasterScreen(),
        ),
          MenuItemData(
          title: "TAX Master",
          icon: Icons.ac_unit,
          page: const TaxMasterPage(),
        ),
        
      ]
      
    ),
  //purchase
    MenuItemData(
      title: "Purchase",
      icon: Icons.dashboard,
     // page: const DemoPage(title: 'Appointment',),
      subItems: [
  MenuItemData(
          title: "Supplier Master",
          icon: Icons.ac_unit,
          page: const SupplierMasterPage(),
        ),
          MenuItemData(
      title: "Purchase",
      icon: Icons.shopping_basket,
      page: const PurchaseMasterPage(),
    ),  MenuItemData(
      title: "Purchase Order",
      icon: Icons.shopping_basket,
      page: const DemoPage(title:"Purchase Order" ,),
    ),  MenuItemData(
      title: "Purchase Return",
      icon: Icons.shopping_basket,
       page: const DemoPage(title:"Purchase Return" ,),
    ),
      ]
    ),
    ///sales
     MenuItemData(
      title: "Sales",
      icon: Icons.account_balance,
      subItems: [
       MenuItemData(
          title: "Pataint Master",
          icon: Icons.person,
          page: const CustomerMasterPage(),
        ),MenuItemData(
      title: "Sales POS",
      icon: Icons.shopping_basket,
       page: const DemoPage(title:"Sales POS" ,),
    ),
    MenuItemData(
      title: "Sales Order",
      icon: Icons.shopping_basket,
       page: const DemoPage(title:"Sales Order" ,),
    ),
    MenuItemData(
      title: "Sales Return",
      icon: Icons.shopping_basket,
       page: const DemoPage(title:"Sales Return" ,),
    ),
    MenuItemData(
      title: "Wastage Entry",
      icon: Icons.shopping_basket,
       page: const DemoPage(title:"Wastage Entry" ,),
    ),MenuItemData(
      title: "Sales Person",
      icon: Icons.shopping_basket,
       page: const DemoPage(title:"Sales Person" ,),
    ), 
      ]
      ),
   ///general master
    MenuItemData(
      title: "General Master",
      icon: Icons.account_balance,
      subItems: [
         MenuItemData(
          title: "Area Master",
          icon: Icons.ac_unit,
          page: const AreaMasterPage(),
        ),
         MenuItemData(
          title: "Country Master",
          icon: Icons.savings,
          page: const CountryMasterScreen(),
        ),
             MenuItemData(
          title: "Supplier Group Master",
          icon: Icons.ac_unit,
          page: const SupplierGrpupMasterPage(),
        ),
      
        MenuItemData(
          title: "Customer Group Master",
          icon: Icons.person_3,
          page: const CustomerGroupMasterPage(),
        ),
      ]
      ),

   ///report
   MenuItemData(
      title: "Reports",
      icon: Icons.report,
      //page: ReportMasterPage(),
      subItems: [
    MenuItemData(
      title: "Purchase Report",
      icon: Icons.account_balance,
       //page: const DemoPage(title:"Expense Entry" ,),
       subItems: [
            MenuItemData(
      title: "Purchase Order Report",
      icon: Icons.account_balance,
       page: const DemoPage(title:"Purchase Order Report",),),
            MenuItemData(
      title: "Purchase Entry Report",
      icon: Icons.account_balance,
       page: const DemoPage(title:"Purchase Emtry Report",),),
       ]
       ),
      ]
    ),
   
     MenuItemData(
    title: "Reports",
    icon: Icons.report,
    subItems: [
      MenuItemData(
        title: "Purchase Report",
        icon: Icons.account_balance,
        subItems: [
          MenuItemData(
            title: "Purchase Order Report",
            icon: Icons.account_balance,
            page: const DemoPage(title: "Purchase Order Report"),
          ),
        ],
      ),
    ],
  ),
    
    MenuItemData(
      title: "Expense Entry",
      icon: Icons.account_balance,
       page: const DemoPage(title:"Expense Entry" ,),),
    MenuItemData(
      title: "Account Entry",
      icon: Icons.account_balance,
       page: const DemoPage(title:"Account Entry" ,),),
    MenuItemData(
      title: "Admin Setup",
      icon: Icons.account_balance,
       page: const DemoPage(title:"Admin Setup" ,),),
  
    MenuItemData(
      title: "Masters",
      icon: Icons.account_balance,
      subItems: [
       
        MenuItemData(
          title: "Group Master",
          icon: Icons.group,
          page: const ItemGroupMasterScreen(),
        ),
      
      
        MenuItemData(
          title: " Hsn Master",
          icon: Icons.ac_unit,
          page: const HnsMasterPage(),
        ),
      
      
        MenuItemData(
          title: "State Master",
          icon: Icons.ac_unit,
          page: const StateMasterPage(),
        ),
        MenuItemData(
          title: "Company Master",
          icon: Icons.ac_unit,
          page: const CompanyMasterPage(),
        ),
        MenuItemData(
          title: "User Master",
          icon: Icons.ac_unit,
          page: const UserMasterPage(),
        ),
        MenuItemData(
          title: "Finance Master",
          icon: Icons.ac_unit,
          page: const ItemLocationMasterScreen(),
        ),
      
   
        MenuItemData(
          title: "Finance Year Master",
          icon: Icons.money,
          page: const FinanceYearMaster(),
        ),
      
      ],
    ),
   
  
    
    MenuItemData(
      title: "Sales Entry",
      icon: Icons.report,
      page: SalesEntryPage(),
    ),
    MenuItemData(
      title: "Sales Order Entry",
      icon: Icons.report,
      page: SalesOrderEntryPage(),
    ),
    MenuItemData(
      title: "Transactions",
      icon: Icons.swap_horiz,
      page: const TransactionsPage(),
    ),
    MenuItemData(
      title: "Google sheet",
      icon: Icons.swap_horiz,
      page:  GoogleSheetUploadPage(),
    ),
  ];
Widget _getSelectedPage() {
  MenuItemData item = menuItems[_selectedParentIndex];

  if (_selectedSubIndex != null) {
    item = item.subItems![_selectedSubIndex!];
    
    // Check if there is further subItems and selectedSubIndex2 if you track it
    if (item.subItems != null && item.subItems!.isNotEmpty) {
      // If you want to go to the first subItem automatically
      item = item.subItems!.first;
    }
  }

  return item.page ?? Center(child: Text("Page not set"));
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
        isMenuCollapsed: _isMenuCollapsed,
        onToggleMenu: () {
          setState(() {
            _isMenuCollapsed = !_isMenuCollapsed;
          });
        },
      ),
      drawer: isMobile
          ? SideMenu(
              menuItems: menuItems,
              selectedParentIndex: _selectedParentIndex,
              selectedSubIndex: _selectedSubIndex,
              isCollapsed: false, // Drawer always full
              onItemSelected: (parentIndex, [subIndex]) {
                setState(() {
                  _selectedParentIndex = parentIndex;
                  _selectedSubIndex = subIndex;
                  Navigator.pop(context);
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
              isCollapsed: _isMenuCollapsed,
              onItemSelected: (parentIndex, [subIndex]) {
                setState(() {
                  _selectedParentIndex = parentIndex;
                  _selectedSubIndex = subIndex;
                });
              },
            ),
          Expanded(child: _getSelectedPage()),
        ],
      ),
    );
  }


}
