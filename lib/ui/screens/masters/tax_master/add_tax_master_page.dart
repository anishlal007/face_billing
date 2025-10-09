import 'package:facebilling/data/models/unit/add_unit_request.dart';
import 'package:facebilling/data/models/unit/unit_response.dart';
import 'package:facebilling/data/services/unit_service.dart';
import 'package:flutter/material.dart';


import '../../../../core/const.dart';
import '../../../../data/models/tax_master/tax_master_list_model.dart';
import '../../../../data/models/unit/add_location_master_req.dart';
import '../../../../data/models/unit/add_tax_unit_model.dart';
import '../../../../data/services/location_master_service.dart';
import '../../../../data/services/tax_master_service.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class AddTaxMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddTaxMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddTaxMasterPage> createState() => _AddTaxMasterPageState();
}

class _AddTaxMasterPageState extends State<AddTaxMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final TaxMasterService _service = TaxMasterService();
bool _isEditMode = false; 
  bool _activeStatus = true;
  bool _loading = false;
  String? _message;

  late TextEditingController _unitIdController;
  late TextEditingController _unitNameController;
   late TextEditingController _taxPercentageController;

  final FocusNode _unitIdFocus = FocusNode();
  final FocusNode _unitNameFocus = FocusNode();
  final FocusNode __taxPercentageFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _unitIdController =
        TextEditingController(text: widget.unitInfo?.taxCode.toString() ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.taxName ?? "");
    _taxPercentageController =
        TextEditingController(text: widget.unitInfo?.taxPercentage.toString() ?? "");
    // _createdUserController = TextEditingController(
    //     text: widget.countryInfo?.createdUserCode?.toString() ?? userId.value!);
    _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
       _isEditMode = widget.unitInfo != null;
  }

  @override
  void dispose() {
    _unitIdController.dispose();
    _unitNameController.dispose();
     _taxPercentageController.dispose();
    _unitIdFocus.dispose();
    _unitNameFocus.dispose();
    __taxPercentageFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _message = null;
    });
final request = AddTaxModelReq(
  taxType: 1,
  taxPercentage:_taxPercentageController.text.trim() ,
  taxId: _unitIdController.text.trim(),
  taxName: _unitNameController.text.trim(),   // ❌ not in model
  cratedUserCode: DateTime.now().toIso8601String(),    // ✅ but should be user ID, not DateTime
  createdDate: DateTime.now().toIso8601String(),       // ✅ correct
  updatedUserCode: userId.value!,                               // ✅ int
  updatedDate: DateTime.now().toIso8601String(),       // ✅ correct
  activeStatus: _activeStatus ? 1 : 0,                 // ✅ correct
);
print("request");
print(request);
      if (_isEditMode && widget.unitInfo != null) {
      // EDIT mode
      final response = await _service.updateTaxMaster(
        widget.unitInfo!.taxId!,
        request,
      );
      _handleResponse(response.isSuccess, response.error);
    } else {
      // ADD mode
      final response = await _service.addTaxMaster(request);
      _handleResponse(response.isSuccess, response.error);
    }
  }

  void _handleResponse(bool success, String? error) {
   if(success){
setState(() {
   _unitNameController.clear();
   _unitIdController.clear();
   _taxPercentageController.clear();
      _loading = false;
      _message = success ? "Saved successfully!" : error;
    });
    if (success) widget.onSaved(true);
    }
  }

  @override
  void didUpdateWidget(covariant AddTaxMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.taxCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.taxName ?? "";
        _taxPercentageController.text = widget.unitInfo?.taxPercentage ?.toString() ?? "";
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
              hintText: "TAX Name",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getTaxMasterSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<Info>()
                      .toList();
                }
                return [];
              },
              displayString: (unit) => unit.taxName ?? "",
              onSelected: (country) {
                if(country != null){
                  setState(() {
                  _unitIdController.text = country.taxCode.toString() ?? "";
                  _unitNameController.text = country.taxName ?? "";
                  _taxPercentageController.text = country.taxPercentage ?.toString() ?? "";
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
                  _taxPercentageController.text = _taxPercentageController.text ;
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
        
            const SizedBox(height: 16),
            // CustomTextField(
            //   title: "TAX Name",
            //   hintText: "Enter TAX Name",
            //   controller: _unitNameController,
            //   prefixIcon: Icons.flag,
            //   isValidate: true,
            //   validator: (value) =>
            //       value == null || value.isEmpty ? "Enter TAX name" : null,
            //   focusNode: _unitNameFocus,
            //   textInputAction: TextInputAction.next,
            //   onEditingComplete: () {
            //     // FocusScope.of(context).requestFocus(_createdUserFocus);
            //   },
            // ),
            // const SizedBox(height: 16),
            
                CustomTextField(
              title: "Tax Code",
              hintText: "Enter Tax Code",
              controller: _unitIdController,
              prefixIcon: Icons.flag_circle,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter Tax Code" : null,
              focusNode: _unitIdFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_unitNameFocus);
              },
            ),
            
            const SizedBox(height: 16),
                CustomTextField(
              title: "Tax Percentage",
              hintText: "Enter TaxPercentage",
              controller: _taxPercentageController,
              prefixIcon: Icons.percent,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter TaxPercentage" : null,
              focusNode: __taxPercentageFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(__taxPercentageFocus);
              },
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
                  text: _isEditMode ? "Update TAX" : "Add TAX",
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
