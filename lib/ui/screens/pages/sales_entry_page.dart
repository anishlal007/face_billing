import 'package:facebilling/ui/screens/entrys/purchase/add_purchase_master_page.dart'
    show AddSalesEntryMasterPage;
import 'package:flutter/material.dart';

import '../../../core/colors.dart';

import '../../../data/models/purchase_model/purchase_list_model.dart';
import '../masters/product_master/add_product_master_page.dart';
import '../masters/sales_master/add_sales_entry_master_page.dart';
import '../masters/user_master/add_user_master_page.dart';
import '../masters/user_master/user_master_list_page.dart';

class SalesEntryPage extends StatefulWidget {
  const SalesEntryPage({super.key});

  @override
  State<SalesEntryPage> createState() => _SalesEntryPageState();
}

class _SalesEntryPageState extends State<SalesEntryPage> {
  Info? editingUnit;
  bool refreshList = false;

  void _onSaved(bool success) {
    if (success) {
      setState(() {
        editingUnit = null; // reset after save
        refreshList = true; // trigger reload
      });
    }
  }

  void _showAddEditBottomSheet(Info? unit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ensures full-screen height
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // handle keyboard
        ),
        child: SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.85, // almost full screen
          child: AddSalesEntryMasterPage(
            unitInfo: unit,
            onSaved: (success) {
              Navigator.pop(context); // close sheet
              _onSaved(success);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: lightgray,
      body: AddSalesEntryMasterPage(
        unitInfo: editingUnit,
        onSaved: _onSaved,
      ),
    );
  }
}
