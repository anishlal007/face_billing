import 'package:flutter/material.dart';


import '../../../../data/models/company_master/add_company_master_model.dart';
import '../../../../data/models/company_master/company_master_list_model.dart';
import '../../../../data/models/customer_master/add_customer_master_model.dart';

import '../../../../data/services/comapany_master_service.dart';
import '../../../../data/services/customer_master_service.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class AddCompanyMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddCompanyMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddCompanyMasterPage> createState() => _AddCompanyMasterPageState();
}

class _AddCompanyMasterPageState extends State<AddCompanyMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final ComapanyMasterService _service = ComapanyMasterService();

  bool _activeStatus = true;
  bool _loading = false;
  String? _message;

  late TextEditingController _unitIdController;
  late TextEditingController _unitNameController;
  // late TextEditingController _createdUserController;

  final FocusNode _unitIdFocus = FocusNode();
  final FocusNode _unitNameFocus = FocusNode();
  // final FocusNode _createdUserFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _unitIdController =
        TextEditingController(text: widget.unitInfo?.coCode.toString() ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.coName ?? "");
    // _createdUserController = TextEditingController(
    //     text: widget.countryInfo?.createdUserCode?.toString() ?? "1001");
    _activeStatus = (widget.unitInfo?.coActiveStatus ?? 1) == 1;
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
  //       String? userId;
  // String? userName;
  // String? userPassword;
  // int? userType;
  // int? activeStatus;
     final request = AddCompanyMasterModel(
  coName: _unitNameController.text.trim(),
  coShortName: "TechCorp",
  coAddress1: "123 Business Park",
  coAddress2: "Suite 45",
  coAddress3: "",
  coAddress4: "",
  coAddress5: "",
  areaCode: 1,
  cityCode: 101,
  coPinCode: "400001",
  stateCode: 27,
  countryCode: 1,
  coMobileNo1: "9876543210",
  coPhoneNo1: "0221234567",
  coMailId: "info@techcorp.com",
  coWebsite: "www.techcorp.com",
  coGstinNo: "22AAAAA0000A1Z5",
  coPanNo: "ABCDE1234F",
  coLicenseNo1: "LIC12345",
  coFSSAINo: "FSSAI56789",
  coBankName: "HDFC Bank",
  coAccNo: "1234567890",
  coIFSCCode: "HDFC0001234",
  coBranchName: "Mumbai",
  coBankAdd1: "HDFC Tower",
  coLogo: "logo.png",
  coActiveStatus: _activeStatus ? 1 : 0,
  softwareVersion: "v1.0",
  softwareInstalledDt: "2025-09-21 10:00:00",
);
print("request");
print(request);
      final response = await _service.addComapanyMaster(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
 final updated = AddCompanyMasterModel(
  coName: _unitNameController.text.trim(),
  coShortName: "TechCorp",
  coAddress1: "123 Business Park",
  coAddress2: "Suite 45",
  coAddress3: "",
  coAddress4: "",
  coAddress5: "",
  areaCode: 1,
  cityCode: 101,
  coPinCode: "400001",
  stateCode: 27,
  countryCode: 1,
  coMobileNo1: "9876543210",
  coPhoneNo1: "0221234567",
  coMailId: "info@techcorp.com",
  coWebsite: "www.techcorp.com",
  coGstinNo: "22AAAAA0000A1Z5",
  coPanNo: "ABCDE1234F",
  coLicenseNo1: "LIC12345",
  coFSSAINo: "FSSAI56789",
  coBankName: "HDFC Bank",
  coAccNo: "1234567890",
  coIFSCCode: "HDFC0001234",
  coBranchName: "Mumbai",
  coBankAdd1: "HDFC Tower",
  coLogo: "logo.png",
  coActiveStatus: _activeStatus ? 1 : 0,
  softwareVersion: "v1.0",
  softwareInstalledDt: "2025-09-21 10:00:00",
);
     print("updated");
     print(updated);
      final response = await _service.updateComapanyMaster(
        widget.unitInfo!.coCode!,
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
  void didUpdateWidget(covariant AddCompanyMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.coCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.coName ?? "";
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? "1001";
      _activeStatus = (widget.unitInfo?.coActiveStatus ?? 1) == 1;
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
              hintText: "Search User",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getComapanyMasterSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<Info>()
                      .toList();
                }
                return [];
              },
              displayString: (unit) => unit.coName ?? "",
              onSelected: (country) {
                setState(() {
                  _unitIdController.text = country.coCode.toString() ?? "";
                  _unitNameController.text = country.coName ?? "";
                  // _createdUserController.text =
                  //     country.createdUserCode?.toString() ?? "1001";
                  _activeStatus = (country.coActiveStatus ?? 1) == 1;
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
              title: "User Name",
              hintText: "Enter User Name",
              controller: _unitNameController,
              prefixIcon: Icons.flag,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter User name" : null,
              focusNode: _unitNameFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                // FocusScope.of(context).requestFocus(_createdUserFocus);
              },
            ),
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
                  text: isEdit ? "Update User" : "Add User",
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
