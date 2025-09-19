import 'package:facebilling/data/models/unit/add_unit_request.dart';
import 'package:facebilling/data/models/unit/unit_response.dart';
import 'package:facebilling/data/services/unit_service.dart';
import 'package:flutter/material.dart';


import '../../../../data/models/unit/add_location_master_req.dart';
import '../../../../data/models/user_master/add_user_master_model.dart';
import '../../../../data/models/user_master/user_master_list_model.dart';
import '../../../../data/services/location_master_service.dart';
import '../../../../data/services/user_master_service.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class AddUserMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddUserMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddUserMasterPage> createState() => _AddUserMasterPageState();
}

class _AddUserMasterPageState extends State<AddUserMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final UserMasterService _service = UserMasterService();

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
        TextEditingController(text: widget.unitInfo?.userId ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.userName ?? "");
    // _createdUserController = TextEditingController(
    //     text: widget.countryInfo?.createdUserCode?.toString() ?? "1001");
    _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
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
     final request = AddUserMasterModel(
  userName: _unitNameController.text.trim(),
    // current timestamp
  activeStatus: _activeStatus ? 1 : 0,
);
print("request");
print(request);
      final response = await _service.addUserMaster(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
 final updated = AddUserMasterModel(
  userName: _unitNameController.text.trim(),
     // current timestamp
  activeStatus: _activeStatus ? 1 : 0,
);
     print("updated");
     print(updated);
      final response = await _service.updateUserMaster(
        widget.unitInfo!.userCode!,
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
  void didUpdateWidget(covariant AddUserMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.userCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.userName ?? "";
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? "1001";
      _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
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
                final response = await _service.getUserMasterSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<Info>()
                      .toList();
                }
                return [];
              },
              displayString: (unit) => unit.userName ?? "",
              onSelected: (country) {
                setState(() {
                  _unitIdController.text = country.userCode.toString() ?? "";
                  _unitNameController.text = country.userName ?? "";
                  // _createdUserController.text =
                  //     country.createdUserCode?.toString() ?? "1001";
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
