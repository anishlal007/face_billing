import 'package:facebilling/ui/screens/masters/purchase/add_purchase_master_page.dart' show AddPurchaseMasterPage;
import 'package:flutter/material.dart';

import '../../../core/colors.dart';





import '../../../data/models/purchase_model/purchase_list_model.dart';
import '../masters/product_master/add_product_master_page.dart';
import '../masters/user_master/add_user_master_page.dart';
import '../masters/user_master/user_master_list_page.dart';



class PurchaseMasterPage extends StatefulWidget {
  const PurchaseMasterPage({super.key});

  @override
  State<PurchaseMasterPage> createState() =>
      _PurchaseMasterPageState();
}

class _PurchaseMasterPageState extends State<PurchaseMasterPage> {
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
          child: AddPurchaseMasterPage(
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
      body: isMobile
          ? Padding(
              padding: const EdgeInsets.all(18.0),
              child: UserMasterListPage(
                refreshList: refreshList,
                onEdit: (country) {
                  _showAddEditBottomSheet(
                      country as Info?); // ✅ open bottom sheet for edit
                },
              ),
            )
          : Row(
              children: [
               
                // Left side: Country list
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: AddPurchaseMasterPage(
                       unitInfo: editingUnit,
                       onSaved: _onSaved,
                     ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(color: gray, width: 1),
                const SizedBox(width: 20),
                // Right side: Add/Edit form
                // Expanded(
                //   flex: 5,
                //   child: Padding(
                //     padding: const EdgeInsets.all(18.0),
                //     child: AddPurchaseMasterPage(
                //       unitInfo: editingUnit,
                //       onSaved: _onSaved,
                //     ),
                //   ),
                // ),
           
              ],
            ),
      floatingActionButton: isMobile
          ? FloatingActionButton.extended(
              backgroundColor: primary,
              foregroundColor: white,
              onPressed: () => _showAddEditBottomSheet(null), // ✅ Add Country
              label: const Text("Add Country"),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }
}
