import 'package:facebilling/core/const.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/country/country_response.dart';

import '../../../../data/models/supplier_group_master/add_spplier_group_model.dart';
import '../../../../data/models/supplier_group_master/supplier_group_master_list_model.dart';
import '../../../../data/services/supplier_group_master_service.dart';
import '../../../../data/services/supplier_master_service.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class AddSupplierGroupMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddSupplierGroupMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddSupplierGroupMasterPage> createState() => _AddSupplierGroupMasterPageState();
}

class _AddSupplierGroupMasterPageState extends State<AddSupplierGroupMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final SupplierGroupMasterService _service = SupplierGroupMasterService();
bool _isEditMode = false; 
  bool _activeStatus = true;
  bool _loading = false;
  String? _message;

  late TextEditingController _unitIdController;
  late TextEditingController _unitNameController;
  late TextEditingController _countryNameController;
  // late TextEditingController _createdUserController;

  final FocusNode _unitIdFocus = FocusNode();
  final FocusNode _unitNameFocus = FocusNode();
  final FocusNode _countryNameFocus = FocusNode();
  // final FocusNode _createdUserFocus = FocusNode();
Country? country;
 bool loading = true;
  String? error;
  @override
  void initState() {
    super.initState();

    _unitIdController =
        TextEditingController(text: widget.unitInfo?.supGroupCode.toString() ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.supGroupName ?? "");
    _countryNameController = TextEditingController(
        text: "");
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
final request = AddSupplierGroupMasterModel(
  supGroupName :_unitNameController.text.trim(),
 cratedUserCode: DateTime.now().toIso8601String(),     // required by API
  updatedUserCode: userId.value!, 
  activeStatus: _activeStatus ? 1 : 0,           // Active (1=Active, 0=Inactive)
);
print("request");
print(request.toJson());
    if (_isEditMode && widget.unitInfo != null) {
      // EDIT mode
      final response = await _service.updateSupplierGroupMasterr(
        widget.unitInfo!.supGroupCode!,
        request,
      );
      _handleResponse(response.isSuccess, response.error);
    } else {
      // ADD mode
      final response = await _service.addSupplierGroupMaster(request);
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
  void didUpdateWidget(covariant AddSupplierGroupMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.supGroupCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.supGroupName ?? "";
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? userId.value!;
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
              hintText: "Supplier Group Name",
               controller: _unitNameController,
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getSupplierGroupMasterSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<Info>()
                      .toList();
                }
                return [];
              },
              displayString: (unit) => unit.supGroupName ?? "",
              onSelected: (country) {
                if (country != null) {
                setState(() {
                  _unitIdController.text = country.supGroupCode.toString() ?? "";
                  _unitNameController.text = country.supGroupName ?? "";
                  // _createdUserController.text =
                  //     country.createdUserCode?.toString() ?? userId.value!;
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
                  //_createdUserController.text = userId.value!;
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
            //   title: "Location State",
            //   hintText: "Enter Location State",
            //   controller: _unitNameController,
            //   prefixIcon: Icons.flag,
            //   isValidate: true,
            //   validator: (value) =>
            //       value == null || value.isEmpty ? "Enter Location State" : null,
            //   focusNode: _unitNameFocus,
            //   textInputAction: TextInputAction.next,
            //   onEditingComplete: () {
            //     // FocusScope.of(context).requestFocus(_createdUserFocus);
            //   },
            // ),
            // const SizedBox(height: 16),
// CustomDropdownField(
//   title: "Select Country",
//   hintText: "Choose a country",
//   items: country!.info
//           ?.map((e) => e?.countryName ?? "")
//           .toList() ?? [], // ✅ list of country names
//   initialValue: null, // 🔹 empty at first
//   onChanged: (value) {
//     print("Selected: $value");
//     // Optionally get the code from info list
//     final selected = country!.info?.firstWhere(
//       (c) => c?.countryName == value,
//       orElse: () => null,
//     );
//     print("Country Code: ${selected?.countryCode}");
//   },
//   isValidate: true,
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return "Please select a country";
//     }
//     return null;
//   },
// ),
            // CustomTextField(
            //   title: "Country Name",
            //   hintText: "Enter Country Name",
            //   controller: _unitNameController,
            //   prefixIcon: Icons.flag,
            //   isValidate: true,
            //   validator: (value) =>
            //       value == null || value.isEmpty ? "Enter Country Name" : null,
            //   focusNode: _unitNameFocus,
            //   textInputAction: TextInputAction.next,
            //   onEditingComplete: () {
            //     // FocusScope.of(context).requestFocus(_createdUserFocus);
            //   },
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
                  text: _isEditMode ? "Update Supplier group" : "Add Supplier Group",
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
