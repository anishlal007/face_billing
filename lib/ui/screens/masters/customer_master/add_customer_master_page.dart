import 'package:facebilling/ui/screens/masters/area_master/add_area_master_page.dart';
import 'package:flutter/material.dart';
import 'package:facebilling/core/const.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/get_all_master_list_model.dart' as master;
import '../../../../data/models/customer_master/add_customer_master_model.dart';
import '../../../../data/models/customer_master/customer_master_list_model.dart';
import '../../../../data/services/customer_master_service.dart';
import '../../../../data/services/get_all_master_service.dart';
import '../../../widgets/custom_dropdown_text_field.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown.dart';
import '../../../widgets/search_dropdown_field.dart';

class AddCustomerMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddCustomerMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddCustomerMasterPage> createState() => _AddCustomerMasterPageState();
}

class _AddCustomerMasterPageState extends State<AddCustomerMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final CustomerMasterService _service = CustomerMasterService();
  final GetAllMasterService _getAllMasterService = GetAllMasterService();
  bool _isEditMode = false; 
  bool _loading = false;
  String? _message;
  bool _getAllLoading = true;
  int? _areaCode,
      _cityCode,
      _stateCode,
      _countryCode,
      _subGrpCode,
      _taxCode,
      _gender;
  bool _activeStatus = true, _isTaxInclusive = true;
  String? error, _genderValue;
