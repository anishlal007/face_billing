import 'package:flutter/material.dart';

import '../../../core/colors.dart';

import '../../../data/models/product/product_master_list_model.dart';
import '../../../data/services/product_service.dart';
import '../masters/product_master/add_product_master_page.dart';
import '../masters/user_master/add_user_master_page.dart';
import '../masters/user_master/user_master_list_page.dart';

class ProductMasterPage extends StatefulWidget {
  const ProductMasterPage({super.key});

  @override
  State<ProductMasterPage> createState() => _ProductMasterPageState();
}

class _ProductMasterPageState extends State<ProductMasterPage> {
  final ProductService _service = ProductService();
  Info? editingUnit;
  bool refreshList = false;
 bool isLoading = false;
  String message = '';

  

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
          child: AddProductMasterPage(
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
      appBar: AppBar(
      backgroundColor: white,
      title: Row(
        children: [
          Text("FaceBilling", style: const TextStyle(color: black)),
          const SizedBox(width: 30),
          
        ],
      ),
      actions: [
        ElevatedButton.icon(
  icon: Icon(Icons.upload_file),
  label: Text('Upload Excel File'),
  onPressed: () async {
    setState(() => isLoading = true);

    final response = await _service.uploadProductExcelFile();

    setState(() {
      isLoading = false;
      message = response.data == true
          ? '✅ Products uploaded successfully!'
          : '❌ Upload failed: ${response.error}';
    });
  },
),

      ],
    ),
      body: AddProductMasterPage(
        unitInfo: editingUnit,
        onSaved: _onSaved,
      ),
    );

    //   isMobile
    //       ? Padding(
    //           padding: const EdgeInsets.all(18.0),
    //           child: UserMasterListPage(
    //             refreshList: refreshList,
    //             onEdit: (country) {
    //               _showAddEditBottomSheet(
    //                   country as Info?); // ✅ open bottom sheet for edit
    //             },
    //           ),
    //         )
    //       : Row(
    //           children: [

    //             // Left side: Country list
    //             Expanded(
    //               flex: 5,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(18.0),
    //                 child: AddProductMasterPage(
    //                    unitInfo: editingUnit,
    //                    onSaved: _onSaved,
    //                  ),
    //               ),
    //             ),
    //             const SizedBox(width: 20),
    //             Container(color: gray, width: 1),
    //             const SizedBox(width: 20),

    //           ],
    //         ),
    //   floatingActionButton: isMobile
    //       ? FloatingActionButton.extended(
    //           backgroundColor: primary,
    //           foregroundColor: white,
    //           onPressed: () => _showAddEditBottomSheet(null), // ✅ Add Country
    //           label: const Text("Add Country"),
    //           icon: const Icon(Icons.add),
    //         )
    //       : null,
    // );
  }
}
