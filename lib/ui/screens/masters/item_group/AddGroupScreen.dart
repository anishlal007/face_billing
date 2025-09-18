import 'package:facebilling/data/models/item_group/add_group_request.dart';
import 'package:facebilling/data/models/item_group/item_group_response.dart';
import 'package:flutter/material.dart';

import '../../../../data/services/item_group_service.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class Addgroupscreen extends StatefulWidget {
  final ItemGroupInfo? groupInfo;
  final Function(bool success) onSaved;
  const Addgroupscreen({
    super.key,
    this.groupInfo,
    required this.onSaved,
  });

  @override
  State<Addgroupscreen> createState() => _AddgroupscreenState();
}

class _AddgroupscreenState extends State<Addgroupscreen> {
  final _formKey = GlobalKey<FormState>();
  final ItemGroupService _service = ItemGroupService();

  bool _activeStatus = true;
  bool _loading = false;
  String? _message;

  late TextEditingController _itemGroupNameController;
  // late TextEditingController _countryNameController;
  late TextEditingController _createdUserController;

  // final FocusNode _countryIdFocus = FocusNode();
  final FocusNode _itemGroupNameFocus = FocusNode();
  final FocusNode _createdUserFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _itemGroupNameController =
        TextEditingController(text: widget.groupInfo?.itemGroupName ?? "");
    _createdUserController = TextEditingController(
        text: widget.groupInfo?.cratedUserCode?.toString() ?? "1");
    _activeStatus = (widget.groupInfo?.activeStatus ?? 1) == 1;
  }

  @override
  void dispose() {
    _itemGroupNameController.dispose();
    _createdUserController.dispose();
    _itemGroupNameFocus.dispose();
    _createdUserFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _message = null;
    });

    if (widget.groupInfo == null) {
      // ADD mode
      final request = AddGroupRequest(
        itemGroupName: _itemGroupNameController.text.trim(),
        createdUserCode: _createdUserController.text.trim(),
        createdDate:
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
        // updatedUserCode: _createdUserController.text.trim(),
        activeStatus: _activeStatus ? 1 : 0,
      );
      final response = await _service.addItemGroup(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
      final updated = AddGroupRequest(
        itemGroupName: _itemGroupNameController.text.trim(),
        updatedUserCode: _createdUserController.text.trim(),
        // createdUserCode: int.parse(_createdUserController.text.trim()),
        activeStatus: _activeStatus ? 1 : 0,
      );
      final response = await _service.updateItemGroup(
        widget.groupInfo!.itemGroupCode!,
        updated,
      );
      _handleResponse(response.isSuccess, response.error);
    }
  }

  void _handleResponse(bool success, String? error) {
    setState(() {
      _loading = false;
      _message = success ? "Saved successfully!" : error;
    });
    if (success) widget.onSaved(true);
  }

  @override
  void didUpdateWidget(covariant Addgroupscreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.groupInfo != oldWidget.groupInfo) {
      _itemGroupNameController.text = widget.groupInfo?.itemGroupName ?? "";
      // _countryNameController.text = widget.countryInfo?.countryName ?? "";
      _createdUserController.text =
          widget.groupInfo?.cratedUserCode?.toString() ?? "1001";
      _activeStatus = (widget.groupInfo?.activeStatus ?? 1) == 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.groupInfo != null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SearchDropdownField<ItemGroupInfo>(
              hintText: "Search Group",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getItemGroupSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<ItemGroupInfo>()
                      .toList();
                }
                return [];
              },
              displayString: (country) => country.itemGroupName ?? "",
              onSelected: (country) {
                setState(() {
                  _itemGroupNameController.text =
                      country.itemGroupName.toString();
                  _createdUserController.text =
                      country.cratedUserCode?.toString() ?? "1001";
                  _activeStatus = (country.activeStatus ?? 1) == 1;
                });

                // ✅ Switch form into "Update mode"
                widget.onSaved(false);
              },
            ),

            const SizedBox(height: 26),
            // SwitchListTile(
            //   value: _activeStatus,
            //   title: const Text("Active Status"),
            //   onChanged: (val) => setState(() => _activeStatus = val),
            // ),
            CustomSwitch(
              value: _activeStatus,
              title: "Active Status",
              onChanged: (val) {
                setState(() {
                  _activeStatus = val;
                });
              },
            ),
            CustomTextField(
              title: "Group Name",
              hintText: "Enter Group Name",
              controller: _itemGroupNameController,
              prefixIcon: Icons.flag_circle,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter Group Name" : null,
              focusNode: _itemGroupNameFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_itemGroupNameFocus);
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              title: "Create User",
              controller: _createdUserController,
              prefixIcon: Icons.person,
              isEdit: true,
              focusNode: _createdUserFocus,
              textInputAction: TextInputAction.done,
              onEditingComplete: _submit,
            ),
            const SizedBox(height: 16),
            // SwitchListTile(
            //   value: _activeStatus,
            //   title: const Text("Active Status"),
            //   onChanged: (val) => setState(() => _activeStatus = val),
            // ),
            const SizedBox(height: 16),
            if (_loading)
              const CircularProgressIndicator()
            else
              GradientButton(
                  text: isEdit ? "Update Group" : "Add Group",
                  onPressed: _submit),
            if (_message != null) ...[
              const SizedBox(height: 16),
              Text(
                _message!,
                style: TextStyle(
                  color: _message!.contains("successfully")
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
