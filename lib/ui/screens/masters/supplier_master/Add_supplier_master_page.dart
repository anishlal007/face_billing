import 'package:flutter/material.dart';

import '../../../../core/const.dart';
import '../../../../data/models/country/country_response.dart';
import '../../../../data/models/state_master/add_state_master_model.dart';
import '../../../../data/models/get_all_master_list_model.dart' as master;
import '../../../../data/models/supplier_master/add_supplier_master_model.dart';
import '../../../../data/models/supplier_master/supplier_master_list_model.dart';
import '../../../../data/services/get_all_master_service.dart';
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
  final GetAllMasterService _getAllMasterService = GetAllMasterService();
  int? _areaCode, _cityCode, _stateCode, _countryCode, _subGrpCode,_taxCode;
  bool _activeStatus = true,_isTaxInclusive=true;
  bool _loading = false;
  String? _message;
  bool _getAllLoading = true;


  late TextEditingController _unitIdController;
  late TextEditingController _unitNameController;

  master.GetAllMasterListModel? getAllMasterListModel;
  late TextEditingController _suppIdController;
  late TextEditingController _suppNameController;
  late TextEditingController _suppAddress1Controller;
  late TextEditingController _supppinCodeController;
  late TextEditingController _suppMobileController;
  late TextEditingController _suppMailIdController;
  late TextEditingController _suppGstNoController;
  late TextEditingController _suppPanNoController;
  late TextEditingController _suppLicenseNoController;
  late TextEditingController _createdUserController;



  // 🔹 FocusNodes
  final FocusNode _suppIdFocus = FocusNode();
  final FocusNode _suppNameFocus = FocusNode();
  final FocusNode _createUserFocus = FocusNode();
    final FocusNode _suppAddress1Focus = FocusNode();
  final FocusNode _supppinCodeFocus = FocusNode();
  final FocusNode _suppMobileFocus = FocusNode();
  final FocusNode _suppMailIdFocus = FocusNode();
  final FocusNode _suppGstNoFocus = FocusNode();
  final FocusNode _suppPanNoFocus = FocusNode();
  final FocusNode _suppLicenseNoFocus = FocusNode();
  final FocusNode _createdUserFocus = FocusNode();
  final FocusNode _suppGroupFocus = FocusNode();
  final FocusNode _suppCountryFocus = FocusNode();
  final FocusNode _suppStateFocus = FocusNode();
  final FocusNode _suppAreaFocus = FocusNode();
  final FocusNode _areaFocus = FocusNode();
  final FocusNode _pinCodeFocus = FocusNode();
  final FocusNode _compMobileFocus = FocusNode();
  final FocusNode _compPhoneFocus = FocusNode();
  final FocusNode _compMailIdFocus = FocusNode();
  final FocusNode _compwebsiteFocus = FocusNode();
  final FocusNode _compGstNoFocus = FocusNode();
  final FocusNode _compPanNoFocus = FocusNode();
  final FocusNode _compLicenseNoFocus = FocusNode();
  final FocusNode _compfssaiFocus = FocusNode();
  final FocusNode _compbankNameFocus = FocusNode();
  final FocusNode _compAccountNoFocus = FocusNode();
  final FocusNode _compIfscNoFocus = FocusNode();
  final FocusNode _compBranchNameFocus = FocusNode();
  final FocusNode _compBranchAddFocus = FocusNode();
  final FocusNode _compLogoAddFocus = FocusNode();
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
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_suppIdFocus);
    });
    _loadList();
    _suppIdController =
        TextEditingController(text: widget.unitInfo?.supId ?? "");
    _suppNameController =
        TextEditingController(text: widget.unitInfo?.supName ?? "");
    _suppAddress1Controller = TextEditingController(
        text: widget.unitInfo?.supAddress1?.toString() ?? "");
    _supppinCodeController  = TextEditingController(
        text: widget.unitInfo?.supPinCode?.toString() ?? "");
    _suppMobileController = TextEditingController(
        text: widget.unitInfo?.supMobileNo?.toString() ?? "");
    _suppMailIdController = TextEditingController(
        text: widget.unitInfo?.supEmailId?.toString() ?? "");
    _suppGstNoController = TextEditingController(
        text: widget.unitInfo?.supGSTINNo?.toString() ?? "");
    _suppLicenseNoController = TextEditingController(
        text: widget.unitInfo?.supLicenseNo?.toString() ?? "");
    _suppPanNoController = TextEditingController(
        text: widget.unitInfo?.supPanNo?.toString() ?? "");
    _createdUserController = TextEditingController(
        text: widget.unitInfo?.createdUserCode?.toString() ?? userId.value!);

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
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _message = null;
    });

    if (widget.unitInfo == null) {
      // ADD mode

final request = AddSupplierMasterModel(
  supId: _suppIdController.text.toString(),                // Supplier ID
  supName: _suppNameController.text.toString(), // Supplier Name
  supGroupCode: _subGrpCode,              // Group Code (int)
  supAreaCode: _areaCode,               // Area Code (int)
  supStateCode: _stateCode,               // State Code (int)
  supCountryCode: _countryCode,             // Country Code (int) (e.g., India = 91)
  supAddress1: _suppAddress1Controller.text.toString(), // Address
  supPinCode: _supppinCodeController.text.toString(),           // Pincode
  supMobileNo:_suppMobileController.text.toString(),      // Mobile No
  supEmailId: _suppMailIdController.text.toString(), // Email
  supGSTINNo: _suppGstNoController.text.toString(),  // GSTIN
  supLicenseNo: _suppLicenseNoController.text.toString(),      // License No
  supPanNo: _suppPanNoController.text.toString(),         // PAN No
  supGSTType: 1,                  // GST Type (e.g., 1=Registered, 2=Unregistered)
  taxIsIncluded: _isTaxInclusive?1:0,               // Tax Included? (1=yes, 0=no)
  createdUserCode: userId.value!,        // Created By User Code
  supActiveStatus: _activeStatus?1:0             // Active (1=Active, 0=Inactive)
);
print("request");
print(request);
      final response = await _service.addSupplierMaster(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
 final updated = AddSupplierMasterModel(
     supId: _suppIdController.text.toString(),                // Supplier ID
     supName: _suppNameController.text.toString(), // Supplier Name
     supGroupCode: _subGrpCode,              // Group Code (int)
     supAreaCode: _areaCode,               // Area Code (int)
     supStateCode: _stateCode,               // State Code (int)
     supCountryCode: _countryCode,             // Country Code (int) (e.g., India = 91)
     supAddress1: _suppAddress1Controller.text.toString(), // Address
     supPinCode: _supppinCodeController.text.toString(),           // Pincode
     supMobileNo:_suppMobileController.text.toString(),      // Mobile No
     supEmailId: _suppMailIdController.text.toString(), // Email
     supGSTINNo: _suppGstNoController.text.toString(),  // GSTIN
     supLicenseNo: _suppLicenseNoController.text.toString(),      // License No
     supPanNo: _suppPanNoController.text.toString(),         // PAN No
     supGSTType: _taxCode,                  // GST Type (e.g., 1=Registered, 2=Unregistered)
     taxIsIncluded: _isTaxInclusive?1:0,               // Tax Included? (1=yes, 0=no)
     createdUserCode: userId.value!,        // Created By User Code
     supActiveStatus: _activeStatus?1:0             // Active (1=Active, 0=Inactive)
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

  if (success) {
    // Clear all text fields
    _suppIdController.clear();
    _suppNameController.clear();
    _suppAddress1Controller.clear();
    _supppinCodeController.clear();
    _suppMobileController.clear();
    _suppMailIdController.clear();
    _suppGstNoController.clear();
    _suppLicenseNoController.clear();
    _suppPanNoController.clear();
    _unitNameController.clear();
    _unitIdController.clear();

    // Reset dropdowns/flags
    _subGrpCode = 0;
    _areaCode = 0;
    _stateCode = 0;
    _countryCode = 0;
    _taxCode = 1; // default GST Type
    _isTaxInclusive = false;
    _activeStatus = true;

    // Notify parent widget
    widget.onSaved(true);
  }
}
  void _fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  @override
  void didUpdateWidget(covariant AddSupplierMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.supCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.supName ?? "";
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? userId.value!;
      _activeStatus = (widget.unitInfo?.supActiveStatus ?? 1) == 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_getAllLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text("Error: $error"));
    final isEdit = widget.unitInfo != null;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Decide columns by screen width
              int columns = 1; // default mobile
              if (constraints.maxWidth > 1200) {
                columns = 3;
              } else if (constraints.maxWidth > 800) {
                columns = 2;
              }

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  // Example fields (replace with all your CustomTextField/Dropdown etc.)
                  SearchDropdownField<Info>(
                    hintText: "Search Supplier",
                    prefixIcon: Icons.search,
                    fetchItems: (q) async {
                      final response =
                      await _service.getSupplierMasterSearch(q);
                      if (response.isSuccess) {
                        return (response.data?.info ?? [])
                            .whereType<Info>()
                            .toList();
                      }
                      return [];
                    },
                    displayString: (unit) => unit.supName?? "",
                    onSelected: (country) {
                      setState(() {
                        /*  _itemIdController.text =
                            country.itemCode.toString() ?? "";
                        _itemNameController.text = country.itemName ?? "";*/
                        // _createdUserController.text =
                        //     country.createdUserCode?.toString() ?? userId.value!;
                        // _activeStatus = (country.custActiveStatus ?? 1) == 1;
                      });

                      // ✅ Switch form into "Update mode"
                      widget.onSaved(false);
                    },
                  ),
                  SizedBox(
                    width: constraints.maxWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Supplier Status"),
                        SizedBox(
                          width: 10,
                        ),
                        CustomSwitch(
                          value: _activeStatus,
                          title: "Active Status",
                          onChanged: (val) {
                            setState(() {
                              _activeStatus = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Supplier ID",
                      hintText: "Enter Supplier ID",
                      controller: _suppIdController,
                      prefixIcon: Icons.flag_circle,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Supplier ID"
                          : null,
                      focusNode: _suppIdFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _suppIdFocus, _suppNameFocus),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Supplier Name",
                      hintText: "Enter Supplier Name",
                      controller: _suppNameController,
                      prefixIcon: Icons.flag,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Supplier Name"
                          : null,
                      focusNode: _suppNameFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _suppNameFocus, _suppGroupFocus),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomDropdownField<int>(
                      title: "Select Supplier Group",
                      hintText: "Choose Supplier Group",
                      items: getAllMasterListModel!.info!.supplierGroups!
                          .map((e) => DropdownMenuItem<int>(
                        value:
                        e.supGroupCode, // 🔹 use taxCode as value
                        child: Text("${e.supGroupName} "),
                      ))
                          .toList(),
                      // initialValue: _taxCode, // int? taxCode
                      onChanged: (value) {
                        setState(() {
                          _subGrpCode = value;
                          //  _taxCode = value;
                        });

                        final selected = getAllMasterListModel!.info!.supplierGroups!
                            .firstWhere((c) => c.supGroupCode == value,
                            orElse: () => master.SupplierGroups());

                        print("Selected GST %: ${selected.supGroupCode}");
                        print("Selected TAX Code: ${selected.supGroupCode}");
                      },
                      isValidate: true,
                      validator: (value) =>
                      value == null ? "Please select Country" : null,
                      focusNode: _suppGroupFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _suppGroupFocus,
                        _countryNameFocus,
                      ),
                    ),
                  ),



                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomDropdownField<int>(
                      title: "Select Country",
                      hintText: "Choose Country",
                      items: getAllMasterListModel!.info!.countries!
                          .map((e) => DropdownMenuItem<int>(
                        value:
                        e.countryCode, // 🔹 use taxCode as value
                        child: Text("${e.countryName} "),
                      ))
                          .toList(),
                      // initialValue: _taxCode, // int? taxCode
                      onChanged: (value) {
                        setState(() {
                          _countryCode = value;
                          //  _taxCode = value;
                        });

                        final selected = getAllMasterListModel!.info!.countries!
                            .firstWhere((c) => c.countryCode == value,
                            orElse: () => master.Countries());

                        print("Selected GST %: ${selected.countryCode}");
                        print("Selected TAX Code: ${selected.countryCode}");
                      },
                      isValidate: true,
                      validator: (value) =>
                      value == null ? "Please select Country" : null,
                      focusNode: _suppCountryFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _suppCountryFocus,
                        _suppStateFocus,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomDropdownField<int>(
                      title: "Select State",
                      hintText: "Choose State",
                      items: getAllMasterListModel!.info!.states!
                          .map((e) => DropdownMenuItem<int>(
                        value:
                        e.stateCode, // 🔹 use taxCode as value
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
                      focusNode: _suppStateFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _suppStateFocus,
                        _suppAreaFocus
                      ),
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomDropdownField<int>(
                      title: "Select Areas",
                      hintText: "Choose Areas",
                      items: getAllMasterListModel!.info!.areas!
                          .map((e) => DropdownMenuItem<int>(
                        value:
                        e.areaCode, // 🔹 use taxCode as value
                        child: Text("${e.areaName} "),
                      ))
                          .toList(),
                      // initialValue: _taxCode, // int? taxCode
                      onChanged: (value) {
                        setState(() {
                          _areaCode = value;
                          //  _taxCode = value;
                        });

                        final selected = getAllMasterListModel!.info!.areas!
                            .firstWhere((c) => c.stateCode == value,
                            orElse: () => master.Areas());

                        print("Selected GST %: ${selected.areaCode}");
                        print("Selected TAX Code: ${selected.areaCode}");
                      },
                      isValidate: true,
                      validator: (value) =>
                      value == null ? "Please select Area" : null,
                      focusNode: _suppAreaFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _suppAreaFocus,
                        _pinCodeFocus,
                      ),
                    ),
                  ),

                  const Divider(),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Supplier Address",
                      hintText: "Enter Supplier Address",
                      controller: _suppAddress1Controller,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Supplier Address"
                          : null,
                      focusNode: _suppAddress1Focus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _suppAddress1Focus, _pinCodeFocus),
                      autoFocus: true,
                    ),
                  ),


                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Supplier Pin Code",
                      hintText: "Enter Supplier Pin Code",
                      controller: _supppinCodeController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Supplier Pin Code"
                          : null,
                      focusNode: _pinCodeFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _pinCodeFocus, _compMobileFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Supplier Mobile Number",
                      hintText: "Enter Supplier Mobile Number",
                      controller: _suppMobileController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Supplier Mobile Number"
                          : null,
                      focusNode: _compMobileFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compMobileFocus, _compMailIdFocus),
                      autoFocus: true,
                    ),
                  ),


                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Supplier Email ID",
                      hintText: "Enter Supplier Email ID",
                      controller: _suppMailIdController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Supplier Email ID"
                          : null,
                      focusNode: _compMailIdFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compMailIdFocus, _compwebsiteFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Supplier GST Number",
                      hintText: "Enter Supplier GST Number",
                      controller: _suppGstNoController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Supplier GST Number"
                          : null,
                      focusNode: _compGstNoFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compGstNoFocus, _compLicenseNoFocus),
                      autoFocus: true,
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Supplier License Number",
                      hintText: "Enter Supplier License Number",
                      controller: _suppLicenseNoController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Supplier License Number"
                          : null,
                      focusNode: _compLicenseNoFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compLicenseNoFocus, _compPanNoFocus),
                      autoFocus: true,
                    ),
                  ),


                  const Divider(),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Supplier PAN Number",
                      hintText: "Enter Supplier PAN Number",
                      controller: _suppPanNoController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company PAN Number"
                          : null,
                      focusNode: _compPanNoFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compPanNoFocus, _compLicenseNoFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomDropdownField<int>(
                      title: "Select GST Type",
                      hintText: "Choose the GST Type",
                      items: getAllMasterListModel!.info!.taxMasters!
                          .map((e) => DropdownMenuItem<int>(
                        value: e.taxCode, // 🔹 use taxCode as value
                        child:
                        Text("${e.taxName} (${e.taxPercentage}%)"),
                      ))
                          .toList(),
                      // initialValue: _taxCode, // int? taxCode
                      onChanged: (value) {
                        setState(() {
                          _taxCode = value;
                          //  _taxCode = value;
                        });

                        final selected = getAllMasterListModel!
                            .info!.taxMasters!
                            .firstWhere((c) => c.taxCode == value,
                            orElse: () => master.TaxMasters());

                        print("Selected GST %: ${selected.taxPercentage}");
                        print("Selected TAX Code: ${selected.taxCode}");
                      },
                      isValidate: true,
                      validator: (value) =>
                      value == null ? "Please select a GST" : null,
                    ),
                  ),



                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Create User",
                      controller: _createdUserController,
                      prefixIcon: Icons.person,
                      isEdit: true,
                      focusNode: _createUserFocus,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _submit,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Is Tax Inclusive"),
                        SizedBox(
                          width: 10,
                        ),
                        CustomSwitch(
                          value: _isTaxInclusive,
                          title: "Active Status",
                          onChanged: (val) {
                            setState(() {
                              _isTaxInclusive = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(height: 16),
                  if (_loading)
                    const CircularProgressIndicator()
                  else
                    GradientButton(
                        text: isEdit ? "Update Supplier" : "Add Supplier",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
