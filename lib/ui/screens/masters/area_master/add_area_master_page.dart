import 'package:facebilling/data/models/area_master/area_master_list_model.dart';
import 'package:facebilling/ui/screens/masters/state_master/add_state_master_page.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/area_master/add_area_master_model.dart';
import '../../../../data/services/area_master_service.dart';
import '../../../../data/services/get_all_master_service.dart';
import '../../../../data/services/user_master_service.dart';
import '../../../widgets/custom_dropdown_text_field.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

import '../../../../data/models/get_all_master_list_model.dart' as master;

class AddAreaMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddAreaMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddAreaMasterPage> createState() => _AddAreaMasterPageState();
}

class _AddAreaMasterPageState extends State<AddAreaMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final AreaMasterService _service = AreaMasterService();

  master.GetAllMasterListModel? getAllMasterListModel;

  final GetAllMasterService _getAllMasterService = GetAllMasterService();
  bool _activeStatus = true;
  bool _loading = false;
  String? _message;
  int? _stateCode;

  late TextEditingController _unitIdController;
  late TextEditingController _unitNameController;
  late TextEditingController _createdUserController;
  bool _getAllLoading = true;
  final FocusNode _unitIdFocus = FocusNode();
  final FocusNode _unitNameFocus = FocusNode();
  String? error;
  // final FocusNode _createdUserFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadList();
    _unitIdController =
        TextEditingController(text: widget.unitInfo?.areaId ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.areaName ?? "");
    // _createdUserController = TextEditingController(
    //     text: widget.countryInfo?.createdUserCode?.toString() ?? "1001");
    _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
  }

  Future<void> _loadList() async {
    final response = await _getAllMasterService.getAllMasterService();
    if (response.isSuccess) {
      setState(() {
        getAllMasterListModel = response.data!;
        _getAllLoading = false;
        error = null;
      });
    } else {
      setState(() {
        error = response.error;
        _getAllLoading = false;
      });
    }
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
      String? areaId;
      String? areaName;
      int? stateCode;
      int? createdUserCode;
      int? activeStatus;
      final request = AddAreaMasterModel(
        areaName: _unitNameController.text.trim(),
        areaId: _unitIdController.text.trim(),

        // current timestamp
        activeStatus: _activeStatus ? 1 : 0,
      );
      print("request");
      print(request);
      final response = await _service.addAreaMaster(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
      final updated = AddAreaMasterModel(
        areaName: _unitNameController.text.trim(),
        areaId: _unitIdController.text.trim(),

        // current timestamp
        activeStatus: _activeStatus ? 1 : 0,
      );
      print("updated");
      print(updated);
      final response = await _service.updateAreaMaster(
        widget.unitInfo!.areaCode!,
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
  void didUpdateWidget(covariant AddAreaMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.areaCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.areaName ?? "";
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
              hintText: "Search Area",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getAreaMasterSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? []).whereType<Info>().toList();
                }
                return [];
              },
              displayString: (unit) => unit.areaName ?? "",
              onSelected: (country) {
                setState(() {
                  _unitIdController.text = country.areaCode.toString() ?? "";
                  _unitNameController.text = country.areaName ?? "";
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
              title: "Area Name",
              hintText: "Enter Area Name",
              controller: _unitNameController,
              prefixIcon: Icons.flag,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter Area name" : null,
              focusNode: _unitNameFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                // FocusScope.of(context).requestFocus(_createdUserFocus);
              },
            ),
            const SizedBox(height: 16),
            CustomDropdownField<int>(
              title: "Select State",
              hintText: "Choose State",
              items: getAllMasterListModel!.info!.states!
                  .map((e) => DropdownMenuItem<int>(
                        value: e.stateCode, // 🔹 use taxCode as value
                        child: Text("${e.stateName} "),
                      ))
                  .toList(),
              // initialValue: _taxCode, // int? taxCode
              onChanged: (value) {
                setState(() {
                  _stateCode = value;
                  //  _taxCode = value;
                });

                final selected = getAllMasterListModel!.info!.states!
                    .firstWhere((c) => c.stateCode == value,
                        orElse: () => master.States());

                print("Selected GST %: ${selected.stateCode}");
                print("Selected TAX Code: ${selected.stateCode}");
              },
              isValidate: true,
              validator: (value) =>
                  value == null ? "Please select State" : null,
              addPage: AddStateMasterPage(
                onSaved: (success) {
                  if (success) {
                    Navigator.pop(context, true);
                  }
                },
              ),
              addTooltip: "Add State",
            ),
            // CustomTextField(
            //   title: "Create User",
            //   controller: _createdUserController,
            //   prefixIcon: Icons.person,
            //   isEdit: true,
            //   // focusNode: _createdUserFocus,
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
                  text: isEdit ? "Update Area" : "Add Area",
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
