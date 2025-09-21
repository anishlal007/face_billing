import 'package:flutter/material.dart';

import '../../../../data/models/country/country_response.dart';
import '../../../../data/models/state_master/add_state_master_model.dart';
import '../../../../data/models/state_master/state_master_list_model.dart';
import '../../../../data/services/location_master_service.dart';
import '../../../../data/services/state_master_service.dart';
import '../../../widgets/custom_dropdown_text_field.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class AddStateMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddStateMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddStateMasterPage> createState() => _AddStateMasterPageState();
}

class _AddStateMasterPageState extends State<AddStateMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final StateMasterService _service = StateMasterService();

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
_loadCountries();
    _unitIdController =
        TextEditingController(text: widget.unitInfo?.stateCode.toString() ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.stateName ?? "");
    _countryNameController = TextEditingController(
        text: "");
    _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
  }

  Future<void> _loadCountries() async {
    final response = await _service.getCountries();
    if (response.isSuccess) {
      setState(() {
        country = response.data!;
        loading = false;
        error = null;
      });
    } else {
      setState(() {
        error = response.error;
        loading = false;
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

     final request = AddStateModel(
  stateName: _unitNameController.text.trim(),
  stateId:"0",
  countryCode:0,
     // required by API
  createdUserCode: 1001,                             // hardcoded or from logged-in user
    // current timestamp
  activeStatus: _activeStatus ? 1 : 0,
);
print("request");
print(request);
      final response = await _service.addStateMaster(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
 final updated = AddStateModel(
  stateName: _unitNameController.text.trim(),
  stateId:"0",
  countryCode:0,
     // required by API
  createdUserCode: 1001,                             // hardcoded or from logged-in user
    // current timestamp
  activeStatus: _activeStatus ? 1 : 0,
);
     print("updated");
     print(updated);
      final response = await _service.updateStateMasterr(
        widget.unitInfo!.stateId!,
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
  void didUpdateWidget(covariant AddStateMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.stateCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.stateName ?? "";
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
              hintText: "Search State",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getStateMasterSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<Info>()
                      .toList();
                }
                return [];
              },
              displayString: (unit) => unit.stateName ?? "",
              onSelected: (country) {
                setState(() {
                  _unitIdController.text = country.stateCode.toString() ?? "";
                  _unitNameController.text = country.stateName ?? "";
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
CustomDropdownField<String>(
  title: "Select Country",
  hintText: "Choose a country",
  items: country!.info
          ?.map((e) => DropdownMenuItem<String>(
                value: e?.countryName ?? "", // 🔹 value = country name
                child: Text(e?.countryName ?? ""), // 🔹 UI label
              ))
          .toList() ?? [],
  initialValue: null, // 🔹 empty initially
  onChanged: (value) {
    print("Selected: $value");

    final selected = country!.info?.firstWhere(
      (c) => c?.countryName == value,
      orElse: () => null,
    );

    print("Country Code: ${selected?.countryCode}");
  },
  isValidate: true,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return "Please select a country";
    }
    return null;
  },
),
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
