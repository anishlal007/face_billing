import 'package:facebilling/core/const.dart';
import 'package:flutter/material.dart';



import '../../../../data/models/hns_master/add_hns_model.dart';
import '../../../../data/models/hns_master/hns_master_list_model.dart';
import '../../../../data/models/tax_master/tax_master_list_model.dart'  as tax;
import '../../../../data/services/hns_master_service.dart' show HnsMasterService;
import '../../../../data/services/tax_master_service.dart';
import '../../../widgets/custom_dropdown_text_field.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class AddHnsMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddHnsMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddHnsMasterPage> createState() => _AddHnsMasterPageState();
}

class _AddHnsMasterPageState extends State<AddHnsMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final HnsMasterService _service = HnsMasterService();
  final TaxMasterService _taxService = TaxMasterService();
  bool _activeStatus = true;
  bool _loading = false;
  bool _taxLoading = true;
  String? _message;
  String? error;
  String?gstPercentage;
  late TextEditingController _unitIdController;
  late TextEditingController _unitNameController;
  late TextEditingController _taxNameController;
  // late TextEditingController _createdUserController;
  tax.TaxMasterListModel? taxMasterListModel;
  final FocusNode _unitIdFocus = FocusNode();
  final FocusNode _unitNameFocus = FocusNode();
  final FocusNode _taxNameFocus = FocusNode();
  // final FocusNode _createdUserFocus = FocusNode();
dynamic _taxCode;
  @override
  void initState() {
    super.initState();
_loadTax();
    _unitIdController =
        TextEditingController(text: widget.unitInfo?.hsnCode.toString() ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.hsnName ?? "");
       //  _taxCode = widget.unitInfo?.gstPercentage;
    _taxNameController =
        TextEditingController(text: widget.unitInfo?.gstPercentage.toString() ?? "");
    // _createdUserController = TextEditingController(
    //     text: widget.countryInfo?.createdUserCode?.toString() ?? "1001");
    _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
  }

  @override
  void dispose() {
    _unitIdController.dispose();
    _unitNameController.dispose();
     _taxNameController.dispose();
    _unitIdFocus.dispose();
    _unitNameFocus.dispose();
     _taxNameFocus.dispose();
    super.dispose();
  }
  Future<void> _loadTax() async {
    final response = await _taxService.getTaxMaster();
    if (response.isSuccess) {
      setState(() {
        taxMasterListModel = response.data!;
        _taxLoading = false;
        error = null;
      });
    } else {
      setState(() {
        error = response.error;
        _taxLoading = false;
      });
    }
  }
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _message = null;
    });

    if (widget.unitInfo == null) {
      // ADD mode

final request = AddHnsModel(
  hsnName: _unitNameController.text.trim(),   // ❌ not in model
  cratedUserCode: loadData.userCode,    // ✅ but should be user ID, not DateTime
  gstPercentage:0,       // ✅ correct
  hsnNo: _unitIdController.text.trim(),                                 // ✅ int
  cessPercentage: 0,       // ✅ correct
  activeStatus: _activeStatus ? 1 : 0,                 // ✅ correct
);
print("request");
print(request);
      final response = await _service.addHnsMasterr(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
 final updated =  AddHnsModel(
  
  hsnName: _unitNameController.text.trim(),   // ❌ not in model
  cratedUserCode: loadData.userCode,    // ✅ but should be user ID, not DateTime
  gstPercentage:0,       // ✅ correct
  hsnNo: _unitIdController.text.trim(),                               // ✅ int
  cessPercentage: 0,       // ✅ correct
  activeStatus: _activeStatus ? 1 : 0,                 // ✅ correct
);
     print("updated");
     print(updated);
      final response = await _service.updateHnsMasterr(
        widget.unitInfo!.hsnCode!,
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
  void didUpdateWidget(covariant AddHnsMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.hsnCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.hsnName ?? "";
      _taxCode = widget.unitInfo?.gstPercentage; //
      print(_taxCode);
      print(_taxCode);
   //  _taxCode = widget.unitInfo?. gstPercentage?? 0;
      _taxNameController.text = _taxCode?.toString() ?? ""; 
     print("_taxNameController");
     print(_taxNameController.text);
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? "1001";
      _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
    }
  }

  @override
  Widget build(BuildContext context) {
       if (_taxLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text("Error: $error"));

    final isEdit = widget.unitInfo != null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SearchDropdownField<Info>(
              hintText: "Search HNS",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getHnsMasterSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<Info>()
                      .toList();
                }
                return [];
              },
              displayString: (unit) => unit.hsnName ?? "",
              onSelected: (country) {
                setState(() {
                  _unitIdController.text = country.hsnCode.toString() ?? "";
                  _unitNameController.text = country.hsnName ?? "";
               _taxCode = widget.unitInfo?.gstPercentage; //
                         _taxNameController.text = _taxCode?.toString() ?? ""; 
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
            CustomTextField(
              title: "HSN Code",
              hintText: "Enter HSN Code",
              controller: _unitIdController,
              prefixIcon: Icons.flag_circle,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter unit ID" : null,
              focusNode: _unitIdFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_unitNameFocus);
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              title: "HNS Name",
              hintText: "Enter HNS Name",
              controller: _unitNameController,
              prefixIcon: Icons.flag,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter HNS name" : null,
              focusNode: _unitNameFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                // FocusScope.of(context).requestFocus(_createdUserFocus);
              },
            ),
            const SizedBox(height: 16),
CustomDropdownField<int>(
  title: "Select GST",
  hintText: "Choose a GST",
  items: taxMasterListModel!.info!
      .map((e) => DropdownMenuItem<int>(
            value: e.taxPercentage,
            child: Text("${e.taxName} (${e.taxPercentage}%)"),
          ))
      .toList(),
  initialValue: _taxCode, // ✅ use int value here
  onChanged: (value) {
    setState(() {
      _taxCode = value;  // update dropdown selection
      _taxNameController.text = value.toString(); // update text controller if needed
    });

    final selected = taxMasterListModel!.info
        ?.firstWhere((c) => c.taxCode == value, orElse: () => null as tax.Info);

    print("Selected: ${selected?.taxPercentage}");
    print("TAX Code: ${selected?.taxCode}");
  },
  isValidate: true,
  validator: (value) => value == null ? "Please select a GST" : null,
),
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
                  text: isEdit ? "Update HNS" : "Add HNS",
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
