import 'package:facebilling/ui/screens/masters/country/AddCountryScreen.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/company_master/add_company_master_model.dart';
import '../../../../data/models/company_master/company_master_list_model.dart';
import '../../../../data/models/get_all_master_list_model.dart' as master;
import '../../../../data/services/comapany_master_service.dart';
import '../../../../data/services/get_all_master_service.dart';
import '../../../widgets/custom_dropdown_text_field.dart';
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
  final GetAllMasterService _getAllMasterService = GetAllMasterService();
  int? _areaCode, _cityCode, _stateCode, _countryCode, _itemGeneric;
  bool _activeStatus = true;
  bool _loading = false;
  String? _message;
  bool _getAllLoading = true;

  String? error;

  late TextEditingController _unitIdController;
  late TextEditingController _unitNameController;

  master.GetAllMasterListModel? getAllMasterListModel;
  late TextEditingController _compNameController;
  late TextEditingController _compShortNameController;
  late TextEditingController _compAddress1Controller;
  late TextEditingController _compAddress2Controller;
  late TextEditingController _compAddress3Controller;
  late TextEditingController _compAddress4Controller;
  late TextEditingController _compAddress5Controller;
  late TextEditingController _cityController;
  late TextEditingController _pinCodeController;
  late TextEditingController _compMobileController;
  late TextEditingController _compPhoneController;
  late TextEditingController _compMailIdController;
  late TextEditingController _compwebsiteController;
  late TextEditingController _compGstNoController;
  late TextEditingController _compPanNoController;
  late TextEditingController _compLicenseNoController;
  late TextEditingController _compfssaiController;
  late TextEditingController _compbankNameController;
  late TextEditingController _compAccountNoController;
  late TextEditingController _compIfscNoController;
  late TextEditingController _compBranchNameController;
  late TextEditingController _compBranchAddController;
  late TextEditingController _compLogoAddController;

  // 🔹 FocusNodes
  final FocusNode _compNameFocus = FocusNode();
  final FocusNode _compShortNameFocus = FocusNode();
  final FocusNode _compAddress1Focus = FocusNode();
  final FocusNode _compAddress2Focus = FocusNode();
  final FocusNode _compAddress3Focus = FocusNode();
  final FocusNode _compAddress4Focus = FocusNode();
  final FocusNode _compAddress5Focus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
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

  // late TextEditingController _createdUserController;

  final FocusNode _unitIdFocus = FocusNode();
  final FocusNode _unitNameFocus = FocusNode();
  // final FocusNode _createdUserFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadList();
    _unitIdController =
        TextEditingController(text: widget.unitInfo?.coCode.toString() ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.coName ?? "");
    // _createdUserController = TextEditingController(
    //     text: widget.countryInfo?.createdUserCode?.toString() ?? "1001");
    _activeStatus = (widget.unitInfo?.coActiveStatus ?? 1) == 1;

    _compNameController =
        TextEditingController(text: widget.unitInfo?.coName ?? "");
    _compShortNameController = TextEditingController(
        text: widget.unitInfo?.coShortName?.toString() ?? "");
    _compAddress1Controller = TextEditingController(
        text: widget.unitInfo?.coAddress1?.toString() ?? "");
    _compAddress2Controller = TextEditingController(
        text: widget.unitInfo?.coAddress2?.toString() ?? "");
    _compAddress3Controller = TextEditingController(
        text: widget.unitInfo?.coAddress3?.toString() ?? "");
    _compAddress4Controller = TextEditingController(
        text: widget.unitInfo?.coAddress4?.toString() ?? "");
    _compAddress5Controller = TextEditingController(
        text: widget.unitInfo?.coAddress5?.toString() ?? "");
    _cityController = TextEditingController(
        text: widget.unitInfo?.cityCode?.toString() ?? "");
    _pinCodeController = TextEditingController(
        text: widget.unitInfo?.coPinCode?.toString() ?? "");
    _compMobileController = TextEditingController(
        text: widget.unitInfo?.coMobileNo1?.toString() ?? "");
    _compPhoneController = TextEditingController(
        text: widget.unitInfo?.coPhoneNo1?.toString() ?? "");
    _compMailIdController = TextEditingController(
        text: widget.unitInfo?.coMailId?.toString() ?? "");
    _compwebsiteController = TextEditingController(
        text: widget.unitInfo?.coWebsite?.toString() ?? "");
    _compGstNoController = TextEditingController(
        text: widget.unitInfo?.coGstinNo?.toString() ?? "");
    _compPanNoController =
        TextEditingController(text: widget.unitInfo?.coPanNo?.toString() ?? "");
    _compLicenseNoController = TextEditingController(
        text: widget.unitInfo?.coLicenseNo1?.toString() ?? "");
    _compfssaiController = TextEditingController(
        text: widget.unitInfo?.coFSSAINo?.toString() ?? "");
    _compbankNameController = TextEditingController(
        text: widget.unitInfo?.coBankName?.toString() ?? "");
    _compbankNameController = TextEditingController(
        text: widget.unitInfo?.coBankName?.toString() ?? "");
    _compAccountNoController =
        TextEditingController(text: widget.unitInfo?.coAccNo?.toString() ?? "");
    _compIfscNoController = TextEditingController(
        text: widget.unitInfo?.coIFSCCode?.toString() ?? "");
    _compBranchNameController = TextEditingController(
        text: widget.unitInfo?.coBranchName?.toString() ?? "");
    _compBranchAddController = TextEditingController(
        text: widget.unitInfo?.coBankAdd1?.toString() ?? "");
    _compLogoAddController =
        TextEditingController(text: widget.unitInfo?.coLogo?.toString() ?? "");
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
        coName: _compNameController.text.trim(),
        coShortName: _compShortNameController.text.trim(),
        coAddress1: _compAddress1Controller.text.trim(),
        coAddress2: _compAddress2Controller.text.trim(),
        coAddress3: _compAddress3Controller.text.trim(),
        coAddress4: _compAddress4Controller.text.trim(),
        coAddress5: _compAddress5Controller.text.trim(),
        areaCode: _areaCode,
        cityCode: int.parse(_cityController.text.trim()),
        coPinCode: _pinCodeController.text.trim(),
        stateCode: _stateCode,
        countryCode: _countryCode,
        coMobileNo1: _compMobileController.text.trim(),
        coPhoneNo1: _compPhoneController.text.trim(),
        coMailId: _compMailIdController.text.trim(),
        coWebsite: _compwebsiteController.text.trim(),
        coGstinNo: _compGstNoController.text.trim(),
        coPanNo: _compPanNoController.text.trim(),
        coLicenseNo1: _compLicenseNoController.text.trim(),
        coFSSAINo: _compfssaiController.text.trim(),
        coBankName: _compbankNameController.text.trim(),
        coAccNo: _compAccountNoController.text.trim(),
        coIFSCCode: _compIfscNoController.text.trim(),
        coBranchName: _compBranchNameController.text.trim(),
        coBankAdd1: _compBranchAddController.text.trim(),
        coLogo: _compLogoAddController.text.trim(),
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
        coName: _compNameController.text.trim(),
        coShortName: _compShortNameController.text.trim(),
        coAddress1: _compAddress1Controller.text.trim(),
        coAddress2: _compAddress2Controller.text.trim(),
        coAddress3: _compAddress3Controller.text.trim(),
        coAddress4: _compAddress4Controller.text.trim(),
        coAddress5: _compAddress5Controller.text.trim(),
        areaCode: _areaCode,
        cityCode: int.parse(_cityController.text.trim()),
        coPinCode: _pinCodeController.text.trim(),
        stateCode: _stateCode,
        countryCode: _countryCode,
        coMobileNo1: _compMobileController.text.trim(),
        coPhoneNo1: _compPhoneController.text.trim(),
        coMailId: _compMailIdController.text.trim(),
        coWebsite: _compwebsiteController.text.trim(),
        coGstinNo: _compGstNoController.text.trim(),
        coPanNo: _compPanNoController.text.trim(),
        coLicenseNo1: _compLicenseNoController.text.trim(),
        coFSSAINo: _compfssaiController.text.trim(),
        coBankName: _compbankNameController.text.trim(),
        coAccNo: _compAccountNoController.text.trim(),
        coIFSCCode: _compIfscNoController.text.trim(),
        coBranchName: _compBranchNameController.text.trim(),
        coBankAdd1: _compBranchAddController.text.trim(),
        coLogo: _compLogoAddController.text.trim(),
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

  void _handleResponse(bool success, String? error) {
    setState(() {
      _loading = false;
      _message = success ? "Saved successfully!" : error;
    });
    if (success) widget.onSaved(true);
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
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
                    hintText: "Search Company",
                    prefixIcon: Icons.search,
                    fetchItems: (q) async {
                      final response =
                          await _service.getComapanyMasterSearch(q);
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
                        /*  _itemIdController.text =
                            country.itemCode.toString() ?? "";
                        _itemNameController.text = country.itemName ?? "";*/
                        // _createdUserController.text =
                        //     country.createdUserCode?.toString() ?? "1001";
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
                        Text("Company Status"),
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
                      title: "Company Name",
                      hintText: "Enter Company Name",
                      controller: _compNameController,
                      prefixIcon: Icons.flag,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Name"
                          : null,
                      focusNode: _compNameFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compNameFocus, _compShortNameFocus),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Short Name",
                      hintText: "Enter Company Short Name",
                      controller: _compShortNameController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Product Name"
                          : null,
                      focusNode: _compShortNameFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compShortNameFocus, _compShortNameFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Address Line1",
                      hintText: "Enter Company Address Line1",
                      controller: _compAddress1Controller,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Product Name"
                          : null,
                      focusNode: _compAddress1Focus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compAddress1Focus, _compAddress2Focus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Address Line2",
                      hintText: "Enter Company Address Line2",
                      controller: _compAddress2Controller,
                      isValidate: false,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Address Line2"
                          : null,
                      focusNode: _compAddress2Focus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compAddress2Focus, _compAddress3Focus),
                      autoFocus: true,
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Address Line3",
                      hintText: "Enter Company Address Line3",
                      controller: _compAddress3Controller,
                      isValidate: false,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Address Line3"
                          : null,
                      focusNode: _compAddress3Focus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compAddress3Focus, _compAddress4Focus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Address Line4",
                      hintText: "Enter Company Address Line4",
                      controller: _compAddress4Controller,
                      isValidate: false,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Address Line4"
                          : null,
                      focusNode: _compAddress4Focus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compAddress4Focus, _compAddress5Focus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Address Line5",
                      hintText: "Enter Company Address Line5",
                      controller: _compAddress5Controller,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Address Line5"
                          : null,
                      focusNode: _compAddress5Focus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compAddress5Focus, _countryFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomDropdownField<int>(
                      
                      title: "Select Country",
                      hintText: "Choose Country",
                  items: getAllMasterListModel!.info!.countries!
    .map((e) => DropdownMenuItem<int>(
          value: e.countryCode,
          child: Text(e.countryName!), // ✅ must be Text
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
                      focusNode: _countryFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _countryFocus,
                        _stateFocus,
                      ),
                      addPage: AddCountryScreen(
                        onSaved: (success) {
                          if (success) {
                            Navigator.pop(context, true);
                          }
                        },
                      ),
                      addTooltip: "Add Country",
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomDropdownField<int>(
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
                      focusNode: _countryFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _stateFocus,
                        _cityFocus,
                      ),
                    ),
                  ),

                  const Divider(),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "City Code",
                      hintText: "Enter City Code",
                      controller: _cityController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter City Code"
                          : null,
                      focusNode: _cityFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          _fieldFocusChange(context, _cityFocus, _areaFocus),
                      autoFocus: true,
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomDropdownField<int>(
                      title: "Select Areas",
                      hintText: "Choose Areas",
                      items: getAllMasterListModel!.info!.areas!
                          .map((e) => DropdownMenuItem<int>(
                                value: e.areaCode, // 🔹 use taxCode as value
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
                      focusNode: _countryFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _areaFocus,
                        _pinCodeFocus,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Pin Code",
                      hintText: "Enter Pin Code",
                      controller: _pinCodeController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Pin Code"
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
                      title: "Company Mobile Number",
                      hintText: "Enter Company Mobile Number",
                      controller: _compMobileController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Mobile Number"
                          : null,
                      focusNode: _compMobileFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compMobileFocus, _compPhoneFocus),
                      autoFocus: true,
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Phone Number",
                      hintText: "Enter Company Phone Number",
                      controller: _compPhoneController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Phone Number"
                          : null,
                      focusNode: _compPhoneFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compPhoneFocus, _compMailIdFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Mail ID",
                      hintText: "Enter Company Mail Id",
                      controller: _compMailIdController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Phone Number"
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
                      title: "Company Website",
                      hintText: "Enter Company Website",
                      controller: _compwebsiteController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Website"
                          : null,
                      focusNode: _compwebsiteFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compwebsiteFocus, _compGstNoFocus),
                      autoFocus: true,
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company GST Number",
                      hintText: "Enter Company GST Number",
                      controller: _compGstNoController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company GST Number"
                          : null,
                      focusNode: _compGstNoFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compGstNoFocus, _compPanNoFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company PAN Number",
                      hintText: "Enter Company PAN Number",
                      controller: _compPanNoController,
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

                  const Divider(),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company License Number",
                      hintText: "Enter Company License Number",
                      controller: _compLicenseNoController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company GST Number"
                          : null,
                      focusNode: _compLicenseNoFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compLicenseNoFocus, _compfssaiFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company FSSAI Number",
                      hintText: "Enter Company FSSAI Number",
                      controller: _compfssaiController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company FSSAI Number"
                          : null,
                      focusNode: _compfssaiFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compfssaiFocus, _compbankNameFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Bank Name",
                      hintText: "Enter Company Bank Name",
                      controller: _compbankNameController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Bank Name"
                          : null,
                      focusNode: _compbankNameFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compbankNameFocus, _compAccountNoFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Account Number",
                      hintText: "Enter Company Account Number",
                      controller: _compAccountNoController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Account Number"
                          : null,
                      focusNode: _compAccountNoFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compAccountNoFocus, _compIfscNoFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company IFSC Code",
                      hintText: "Enter Company IFSC Code",
                      controller: _compIfscNoController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company IFSC Code"
                          : null,
                      focusNode: _compIfscNoFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compIfscNoFocus, _compBranchNameFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Branch Name",
                      hintText: "Enter Company Branch Name",
                      controller: _compBranchNameController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Branch Name"
                          : null,
                      focusNode: _compBranchNameFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compBranchNameFocus, _compBranchAddFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Bank Address",
                      hintText: "Enter Company Bank Address",
                      controller: _compBranchAddController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Bank Address"
                          : null,
                      focusNode: _compBranchAddFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compBranchAddFocus, _compLogoAddFocus),
                      autoFocus: true,
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Company Logo",
                      hintText: "Enter Company Logo",
                      controller: _compLogoAddController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Company Logo"
                          : null,
                      focusNode: _compLogoAddFocus,
                      textInputAction: TextInputAction.next,
                      autoFocus: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_loading)
                    const CircularProgressIndicator()
                  else
                    GradientButton(
                        text: isEdit ? "Update Company" : "Add Company",
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
