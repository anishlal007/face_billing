import 'package:facebilling/data/models/item_group/item_group_response.dart';
import 'package:facebilling/ui/screens/masters/item_group/AddGroupScreen.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../masters/item_group/ItemGroupScreen.dart';

class ItemGroupMasterScreen extends StatefulWidget {
  const ItemGroupMasterScreen({super.key});

  @override
  State<ItemGroupMasterScreen> createState() => _ItemGroupMasterScreenState();
}

class _ItemGroupMasterScreenState extends State<ItemGroupMasterScreen> {
  ItemGroupInfo? editingGroup;
  bool refreshList = false;

  void _onSaved(bool success) {
    if (success) {
      setState(() {
        editingGroup = null; // reset after save
        refreshList = true; // trigger reload
      });
    }
  }

  void _showAddEditBottomSheet(ItemGroupInfo? group) {
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
          child: Addgroupscreen(
            groupInfo: group,
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
              child: Itemgroupscreen(
                refreshList: refreshList,
                onEdit: (country) {
                  _showAddEditBottomSheet(
                      country); // ✅ open bottom sheet for edit
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
                    child: Itemgroupscreen(
                      refreshList: refreshList,
                      onEdit: (country) {
                        setState(() {
                          editingGroup = country;
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
                    child: Addgroupscreen(
                      groupInfo: editingGroup,
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
              label: const Text("Add Group"),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }
}
