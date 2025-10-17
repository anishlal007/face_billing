import 'package:facebilling/core/const.dart';
// import 'package:facebilling/ui/widgets/AutoSearchDropdown.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/hns_master/add_hns_model.dart';
import '../../../../data/models/hns_master/hns_master_list_model.dart';
import '../../../../data/models/tax_master/tax_master_list_model.dart' as tax;
import '../../../../data/services/hns_master_service.dart'
    show HnsMasterService;
import '../../../../data/services/tax_master_service.dart';
import '../../../widgets/AutoSearchDropdown.dart';
import '../../../widgets/custom_dropdown_text_field.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown.dart';
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
  String? gstPercentage;
  late TextEditingController _hsnIdController;
  late TextEditingController _hsnNameController;
  late TextEditingController _taxNameController;
  // late TextEditingController _createdUserController;
  tax.TaxMasterListModel? taxMasterListModel;
  final FocusNode _hsnIdFocus = FocusNode();
  final FocusNode _hsnNameFocus = FocusNode();
  final FocusNode _taxNameFocus = FocusNode();
  // final FocusNode _createdUserFocus = FocusNode();
  dynamic _taxCode;
  bool _isEditMode = false;
  @override
  void initState() {
    super.initState();
    _loadTax();
    _hsnIdController =
        TextEditingController(text: widget.unitInfo?.hsnCode.toString() ?? "");
    _hsnNameController =
        TextEditingController(text: widget.unitInfo?.hsnName ?? "");
    //  _taxCode = widget.unitInfo?.gstPercentage;
    _taxNameController = TextEditingController(
        text: widget.unitInfo?.gstPercentage.toString() ?? "");
    // _createdUserController = TextEditingController(
    //     text: widget.countryInfo?.createdUserCode?.toString() ?? userId.value!);
    _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
    _isEditMode = widget.unitInfo != null;
  }

  @override
  void dispose() {
    _hsnIdController.dispose();
    _hsnNameController.dispose();
    _taxNameController.dispose();
    _hsnIdFocus.dispose();
    _hsnNameFocus.dispose();
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
    final request = AddHnsModel(
      hsnName: _hsnNameController.text.trim(), // ❌ not in model
      cratedUserCode: userId.value!, // ✅ but should be user ID, not DateTime
      gstPercentage: 0, // ✅ correct
      hsnNo: _hsnIdController.text.trim(), // ✅ int
      cessPercentage: 0, // ✅ correct
      activeStatus: _activeStatus ? 1 : 0, // ✅ correct
    );
    if (_isEditMode && widget.unitInfo != null) {
      // EDIT mode
      final response = await _service.updateHnsMasterr(
        widget.unitInfo!.hsnCode!,
        request,
      );
      _handleResponse(response.isSuccess, response.error);
    } else {
      // ADD mode
      final response = await _service.addHnsMasterr(request);
      _handleResponse(response.isSuccess, response.error);
    }
  }

  void _handleResponse(bool success, String? error) {
    if (success) {
      setState(() {
        _hsnNameController.clear();
        _hsnIdController.clear();
        _loading = false;
        _message = success ? "Saved successfully!" : error;
      });
      if (success) widget.onSaved(true);
    }
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  @override
  void didUpdateWidget(covariant AddHnsMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _hsnIdController.text = widget.unitInfo?.hsnCode.toString() ?? "";
      _hsnNameController.text = widget.unitInfo?.hsnName ?? "";
      _taxCode = widget.unitInfo?.gstPercentage; //
      print(_taxCode);
      print(_taxCode);
      //  _taxCode = widget.unitInfo?. gstPercentage?? 0;
      _taxNameController.text = _taxCode?.toString() ?? "";
      print("_taxNameController");
      print(_taxNameController.text);
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? userId.value!;
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
            // SearchDropdownField<Info>(
            //   hintText: "Search HNS",
            //   controller: _taxNameController,
            //   prefixIcon: Icons.search,
            //   fetchItems: (q) async {
            //     final response = await _service.getHnsMasterSearch(q);
            //     if (response.isSuccess) {
            //       return (response.data?.info ?? [])
            //           .whereType<Info>()
            //           .toList();
            //     }
            //     return [];
            //   },
            //   displayString: (unit) => unit.hsnName ?? "",
            //       onSelected: (country) {
            //       if (country != null) {
            //     setState(() {
            //       _hsnIdController.text = country.hsnCode.toString() ?? "";
            //       _hsnNameController.text = country.hsnName ?? "";
            //       // _createdUserController.text =
            //       //     country.createdUserCode?.toString() ?? userId.value!;
            //       _activeStatus = (country.activeStatus ?? 1) == 1;
            //       _isEditMode = true;
            //     });

            //     // ✅ Switch form into "Update mode"
            //     widget.onSaved(false);
            //     }

            //   },
            //        onSubmitted: (typedValue) {
            //     setState(() {
            //       _hsnIdController.clear();
            //       _hsnNameController.text = typedValue;
            //       //_createdUserController.text = userId.value!;
            //       _activeStatus = true;
            //       _isEditMode = false; // <-- back to Add mode
            //     });
            //     widget.onSaved(false);
            //   },
            // ),

            // AutoSearchDropdown<Info>(
            //   hintText: "HNS Name",
            //   fetchItems: (query) async {
            //     final response = await _service.getHnsMasterSearch(query);
            //     return response.isSuccess ? (response.data?.info ?? []) : [];
            //   },
            //   displayString: (item) => item.hsnName ?? "",
            //   onSelected: (item) {
            //     if (item != null) {
            //       _hsnIdController.text = item.hsnCode ?? "";
            //       _hsnNameController.text = item.hsnName ?? "";
            //       // Move to next field
            //       _fieldFocusChange(context, _hsnNameFocus, _hsnIdFocus);
            //     }
            //   },
            //   onSubmitted: (typedValue) {
            //     _hsnNameController.text = typedValue;
            //     _fieldFocusChange(context, _hsnNameFocus, _hsnIdFocus);
            //   },
            //   focusNode: _hsnNameFocus,
            //   textInputAction: TextInputAction.next,
            //   onEditingComplete: () =>
            //       _fieldFocusChange(context, _hsnNameFocus, _hsnIdFocus),
            // ),
            AutoSuggestion<Info>(
              controller: _hsnNameController,
              labelText: 'HNS Name',
              hintText: 'Search by HNS Name ',

              suggestionsCallback: (pattern) async {
                final apiResponse = await _service.getHnsMasterSearch(pattern);

                if (apiResponse.error != null) {
                  return [];
                }

                return apiResponse.data?.info ?? [];
              },

              // 🎯 FIX: Use Product-specific fields
              itemBuilder: (context, suggestion) {
                // Assuming suggestion is now ProductMasterInfo
                return ListTile(
                  title: Text(suggestion.hsnName ?? ""), // Use item name
                  subtitle:
                      Text('Code: ${suggestion.hashCode}'), // Use item code
                );
              },

              onSuggestionSelected: (product) {
                // Assuming you have a ProductMasterInfo variable like _selectedProduct
                // setState(() => _selectedProduct = product);
                print('Selected Product: ${product.hsnCode}');
                // You should update your product-related state here, not a customer state
              },

              // 🎯 FIX: Use Product-specific text extractor
              getDisplayString: (product) => product.hsnName ?? "",

              // addTooltip: "Add Item Group",
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
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              title: "HSN Code",
              hintText: "Enter HSN Code",
              controller: _hsnIdController,
              prefixIcon: Icons.flag_circle,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter unit ID" : null,
              focusNode: _hsnIdFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_hsnNameFocus);
              },
            ),

            const SizedBox(height: 16),
            // CustomTextField(
            //   title: "HNS Name",
            //   hintText: "Enter HNS Name",
            //   controller: _hsnNameController,
            //   prefixIcon: Icons.flag,
            //   isValidate: true,
            //   validator: (value) =>
            //       value == null || value.isEmpty ? "Enter HNS name" : null,
            //   focusNode: _unitNameFocus,
            //   textInputAction: TextInputAction.next,
            //   onEditingComplete: () {
            //     // FocusScope.of(context).requestFocus(_createdUserFocus);
            //   },
            // ),
            const SizedBox(height: 16),
            SearchableDropdown<tax.Info>(
              hintText: "Select GST",
              items: taxMasterListModel!.info!,
              itemLabel: (supplier) => supplier.taxName ?? "",
              onChanged: (supplier) {
                if (supplier != null) {
                  _taxCode = supplier.taxName.toString();

                  print("Selected Code: ${supplier.taxCode}");
                  print("Selected Name: ${supplier.taxName}");
                }
              },
            ),
// CustomDropdownField<int>(
//   title: "Select GST",
//   hintText: "Choose a GST",
//   items: taxMasterListModel!.info!
//       .map((e) => DropdownMenuItem<int>(
//             value: e.taxPercentage,
//             child: Text("${e.taxName} (${e.taxPercentage}%)"),
//           ))
//       .toList(),
//   initialValue: _taxCode, // ✅ use int value here
//   onChanged: (value) {
//     setState(() {
//       _taxCode = value;  // update dropdown selection
//       _taxNameController.text = value.toString(); // update text controller if needed
//     });

//     final selected = taxMasterListModel!.info
//         ?.firstWhere((c) => c.taxCode == value, orElse: () => null as tax.Info);

//     print("Selected: ${selected?.taxPercentage}");
//     print("TAX Code: ${selected?.taxCode}");
//   },
//   isValidate: true,
//   validator: (value) => value == null ? "Please select a GST" : null,
// ),

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
                  text: _isEditMode ? "Update HNS" : "Add HNS",
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