master.States? _selectedState;
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
  late TextEditingController _customerDobController;
  late TextEditingController _createdUserController;
  // late TextEditingController _createdUserController;
  final FocusNode _countryNameFocus = FocusNode();
  final FocusNode _unitIdFocus = FocusNode();
  final FocusNode _unitNameFocus = FocusNode();
  final FocusNode _suppIdFocus = FocusNode();
  final FocusNode _suppNameFocus = FocusNode();
  final FocusNode _supDobFocus = FocusNode();
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
  // final FocusNode _createdUserFocus = FocusNode();

 Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // default date
      firstDate: DateTime(2000), // earliest date allowed
      lastDate: DateTime(2100),  // latest date allowed
    );

    if (pickedDate != null) {
      setState(() {
        _customerDobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }
   int _taxOption = 1;
  @override
  void initState() {
    super.initState();

    _unitIdController =
        TextEditingController(text: widget.unitInfo?.custId ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.custName ?? "");
    _countryNameController =
        TextEditingController(text: "India");
    // _createdUserController = TextEditingController(
    //     text: widget.countryInfo?.createdUserCode?.toString() ?? userId.value!);
    _activeStatus = (widget.unitInfo?.custActiveStatus ?? 1) == 1;

    _loadList();
    _suppIdController =
        TextEditingController(text: widget.unitInfo?.custId ?? "");
    _suppNameController =
        TextEditingController(text: widget.unitInfo?.custName ?? "");
    _suppAddress1Controller = TextEditingController(
        text: widget.unitInfo?.custaddress1?.toString() ?? "");
    _supppinCodeController = TextEditingController(
        text: widget.unitInfo?.custPinCode?.toString() ?? "");
    _suppMobileController = TextEditingController(
        text: widget.unitInfo?.custMobileNo?.toString() ?? "");
    _suppMailIdController = TextEditingController(
        text: widget.unitInfo?.custEmailId?.toString() ?? "");
    _suppGstNoController = TextEditingController(
        text: widget.unitInfo?.custGSTINNo?.toString() ?? "");
    _customerDobController =
        TextEditingController(text: widget.unitInfo?.custDOB?.toString() ?? "");
    _createdUserController = TextEditingController(
        text: widget.unitInfo?.createdUserCode?.toString() ?? userId.value!);
  }

Future<void> _loadList() async {
  final response = await _getAllMasterService.getAllMasterService();

  if (response.isSuccess) {
    final data = response.data!;
    final countries = data.info?.countries ?? [];
    final states = data.info?.states ?? [];
final groups = data.info?.customerGroups ?? [];
    // 🔹 Set default country → India
    int? defaultCountryCode;
    if (countries.isNotEmpty) {
      final india = countries.firstWhere(
        (c) => (c.countryName ?? '').toLowerCase() == 'india',
        orElse: () => countries.first,
      );
      defaultCountryCode = india.countryCode;
    }

    // 🔹 Set default state → Tamil Nadu
    master.States? defaultState;
    int? defaultStateCode;
    if (states.isNotEmpty) {
      defaultState = states.firstWhere(
        (s) => (s.stateName ?? '').toLowerCase() == 'tamil nadu',
        orElse: () => states.first,
      );
      defaultStateCode = defaultState.stateCode;
    }
  int? defaultGroupCode;
  if (groups.isNotEmpty) {
    final commonGroup = groups.firstWhere(
      (g) => (g.custGroupName ?? '').toLowerCase() == 'Common Group',
      orElse: () => groups[1],
    );
    defaultGroupCode = commonGroup.custGroupCode;
  }

    setState(() {
      getAllMasterListModel = data;
      _countryCode = defaultCountryCode;
      _stateCode = defaultStateCode;
      _selectedState = defaultState;
      _subGrpCode = defaultGroupCode;
      _getAllLoading = false;
      error = null;
    });

    print("Default Country: India ($_countryCode)");
    print("Default State: Tamil Nadu ($_stateCode)");
     print("Default Patient Group: $_subGrpCode");
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

  void _fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
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
      final request = AddCustomerMasterModel(
        custId: _suppIdController.text.trim(),
        custName: _suppNameController.text.trim(),
        custDOB: _customerDobController.text.trim(),
        gender: _gender,
        custGroupCode: _subGrpCode,
        custAreaCode: _areaCode,
        custStateCode: _stateCode,
        custCountryCode: _countryCode,
        custAddress1: _suppAddress1Controller.text.trim(),
        custPinCode: _supppinCodeController.text.trim(),
        custMobileNo: _suppMobileController.text.trim(),
        custEmailId: _suppMailIdController.text.trim(),
        custGSTINNo: _suppGstNoController.text.trim(),
        custGSTType: 2,
        taxIsIncluded: _isTaxInclusive ? 1 : 0,
        custCreatedDate: DateTime.now().toIso8601String(),
        createdUserCode: 1,
        updatedUserCode: 1,
        // current timestamp
        custActiveStatus: _activeStatus ? 1 : 0,
      );
      print("request");
      print(request);
      final response = await _service.addCustomerMaster(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
      final updated = AddCustomerMasterModel(
        custId: _suppIdController.text.trim(),
        custName: _suppNameController.text.trim(),
        custDOB: _customerDobController.text.trim(),
        gender: _gender,
        custGroupCode: _subGrpCode,
        custAreaCode: _areaCode,
        custStateCode: _stateCode,
        custCountryCode: _countryCode,
        custAddress1: _suppAddress1Controller.text.trim(),
        custPinCode: _supppinCodeController.text.trim(),
        custMobileNo: _suppMobileController.text.trim(),
        custEmailId: _suppMailIdController.text.trim(),
        custGSTINNo: _suppGstNoController.text.trim(),
        custGSTType: 2,
        taxIsIncluded: _isTaxInclusive ? 1 : 0,
        custCreatedDate: DateTime.now().toIso8601String(),
        createdUserCode: 1,
        updatedUserCode: 1,

        // current timestamp
        custActiveStatus: _activeStatus ? 1 : 0,
      );
      print("updated");
      print(updated);
      final response = await _service.updateCustomerMaster(
        widget.unitInfo!.custCode!,
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
  void didUpdateWidget(covariant AddCustomerMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.custCode.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.custName ?? "";
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? userId.value!;
      _activeStatus = (widget.unitInfo?.custActiveStatus ?? 1) == 1;
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
                    hintText: "Search Pataint",
                    prefixIcon: Icons.search,
                    fetchItems: (q) async {
                      final response =
                          await _service.getCustomerMasterSearch(q);
                      if (response.isSuccess) {
                        return (response.data?.info ?? [])
                            .whereType<Info>()
                            .toList();
                      }
                      return [];
                    },
                    displayString: (unit) => unit.custName ?? "",
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
                        Text("Pataint Status"),
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
    title: "Patient ID",
    hintText: "Enter Patient ID",
    controller: _suppIdController,
    prefixIcon: Icons.flag_circle,
    isValidate: true,
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return "Enter Patient ID";
      }
      return null;
    },
    focusNode: _suppIdFocus,
    textInputAction: TextInputAction.next,
    onEditingComplete: () => _fieldFocusChange(
      context,
      _suppIdFocus,
      _suppNameFocus,
    ),
  ),
),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Pataint Name",
                      hintText: "Enter Pataint Name",
                      controller: _suppNameController,
                      prefixIcon: Icons.flag,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Pataint Name"
                          : null,
                      focusNode: _suppNameFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _suppNameFocus, _supDobFocus),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: GestureDetector(
                      onTap: (){
                        _pickDate();
                      },
                      child: CustomTextField(
                        title: "Pataint Date Of Birth",
                        hintText: "Enter Pataint Date Of Birth",
                        controller: _customerDobController,
                        isValidate: true,
                        isEdit: true,
                        validator: (value) => value == null || value.isEmpty
                            ? "Enter Pataint Date Of Birth"
                            : null,
                        focusNode: _supDobFocus,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => _fieldFocusChange(
                            context, _supDobFocus, _suppGroupFocus),
                      ),
                    ),
                  ),

                  // Define a variable in your State
                  // will hold "Male" or "Female"

// Inside your build() -> children[]
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text("Male"),
                                value: "Male",
                                groupValue: _genderValue,
                                onChanged: (value) {
                                  setState(() {
                                    _genderValue = value;
                                    _gender = 1;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text("Female"),
                                value: "Female",
                                groupValue: _genderValue,
                                onChanged: (value) {
                                  setState(() {
                                    _genderValue = value;
                                    _gender = 2;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                 SizedBox(
  width: constraints.maxWidth / columns - 20,
  child: CustomDropdownField<int>(
    title: "Select Patient Group",
    hintText: "Choose Patient Group",
    items: getAllMasterListModel!.info!.customerGroups!
        .map((e) => DropdownMenuItem<int>(
              value: e.custGroupCode,
              child: Text(e.custGroupName ?? ''),
            ))
        .toList(),

    // 🔹 Set default value to "Common" group
    initialValue: _subGrpCode, // will hold default or selected value

    onChanged: (value) {
      setState(() {
        _subGrpCode = value;
      });

      final selected = getAllMasterListModel!.info!.customerGroups!.firstWhere(
        (c) => c.custGroupCode == value,
        orElse: () => master.CustomerGroups(),
      );

      print("Selected Group: ${selected.custGroupName}");
    },

    isValidate: true,
    validator: (value) =>
        value == null ? "Please select Patient Group" : null,
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
                        initialValue: _countryCode,
                      controller: _countryNameController,
                      title: "Select Country",
                      hintText: "Choose Country",
                      items: getAllMasterListModel!.info!.countries!
                          .map((e) => DropdownMenuItem<int>(
                                value: e.countryCode, // 🔹 use taxCode as value
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
                      child: SearchableDropdown<master.States>(
                      initialValue: _selectedState!,
                        hintText: "Select State",
                        items: getAllMasterListModel!.info!.states!,
                        itemLabel: (supplier) => supplier.stateName ?? "",
                        onChanged: (supplier) {
                          if (supplier != null) {
                         _selectedState = supplier;
                            print("Selected Code: ${supplier.stateCode}");
                            print("Selected Name: ${supplier.stateName}");
                         //   print("Selected GSt type: ${supplier.supGSTType}");
                            _stateCode=supplier.stateCode;
                            print("_stateCode");
                            print(_stateCode);
                             // TaxType: 0=Exclusive, 1=Inclusive
                       
                           
                          }
                        },
                      ),
                    ),
                   
                  // SizedBox(
                  //   width: constraints.maxWidth / columns - 20,
                  //   child: CustomDropdownField<int>(
                  //     initialValue: _stateCode,
                  //     title: "Select State",
                  //     hintText: "Choose State",
                  //     items: getAllMasterListModel!.info!.states!
                  //         .map((e) => DropdownMenuItem<int>(
                  //               value: e.stateCode, // 🔹 use taxCode as value
                  //               child: Text("${e.stateName} "),
                  //             ))
                  //         .toList(),
                  //     // initialValue: _taxCode, // int? taxCode
                  //     onChanged: (value) {
                  //       setState(() {
                  //         _stateCode = value;
                  //         //  _taxCode = value;
                  //       });

                  //       final selected = getAllMasterListModel!.info!.states!
                  //           .firstWhere((c) => c.stateCode == value,
                  //               orElse: () => master.States());

                  //       print("Selected GST %: ${selected.stateCode}");
                  //       print("Selected TAX Code: ${selected.stateCode}");
                  //     },
                  //     isValidate: true,
                  //     validator: (value) =>
                  //         value == null ? "Please select State" : null,
                  //     focusNode: _suppStateFocus,
                  //     onEditingComplete: () => _fieldFocusChange(
                  //         context, _suppStateFocus, _suppAreaFocus),
                  //   ),
                  // ),

                  // SizedBox(
                  //   width: constraints.maxWidth / columns - 20,
                  //   child: CustomDropdownField<int>(
                  //     title: "Select Areas",
                  //     hintText: "Choose Areas",
                  //     items: getAllMasterListModel!.info!.areas!
                  //         .map((e) => DropdownMenuItem<int>(
                  //               value: e.areaCode, // 🔹 use taxCode as value
                  //               child: Text("${e.areaName} "),
                  //             ))
                  //         .toList(),
                  //     // initialValue: _taxCode, // int? taxCode
                  //     onChanged: (value) {
                  //       setState(() {
                  //         _areaCode = value;
                  //         //  _taxCode = value;
                  //       });

                  //       final selected = getAllMasterListModel!.info!.areas!
                  //           .firstWhere((c) => c.stateCode == value,
                  //               orElse: () => master.Areas());

                  //       print("Selected GST %: ${selected.areaCode}");
                  //       print("Selected TAX Code: ${selected.areaCode}");
                        

                  //     },
                  //     isValidate: true,
                  //     validator: (value) =>
                  //         value == null ? "Please select Area" : null,
                  //     focusNode: _suppAreaFocus,
                  //     onEditingComplete: () => _fieldFocusChange(
                  //       context,
                  //       _suppAreaFocus,
                  //       _pinCodeFocus,
                  //     ),
                  //   ),
                  // ),

 SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: SearchableDropdown<master.Areas>(
                      hintText: "Select Area",
                     // initialValue: _selectItemMake,
                      items: getAllMasterListModel!.info!.areas!,
                      itemLabel: (group) => group.areaName ?? "",
                      onChanged: (group) {
                        if (group != null) {
                         // _itemMake = group.itemMakeCode;
                          //_selectItemMake = group;
                          print("Selected Code: ${group.areaCode}");
                          print("Selected Name: ${group.areaName}");
                           _areaCode = group.areaCode;
                           print("_areaCode");
                           print(_areaCode);
                        }

                      },
                      focusNode: _suppAreaFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                     _suppAreaFocus,
                        _pinCodeFocus,
                      ),
                      // Add page popup
                      addPage: AddAreaMasterPage(
                        onSaved: (success) {
                          if (success) {
                            Navigator.pop(context, true);
                          }
                        },
                      ),
                      addTooltip: "Add Area",
                    ),
                  ),

                  const Divider(),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Pataint Address",
                      hintText: "Enter Pataint Address",
                      controller: _suppAddress1Controller,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Pataint Address"
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
                      title: "Pataint Pin Code",
                      hintText: "Enter Pataint Pin Code",
                      controller: _supppinCodeController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Pataint Pin Code"
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
                      title: "Pataint Mobile Number",
                      hintText: "Enter Pataint Mobile Number",
                      controller: _suppMobileController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Pataint Mobile Number"
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
                      title: "Pataint Email ID",
                      hintText: "Enter Pataint Email ID",
                      controller: _suppMailIdController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Pataint Email ID"
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
                      title: "Pataint GST Number",
                      hintText: "Enter Pataint GST Number",
                      controller: _suppGstNoController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Pataint GST Number"
                          : null,
                      focusNode: _compGstNoFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _fieldFocusChange(
                          context, _compGstNoFocus, _compLicenseNoFocus),
                      autoFocus: true,
                    ),
                  ),

                  const Divider(),

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

                  // SizedBox(
                  //   width: constraints.maxWidth / columns - 20,
                  //   child: CustomTextField(
                  //     title: "Create Pataint",
                  //     controller: _createdUserController,
                  //     prefixIcon: Icons.person,
                  //     isEdit: true,
                  //     focusNode: _createUserFocus,
                  //     textInputAction: TextInputAction.done,
                  //     onEditingComplete: _submit,
                  //   ),
                  // ),

                  SizedBox(
                    width: constraints.maxWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Is Tax Inclusive"),
                        SizedBox(
                          width: 10,
                        ),
       
        Row(
          children: [
            Radio<int>(
              value: 1,
              groupValue: _taxOption,
              onChanged: (value) {
                setState(() {
                  _taxOption = value!;
                  _isTaxInclusive=false!;
                });
              },
            ),
            const Text('Included'),

            const SizedBox(width: 20),

            Radio<int>(
              value: 0,
              groupValue: _taxOption,
              onChanged: (value) {
                setState(() {
                  _taxOption = value!;
                  _isTaxInclusive=true!;
                });
              },
            ),
            const Text('Excluded'),
          ],
        ),
                        // CustomSwitch(
                        //   value: _isTaxInclusive,
                        //   title: "Active Status",
                        //   onChanged: (val) {
                        //     setState(() {
                        //       _isTaxInclusive = val;
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  if (_loading)
                    const CircularProgressIndicator()
                  else
                    GradientButton(
                        text: isEdit ? "Update Customer" : "Add Customer",
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
