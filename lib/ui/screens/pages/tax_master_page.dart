import 'package:facebilling/ui/screens/masters/item_make_master/item_make_master_list.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';


import '../../../data/models/tax_master/tax_master_list_model.dart';
import '../masters/location_master/add_location_master.dart';
import '../masters/location_master/location_master_list.dart';
import '../masters/tax_master/add_tax_master_page.dart';
import '../masters/tax_master/tax_master_list_page.dart';



class TaxMasterPage extends StatefulWidget {
  const TaxMasterPage({super.key});

  @override
  State<TaxMasterPage> createState() =>
      _TaxMasterPageState();
}

class _TaxMasterPageState extends State<TaxMasterPage> {
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
          child: AddTaxMasterPage(
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
              child: TaxMasterListPage(
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
                    child: TaxMasterListPage(
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
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: AddTaxMasterPage(
                      unitInfo: editingUnit,
                      onSaved: _onSaved,
                    ),
                  ),
                ),
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
