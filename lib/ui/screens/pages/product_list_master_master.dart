import 'package:flutter/material.dart';

import '../../../core/colors.dart';

import '../../../../data/models/product/product_master_list_model.dart';



import '../masters/product_master/product_master_list_screen.dart';
import '../masters/sales_master/sales_list_page.dart';

class ProductListMasterMaster extends StatefulWidget {
  const ProductListMasterMaster({super.key});

  @override
  State<ProductListMasterMaster> createState() =>
      _ProductListMasterMasterState();
}

class _ProductListMasterMasterState extends State<ProductListMasterMaster> {
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

  // void _showAddEditBottomSheet(Info? unit) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true, // ensures full-screen height
  //     backgroundColor: white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) => Padding(
  //       padding: EdgeInsets.only(
  //         bottom: MediaQuery.of(context).viewInsets.bottom, // handle keyboard
  //       ),
  //       child: SizedBox(
  //         height:
  //             MediaQuery.of(context).size.height * 0.85, // almost full screen
  //         child: AddLocationMaster(
  //           unitInfo: unit,
  //           onSaved: (success) {
  //             Navigator.pop(context); // close sheet
  //             _onSaved(success);
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: lightgray,
      body: isMobile
          ? Padding(
              padding: const EdgeInsets.all(18.0),
              child: ProductMasterListScreen(
                refreshList: refreshList,
                onEdit: (country) {
                  // _showAddEditBottomSheet(
                  //     country as Info?); // ✅ open bottom sheet for edit
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
                    child: ProductMasterListScreen(
                      refreshList: refreshList,
                      onEdit: (country) {
                        setState(() {
                          editingUnit = country;
                          refreshList = false;
                        });
                      },
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
                //     child: AddLocationMaster(
                //       unitInfo: editingUnit,
                //       onSaved: _onSaved,
                //     ),
                //   ),
                // ),
              ],
            ),
      // floatingActionButton: isMobile
      //     ? FloatingActionButton.extended(
      //         backgroundColor: primary,
      //         foregroundColor: white,
      //         onPressed: () => _showAddEditBottomSheet(null), // ✅ Add Country
      //         label: const Text("Add Country"),
      //         icon: const Icon(Icons.add),
      //       )
      //     : null,
    );
  }
}
