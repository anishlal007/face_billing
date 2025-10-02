import 'package:facebilling/data/models/unit/add_unit_request.dart';
import 'package:facebilling/data/models/unit/unit_response.dart';
import 'package:facebilling/data/services/unit_service.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/item_make/item_make_list_master_model.dart';
import '../../../../data/models/unit/add_item_make_unit_model.dart';
import '../../../../data/models/unit/add_location_master_req.dart';
import '../../../../data/services/item_make_master_service.dart';
import '../../../../data/services/location_master_service.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class AddItemMakeMaster extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddItemMakeMaster({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddItemMakeMaster> createState() => _AddItemMakeMasterState();
}

class _AddItemMakeMasterState extends State<AddItemMakeMaster> {
  final _formKey = GlobalKey<FormState>();
  final ItemMakeMasterService _service = ItemMakeMasterService();

  bool _activeStatus = true;
  bool _loading = false;
  String? _message;

  late TextEditingController _unitIdController;
  late TextEditingController _unitNameController;
  // late TextEditingController _createdUserController;

  final FocusNode _unitIdFocus = FocusNode();
  final FocusNode _unitNameFocus = FocusNode();
  // final FocusNode _createdUserFocus = FocusNode();
bool _isEditMode = false; 
  @override
  void initState() {
    super.initState();

    _unitIdController =
        TextEditingController(text: widget.unitInfo?.itemMakeCode.toString() ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.itemMaketName ?? "");
    // _createdUserController = TextEditingController(
    //     text: widget.countryInfo?.createdUserCode?.toString() ?? "1001");
    _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
    _isEditMode = widget.unitInfo != null;
  }

  @override
  void dispose() {
    _unitIdController.dispose();
    _unitNameController.dispose();
    // _createdUserController.dispose();
    _unitIdFocus.dispose();
    _unitNameFocus.dispose();
    // _createdUserFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _message = null;
    });
  final request = AddItemMakeUnit(

  itemMaketName: _unitNameController.text.trim(),
  cratedUserCode:  DateTime.now().toIso8601String(),     // if this is the "user code"
 
  updatedUserCode: "1001",                             // hardcoded or from logged-in user

  activeStatus: _activeStatus ? 1 : 0,
);
   if (_isEditMode && widget.unitInfo != null) {
      // EDIT mode
      final response = await _service.updateItemMakeMaster(
        widget.unitInfo!.itemMakeCode!,
        request,
      );
      _handleResponse(response.isSuccess, response.error);
    } else {
      // ADD mode
      final response = await _service.addItemMakeMaster(request);
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
  void didUpdateWidget(covariant AddItemMakeMaster oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.itemMakeCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.itemMaketName ?? "";
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? "1001";
      _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
    _isEditMode = widget.unitInfo != null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.unitInfo != null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SearchDropdownField<Info>(
              controller: _unitNameController,
              hintText: "ItemMake Name",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getItemMakeMasterSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<Info>()
                      .toList();
                }
                return [];
              },
              displayString: (unit) => unit.itemMaketName ?? "",
              onSelected: (country) {
                if(country!=null){
setState(() {
                  _unitIdController.text = country.itemMakeCode.toString() ?? "";
                  _unitNameController.text = country.itemMaketName ?? "";
                  // _createdUserController.text =
                  //     country.createdUserCode?.toString() ?? "1001";
                  _activeStatus = (country.activeStatus ?? 1) == 1;
                   _isEditMode = true;
                });

                // ✅ Switch form into "Update mode"
                widget.onSaved(false);
                }

                
              },
               onSubmitted: (typedValue) {
                setState(() {
                  _unitIdController.clear();
                  _unitNameController.text = typedValue;
                 // _createdUserController.text = "1001";
                  _activeStatus = true;
                  _isEditMode = false; // <-- back to Add mode
                });
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
            // CustomTextField(
            //   title: "Location Code",
            //   hintText: "Enter Location Code",
            //   controller: _unitIdController,
            //   prefixIcon: Icons.flag_circle,
            //   isValidate: true,
            //   validator: (value) =>
            //       value == null || value.isEmpty ? "Enter unit ID" : null,
            //   focusNode: _unitIdFocus,
            //   textInputAction: TextInputAction.next,
            //   onEditingComplete: () {
            //     FocusScope.of(context).requestFocus(_unitNameFocus);
            //   },
            // ),
            const SizedBox(height: 16),
            // CustomTextField(
            //   title: "ItemMake Name",
            //   hintText: "Enter ItemMake Name",
            //   controller: _unitNameController,
            //   prefixIcon: Icons.flag,
            //   isValidate: true,
            //   validator: (value) =>
            //       value == null || value.isEmpty ? "Enter ItemMake name" : null,
            //   focusNode: _unitNameFocus,
            //   textInputAction: TextInputAction.next,
            //   onEditingComplete: () {
            //     // FocusScope.of(context).requestFocus(_createdUserFocus);
            //   },
            // ),
            const SizedBox(height: 16),
            // CustomTextField(
            //   title: "Create User",
            //   controller: _createdUserController,
            //   prefixIcon: Icons.person,
            //   isEdit: true,
            //   focusNode: _createdUserFocus,
            //   textInputAction: TextInputAction.done,
            //   onEditingComplete: _submit,
            // ),
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
                  text: _isEditMode ? "Update ItemMake" : "Add ItemMake",
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
