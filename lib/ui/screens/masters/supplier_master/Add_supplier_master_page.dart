import 'package:flutter/material.dart';

import '../../../../data/models/country/country_response.dart';
import '../../../../data/models/state_master/add_state_master_model.dart';

import '../../../../data/models/supplier_master/add_supplier_master_model.dart';
import '../../../../data/models/supplier_master/supplier_master_list_model.dart';
import '../../../../data/services/state_master_service.dart';
import '../../../../data/services/supplier_master_service.dart';
import '../../../widgets/custom_dropdown_text_field.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class AddSupplierMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddSupplierMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddSupplierMasterPage> createState() => _AddSupplierMasterPageState();
}

class _AddSupplierMasterPageState extends State<AddSupplierMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final SupplierMasterService _service = SupplierMasterService();

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
        TextEditingController(text: widget.unitInfo?.supCode.toString() ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.supName ?? "");
    _countryNameController = TextEditingController(
        text: "");
    _activeStatus = (widget.unitInfo?.supActiveStatus ?? 1) == 1;
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

    if (widget.unitInfo == null) {
      // ADD mode

final request = AddSupplierMasterModel(
  supId: "SUP001",                // Supplier ID
  supName: "ABC Suppliers Pvt Ltd", // Supplier Name
  supGroupCode: 101,              // Group Code (int)
  supAreaCode: 202,               // Area Code (int)
  supStateCode: 27,               // State Code (int)
  supCountryCode: 91,             // Country Code (int) (e.g., India = 91)
  supAddress1: "123, MG Road, Pune, Maharashtra", // Address
  supPinCode: "411001",           // Pincode
  supMobileNo: "9876543210",      // Mobile No
  supEmailId: "abc.suppliers@email.com", // Email
  supGSTINNo: "27ABCDE1234F1Z5",  // GSTIN
  supLicenseNo: "LIC987654",      // License No
  supPanNo: "ABCDE1234F",         // PAN No
  supGSTType: 1,                  // GST Type (e.g., 1=Registered, 2=Unregistered)
  taxIsIncluded: 1,               // Tax Included? (1=yes, 0=no)
  createdUserCode: "1001",        // Created By User Code
  supActiveStatus: 1,             // Active (1=Active, 0=Inactive)
);
print("request");
print(request);
      final response = await _service.addSupplierMaster(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
 final updated = AddSupplierMasterModel(
  supId: "SUP001",                // Supplier ID
  supName: "ABC Suppliers Pvt Ltd", // Supplier Name
  supGroupCode: 101,              // Group Code (int)
  supAreaCode: 202,               // Area Code (int)
  supStateCode: 27,               // State Code (int)
  supCountryCode: 91,             // Country Code (int) (e.g., India = 91)
  supAddress1: "123, MG Road, Pune, Maharashtra", // Address
  supPinCode: "411001",           // Pincode
  supMobileNo: "9876543210",      // Mobile No
  supEmailId: "abc.suppliers@email.com", // Email
  supGSTINNo: "27ABCDE1234F1Z5",  // GSTIN
  supLicenseNo: "LIC987654",      // License No
  supPanNo: "ABCDE1234F",         // PAN No
  supGSTType: 1,                  // GST Type (e.g., 1=Registered, 2=Unregistered)
  taxIsIncluded: 1,               // Tax Included? (1=yes, 0=no)
  createdUserCode: "1001",        // Created By User Code
  supActiveStatus: 1, 
);
     print("updated");
     print(updated);
      final response = await _service.updateSupplierMasterr(
        widget.unitInfo!.supId!,
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
  void didUpdateWidget(covariant AddSupplierMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.supCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.supName ?? "";
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? "1001";
      _activeStatus = (widget.unitInfo?.supActiveStatus ?? 1) == 1;
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
              hintText: "Search State",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getSupplierMasterSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<Info>()
                      .toList();
                }
                return [];
              },
              displayString: (unit) => unit.supName ?? "",
              onSelected: (country) {
                setState(() {
                  _unitIdController.text = country.supCode.toString() ?? "";
                  _unitNameController.text = country.supName ?? "";
                  // _createdUserController.text =
                  //     country.createdUserCode?.toString() ?? "1001";
                  _activeStatus = (country.supActiveStatus ?? 1) == 1;
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
            CustomTextField(
              title: "Location State",
              hintText: "Enter Location State",
              controller: _unitNameController,
              prefixIcon: Icons.flag,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter Location State" : null,
              focusNode: _unitNameFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                // FocusScope.of(context).requestFocus(_createdUserFocus);
              },
            ),
            const SizedBox(height: 16),
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
                  text: isEdit ? "Update State" : "Add State",
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
