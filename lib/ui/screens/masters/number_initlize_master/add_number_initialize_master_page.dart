import 'package:facebilling/data/models/area_master/area_master_list_model.dart';
import 'package:facebilling/data/models/number_initialize/add_number_initlize_model.dart';
import 'package:facebilling/ui/screens/masters/state_master/add_state_master_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/const.dart'; 
import '../../../../data/models/area_master/add_area_master_model.dart';
import '../../../../data/services/area_master_service.dart';
import '../../../../data/services/get_all_master_service.dart';
import '../../../../data/services/number_initialize_service.dart';
import '../../../../data/services/user_master_service.dart';
import '../../../widgets/custom_dropdown_text_field.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

import '../../../../data/models/get_all_master_list_model.dart' as master;

class AddNumberInitializeMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddNumberInitializeMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddNumberInitializeMasterPage> createState() => _AddNumberInitializeMasterPageState();
}

class _AddNumberInitializeMasterPageState extends State<AddNumberInitializeMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final NumberInitializeService _service = NumberInitializeService();

  master.GetAllMasterListModel? getAllMasterListModel;

  final GetAllMasterService _getAllMasterService = GetAllMasterService();
  bool _activeStatus = true;
  bool _loading = false;
  String? _message;
  int? _stateCode;
  bool _isEditMode = false; 
  late TextEditingController _unitIdController;
  late TextEditingController _unitNameController;
  late TextEditingController _createdUserController;
  bool _getAllLoading = true;
  final FocusNode _unitIdFocus = FocusNode();
  final FocusNode _unitNameFocus = FocusNode();
  String? error;
  // final FocusNode _createdUserFocus = FocusNode();


// Controllers
final TextEditingController coCodeController = TextEditingController();
final TextEditingController finYearCodeController = TextEditingController();
final TextEditingController custIdPrefixController = TextEditingController();
final TextEditingController custIdController = TextEditingController();
final TextEditingController custIdSuffixController = TextEditingController();
final TextEditingController custIdFormalDigitController = TextEditingController();

final TextEditingController supIdPrefixController = TextEditingController();
final TextEditingController supIdController = TextEditingController();
final TextEditingController supIdSuffixController = TextEditingController();
final TextEditingController supIdFormalDigitController = TextEditingController();
final TextEditingController productIdPrefixController = TextEditingController();

final TextEditingController productIdController = TextEditingController();
final TextEditingController productIdFormalDigitController = TextEditingController();
final TextEditingController purNoPrefixController = TextEditingController();
final TextEditingController purchaseNoController = TextEditingController();
final TextEditingController purNoSuffixController = TextEditingController();
final TextEditingController purNoFormalDigitController = TextEditingController();

final TextEditingController salesNoPrefixController = TextEditingController();
final TextEditingController salesNoController = TextEditingController();
final TextEditingController salesNoSuffixController = TextEditingController();
final TextEditingController salesNoFormalDigitController = TextEditingController();

final TextEditingController purNo2PrefixController = TextEditingController();
final TextEditingController purchaseNo2Controller = TextEditingController();
final TextEditingController purNo2SuffixController = TextEditingController();
final TextEditingController purNo2FormalDigitController = TextEditingController();
final TextEditingController purOrderNoPrefixController = TextEditingController();
final TextEditingController purchaseOderNoController = TextEditingController();
final TextEditingController purOrderNoSuffixController = TextEditingController();
final TextEditingController purOrderNoFormalDigitController = TextEditingController();
final TextEditingController purOrderNo2PrefixController = TextEditingController();
final TextEditingController purchaseOrderNo2Controller = TextEditingController();
final TextEditingController purOrderNo2SuffixController = TextEditingController();
final TextEditingController purOrderNo2FormalDigitController = TextEditingController();

final TextEditingController quoNoPrefixController = TextEditingController();
final TextEditingController quotationNoController = TextEditingController();
final TextEditingController quoNoSuffixController = TextEditingController();
final TextEditingController quoNoFormalDigitController = TextEditingController();
final TextEditingController quoNo2PrefixController = TextEditingController();
final TextEditingController quotationNo2Controller = TextEditingController();
final TextEditingController quoNo2SuffixController = TextEditingController();
final TextEditingController quoNo2FormalDigitController = TextEditingController();
final TextEditingController salesNo2PrefixController = TextEditingController();
final TextEditingController salesNo2Controller = TextEditingController();
final TextEditingController salesNo2SuffixController = TextEditingController();
final TextEditingController salesNo2FormalDigitController = TextEditingController();

final TextEditingController salesOrderNoPrefixController = TextEditingController();
final TextEditingController salesOrderNoController = TextEditingController();
final TextEditingController salesOrderNoFormalDigitController = TextEditingController();
final TextEditingController salesOrderNoSuffixController = TextEditingController();


// FocusNodes
final FocusNode coCodeFocus = FocusNode();
final FocusNode finYearCodeFocus = FocusNode();
final FocusNode custIdPrefixFocus = FocusNode();
final FocusNode custIdFocus = FocusNode();
final FocusNode custIdSuffixFocus = FocusNode();
final FocusNode custIdFormalDigitFocus = FocusNode();
final FocusNode supIdPrefixFocus = FocusNode();
final FocusNode supIdFocus = FocusNode();
final FocusNode supIdSuffixFocus = FocusNode();
final FocusNode supIdFormalDigitFocus = FocusNode();
final FocusNode productIdPrefixFocus = FocusNode();
final FocusNode productIdFocus = FocusNode();
final FocusNode productIdFormalDigitFocus = FocusNode();
final FocusNode purNoPrefixFocus = FocusNode();
final FocusNode purchaseNoFocus = FocusNode();
final FocusNode purNoSuffixFocus = FocusNode();
final FocusNode purNoFormalDigitFocus = FocusNode();
final FocusNode salesNoPrefixFocus = FocusNode();
final FocusNode salesNoFocus = FocusNode();
final FocusNode salesNoSuffixFocus = FocusNode();
final FocusNode salesNoFormalDigitFocus = FocusNode();
final FocusNode purNo2PrefixFocus = FocusNode();
final FocusNode purchaseNo2Focus = FocusNode();
final FocusNode purNo2SuffixFocus = FocusNode();
final FocusNode purNo2FormalDigitFocus = FocusNode();
final FocusNode purOrderNoPrefixFocus = FocusNode();
final FocusNode purchaseOderNoFocus = FocusNode();
final FocusNode purOrderNoSuffixFocus = FocusNode();
final FocusNode purOrderNoFormalDigitFocus = FocusNode();
final FocusNode purOrderNo2PrefixFocus = FocusNode();
final FocusNode purchaseOrderNo2Focus = FocusNode();
final FocusNode purOrderNo2SuffixFocus = FocusNode();
final FocusNode purOrderNo2FormalDigitFocus = FocusNode();
final FocusNode quoNoPrefixFocus = FocusNode();
final FocusNode quotationNoFocus = FocusNode();
final FocusNode quoNoSuffixFocus = FocusNode();
final FocusNode quoNoFormalDigitFocus = FocusNode();
final FocusNode quoNo2PrefixFocus = FocusNode();
final FocusNode quotationNo2Focus = FocusNode();
final FocusNode quoNo2SuffixFocus = FocusNode();
final FocusNode quoNo2FormalDigitFocus = FocusNode();
final FocusNode salesNo2PrefixFocus = FocusNode();
final FocusNode salesNo2Focus = FocusNode();
final FocusNode salesNo2SuffixFocus = FocusNode();
final FocusNode salesNo2FormalDigitFocus = FocusNode();
final FocusNode salesOrderNoPrefixFocus = FocusNode();
final FocusNode salesOrderNoFocus = FocusNode();
final FocusNode salesOrderNoFormalDigitFocus = FocusNode();
final FocusNode salesOrderNoSuffixFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    _loadList();
    _unitIdController =
        TextEditingController(text: widget.unitInfo?.areaId ?? "");
    _unitNameController =
        TextEditingController(text: widget.unitInfo?.areaName ?? "");
    // _createdUserController = TextEditingController(
    //     text: widget.countryInfo?.createdUserCode?.toString() ?? userId.value!);
    _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
     _isEditMode = widget.unitInfo != null;
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
  coCodeController.dispose();
  finYearCodeController.dispose();
  custIdPrefixController.dispose();
  custIdController.dispose();
  custIdSuffixController.dispose();
  custIdFormalDigitController.dispose();
  supIdPrefixController.dispose();
  supIdController.dispose();
  supIdSuffixController.dispose();
  supIdFormalDigitController.dispose();
  productIdPrefixController.dispose();
  productIdController.dispose();
  productIdFormalDigitController.dispose();
  purNoPrefixController.dispose();
  purchaseNoController.dispose();
  purNoSuffixController.dispose();
  purNoFormalDigitController.dispose();
  salesNoPrefixController.dispose();
  salesNoController.dispose();
  salesNoSuffixController.dispose();
  salesNoFormalDigitController.dispose();
  purNo2PrefixController.dispose();
  purchaseNo2Controller.dispose();
  purNo2SuffixController.dispose();
  purNo2FormalDigitController.dispose();
  purOrderNoPrefixController.dispose();
  purchaseOderNoController.dispose();
  purOrderNoSuffixController.dispose();
  purOrderNoFormalDigitController.dispose();
  purOrderNo2PrefixController.dispose();
  purchaseOrderNo2Controller.dispose();
  purOrderNo2SuffixController.dispose();
  purOrderNo2FormalDigitController.dispose();
  quoNoPrefixController.dispose();
  quotationNoController.dispose();
  quoNoSuffixController.dispose();
  quoNoFormalDigitController.dispose();
  quoNo2PrefixController.dispose();
  quotationNo2Controller.dispose();
  quoNo2SuffixController.dispose();
  quoNo2FormalDigitController.dispose();
  salesNo2PrefixController.dispose();
  salesNo2Controller.dispose();
  salesNo2SuffixController.dispose();
  salesNo2FormalDigitController.dispose();
  salesOrderNoPrefixController.dispose();
  salesOrderNoController.dispose();
  salesOrderNoFormalDigitController.dispose();
  salesOrderNoSuffixController.dispose();

  coCodeFocus.dispose();
  finYearCodeFocus.dispose();
  custIdPrefixFocus.dispose();
  custIdFocus.dispose();
  custIdSuffixFocus.dispose();
  custIdFormalDigitFocus.dispose();
  supIdPrefixFocus.dispose();
  supIdFocus.dispose();
  supIdSuffixFocus.dispose();
  supIdFormalDigitFocus.dispose();
  productIdPrefixFocus.dispose();
  productIdFocus.dispose();
  productIdFormalDigitFocus.dispose();
  purNoPrefixFocus.dispose();
  purchaseNoFocus.dispose();
  purNoSuffixFocus.dispose();
  purNoFormalDigitFocus.dispose();
  salesNoPrefixFocus.dispose();
  salesNoFocus.dispose();
  salesNoSuffixFocus.dispose();
  salesNoFormalDigitFocus.dispose();
  purNo2PrefixFocus.dispose();
  purchaseNo2Focus.dispose();
  purNo2SuffixFocus.dispose();
  purNo2FormalDigitFocus.dispose();
  purOrderNoPrefixFocus.dispose();
  purchaseOderNoFocus.dispose();
  purOrderNoSuffixFocus.dispose();
  purOrderNoFormalDigitFocus.dispose();
  purOrderNo2PrefixFocus.dispose();
  purchaseOrderNo2Focus.dispose();
  purOrderNo2SuffixFocus.dispose();
  purOrderNo2FormalDigitFocus.dispose();
  quoNoPrefixFocus.dispose();
  quotationNoFocus.dispose();
  quoNoSuffixFocus.dispose();
  quoNoFormalDigitFocus.dispose();
  quoNo2PrefixFocus.dispose();
  quotationNo2Focus.dispose();
  quoNo2SuffixFocus.dispose();
  quoNo2FormalDigitFocus.dispose();
  salesNo2PrefixFocus.dispose();
  salesNo2Focus.dispose();
  salesNo2SuffixFocus.dispose();
  salesNo2FormalDigitFocus.dispose();
  salesOrderNoPrefixFocus.dispose();
  salesOrderNoFocus.dispose();
  salesOrderNoFormalDigitFocus.dispose();
  salesOrderNoSuffixFocus.dispose();

  super.dispose();
}
dynamic stateCode;
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _message = null;
    });
 final request = AddNumberInitializeModel(
  coCode: coCodeController.text,
  finYearCode: finYearCodeController.text,
  custIdPrefix: custIdPrefixController.text,
  custId: custIdController.text,
  custIdSuffix: custIdSuffixController.text,
  custIdFormalDigit: custIdFormalDigitController.text,
  supIdPrefix: supIdPrefixController.text,
  supId: supIdController.text,
  supIdSuffix: supIdSuffixController.text,
  supIdFormalDigit: supIdFormalDigitController.text,
  productIdPrefix: productIdPrefixController.text,
  productId: productIdController.text,
  productIdFormalDigit: productIdFormalDigitController.text,
  purNoPrefix: purNoPrefixController.text,
  purchaseNo: purchaseNoController.text,
  purNoSuffix: purNoSuffixController.text,
  purNoFormalDigit: purNoFormalDigitController.text,
  salesNoPrefix: salesNoPrefixController.text,
  salesNo: salesNoController.text,
  salesNoSuffix: salesNoSuffixController.text,
  salesNoFormalDigit: salesNoFormalDigitController.text,
  purNo2Prefix: purNo2PrefixController.text,
  purchaseNo2: purchaseNo2Controller.text,
  purNo2Suffix: purNo2SuffixController.text,
  purNo2FormalDigit: purNo2FormalDigitController.text,
  purOrderNoPrefix: purOrderNoPrefixController.text,
  purchaseOderNo: purchaseOderNoController.text,
  purOrderNoSuffix: purOrderNoSuffixController.text,
  purOrderNoFormalDigit: purOrderNoFormalDigitController.text,
  purOrderNo2Prefix: purOrderNo2PrefixController.text,
  purchaseOrderNo2: purchaseOrderNo2Controller.text,
  purOrderNo2Suffix: purOrderNo2SuffixController.text,
  purOrderNo2FormalDigit: purOrderNo2FormalDigitController.text,
  quoNoPrefix: quoNoPrefixController.text,
  quotationNo: quotationNoController.text,
  quoNoSuffix: quoNoSuffixController.text,
  quoNoFormalDigit: quoNoFormalDigitController.text,
  quoNo2Prefix: quoNo2PrefixController.text,
  quotationNo2: quotationNo2Controller.text,
  quoNo2Suffix: quoNo2SuffixController.text,
  quoNo2FormalDigit: quoNo2FormalDigitController.text,
  salesNo2Prefix: salesNo2PrefixController.text,
  salesNo2: salesNo2Controller.text,
  salesNo2Suffix: salesNo2SuffixController.text,
  salesNo2FormalDigit: salesNo2FormalDigitController.text,
  salesOrderNoPrefix: salesOrderNoPrefixController.text,
  salesOrderNo: salesOrderNoController.text,
  salesOrderNoFormalDigit: salesOrderNoFormalDigitController.text,
  salesOrderNoSuffix: salesOrderNoSuffixController.text,
);
      print("request");
      print(request.toJson());
       if (_isEditMode && widget.unitInfo != null) {
      // EDIT mode
      final response = await _service.updateNumberiitialize(
        widget.unitInfo!.areaCode!,
        request,
      );
      _handleResponse(response.isSuccess, response.error);
    } else {
      // ADD mode
      final response = await _service.addNumberInitialize(request);
      _handleResponse(response.isSuccess, response.error);
    }

  }
void _handleResponse(bool success, String? error) {
  if (success) {
    setState(() {
      // Clear all text controllers
      coCodeController.clear();
      finYearCodeController.clear();
      custIdPrefixController.clear();
      custIdController.clear();
      custIdSuffixController.clear();
      custIdFormalDigitController.clear();
      supIdPrefixController.clear();
      supIdController.clear();
      supIdSuffixController.clear();
      supIdFormalDigitController.clear();
      productIdPrefixController.clear();
      productIdController.clear();
      productIdFormalDigitController.clear();
      purNoPrefixController.clear();
      purchaseNoController.clear();
      purNoSuffixController.clear();
      purNoFormalDigitController.clear();
      salesNoPrefixController.clear();
      salesNoController.clear();
      salesNoSuffixController.clear();
      salesNoFormalDigitController.clear();
      purNo2PrefixController.clear();
      purchaseNo2Controller.clear();
      purNo2SuffixController.clear();
      purNo2FormalDigitController.clear();
      purOrderNoPrefixController.clear();
      purchaseOderNoController.clear();
      purOrderNoSuffixController.clear();
      purOrderNoFormalDigitController.clear();
      purOrderNo2PrefixController.clear();
      purchaseOrderNo2Controller.clear();
      purOrderNo2SuffixController.clear();
      purOrderNo2FormalDigitController.clear();
      quoNoPrefixController.clear();
      quotationNoController.clear();
      quoNoSuffixController.clear();
      quoNoFormalDigitController.clear();
      quoNo2PrefixController.clear();
      quotationNo2Controller.clear();
      quoNo2SuffixController.clear();
      quoNo2FormalDigitController.clear();
      salesNo2PrefixController.clear();
      salesNo2Controller.clear();
      salesNo2SuffixController.clear();
      salesNo2FormalDigitController.clear();
      salesOrderNoPrefixController.clear();
      salesOrderNoController.clear();
      salesOrderNoFormalDigitController.clear();
      salesOrderNoSuffixController.clear();

      // Update loading/message state
      _loading = false;
      _message = "Saved successfully!";
    });

    // Callback
    widget.onSaved(true);
  } else {
    setState(() {
      _loading = false;
      _message = error ?? "Something went wrong!";
    });
  }
}

  @override
  void didUpdateWidget(covariant AddNumberInitializeMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _unitIdController.text = widget.unitInfo?.areaId.toString() ?? "";
      _unitNameController.text = widget.unitInfo?.areaName ?? "";
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? userId.value!;
      _activeStatus = (widget.unitInfo?.activeStatus ?? 1) == 1;
          _isEditMode = widget.unitInfo != null;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Company Code"),
                   const Divider(), 
                  CustomTextField(
                title: "Co Code",
                hintText: "Enter Co Code",
                controller: coCodeController,
                prefixIcon: Icons.business,
                isValidate: true,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter Co Code" : null,
                focusNode: coCodeFocus,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context)
                      .requestFocus(finYearCodeFocus);
                },
              ),
              const SizedBox(height: 12),
       const Text("Financial Year"),
                   const Divider(), 
              CustomTextField(
                title: "Financial Year Code",
                hintText: "Enter Fin Year Code",
                controller: finYearCodeController,
                prefixIcon: Icons.calendar_today,
                isValidate: true,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter Fin Year Code" : null,
                focusNode: finYearCodeFocus,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context)
                      .requestFocus(custIdPrefixFocus);
                },
              ),
              const SizedBox(height: 12),
               const Text("Patient Id"),
                   const Divider(), 
              CustomTextField(
                title: "Patient ID Prefix",
                hintText: "Enter Patient ID Prefix",
                controller: custIdPrefixController,
                prefixIcon: Icons.calendar_today,
                isValidate: true,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter Patient ID Prefix" : null,
                focusNode: finYearCodeFocus,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context)
                      .requestFocus(custIdFocus);
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                title: "Patient ID ",
                hintText: "Enter Patient ID ",
                controller: custIdController,
                prefixIcon: Icons.calendar_today,
                isValidate: true,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter Patient ID" : null,
                focusNode: finYearCodeFocus,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context)
                      .requestFocus(custIdSuffixFocus);
                },
              ),
       const SizedBox(height: 12),
              CustomTextField(
                title: "Patient ID Sufix",
                hintText: "Enter Patient ID Sufix",
                controller: custIdSuffixController,
                prefixIcon: Icons.calendar_today,
                isValidate: true,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter Patient ID Sufix" : null,
                focusNode: finYearCodeFocus,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context)
                      .requestFocus(custIdFormalDigitFocus);
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                title: "Patient ID Formal Digit",
                hintText: "Enter Patient ID Formal Digit",
                controller: custIdFormalDigitController,
                prefixIcon: Icons.calendar_today,
                isValidate: true,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter Patient ID Formal Digit" : null,
                focusNode: finYearCodeFocus,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context)
                      .requestFocus(custIdFormalDigitFocus);
                },
              ),
              const SizedBox(height: 12),
               const Text("Supplier Code"),
                   const Divider(), 
                  CustomTextField(
        title: "Supplier ID Prefix",
        hintText: "Enter Supplier ID Prefix",
        prefixIcon: Icons.person_outline,
        controller: supIdPrefixController,
        focusNode: supIdPrefixFocus,
        isValidate: true,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(supIdFocus);
        },
      ),
         const SizedBox(height: 12),
      CustomTextField(
        title: "Supplier ID",
        hintText: "Enter Supplier ID",
        prefixIcon: Icons.badge,
        controller: supIdController,
        focusNode: supIdFocus,
        isValidate: true,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(supIdSuffixFocus);
        },
      ),
         const SizedBox(height: 12),
      CustomTextField(
        title: "Supplier ID Suffix",
        hintText: "Enter Supplier ID Suffix",
        prefixIcon: Icons.confirmation_num,
        controller: supIdSuffixController,
        focusNode: supIdSuffixFocus,
        isValidate: true,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(supIdFormalDigitFocus);
        },
      ),
         const SizedBox(height: 12),
      CustomTextField(
        title: "Supplier ID Formal Digit",
        hintText: "Enter Supplier ID Formal Digit",
        prefixIcon: Icons.format_list_numbered,
        controller: supIdFormalDigitController,
        focusNode: supIdFormalDigitFocus,
        isValidate: true,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(productIdPrefixFocus);
        },
      ),
         const SizedBox(height: 12),
          const Text("Product Code"),
                   const Divider(), 
      CustomTextField(
        title: "Product ID Prefix",
        hintText: "Enter Product ID Prefix",
        prefixIcon: Icons.category,
        controller: productIdPrefixController,
        focusNode: productIdPrefixFocus,
        isValidate: true,
        textInputAction: TextInputAction.done,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(productIdFocus);
        },
      ),
         const SizedBox(height: 12),
       CustomTextField(
        title: "Product ID",
        hintText: "Enter Product ID",
        prefixIcon: Icons.confirmation_num,
        controller: productIdController,
        focusNode: productIdFocus,
        isValidate: true,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(productIdFormalDigitFocus);
        },
      ),
         const SizedBox(height: 12),
      CustomTextField(
        title: "Product ID Formal Digit",
        hintText: "Enter Product ID Formal Digit",
        prefixIcon: Icons.format_list_numbered,
        controller: productIdFormalDigitController,
        focusNode: productIdFormalDigitFocus,
        isValidate: true,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(purNoPrefixFocus);
        },
      ),
         const SizedBox(height: 12),
      CustomTextField(
        title: "Purchase No Prefix",
        hintText: "Enter Purchase No Prefix",
        prefixIcon: Icons.add_box,
        controller: purNoPrefixController,
        focusNode: purNoPrefixFocus,
        isValidate: true,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(purchaseNoFocus);
        },
      ),
         const SizedBox(height: 12),
          const Text("Purchase Code"),
                   const Divider(), 
      CustomTextField(
        title: "Purchase No",
        hintText: "Enter Purchase No",
        prefixIcon: Icons.list_alt,
        controller: purchaseNoController,
        focusNode: purchaseNoFocus,
        isValidate: true,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(purNoSuffixFocus);
        },
      ),
         const SizedBox(height: 12),
      CustomTextField(
        title: "Purchase No Suffix",
        hintText: "Enter Purchase No Suffix",
        prefixIcon: Icons.confirmation_num_outlined,
        controller: purNoSuffixController,
        focusNode: purNoSuffixFocus,
        isValidate: true,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(purNoFormalDigitFocus);
        },
      ),
         const SizedBox(height: 12),
      CustomTextField(
        title: "Purchase No Formal Digit",
        hintText: "Enter Purchase No Formal Digit",
        prefixIcon: Icons.format_list_numbered_rtl,
        controller: purNoFormalDigitController,
        focusNode: purNoFormalDigitFocus,
        isValidate: true,
        textInputAction: TextInputAction.done,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(salesNoPrefixFocus);
        },
      ),
      
      const SizedBox(height: 20,),
       const Text("Sales Rate"),
                   const Divider(), 
       CustomTextField(
      title: "Sales No Prefix",
      hintText: "Enter Sales No Prefix",
      prefixIcon: Icons.sell,
      controller: salesNoPrefixController,
      focusNode: salesNoPrefixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesNoFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Sales No",
      hintText: "Enter Sales No",
      prefixIcon: Icons.confirmation_num,
      controller: salesNoController,
      focusNode: salesNoFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesNoSuffixFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Sales No Suffix",
      hintText: "Enter Sales No Suffix",
      prefixIcon: Icons.confirmation_num_outlined,
      controller: salesNoSuffixController,
      focusNode: salesNoSuffixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesNoFormalDigitFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Sales No Formal Digit",
      hintText: "Enter Sales No Formal Digit",
      prefixIcon: Icons.format_list_numbered,
      controller: salesNoFormalDigitController,
      focusNode: salesNoFormalDigitFocus,
      isValidate: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purNo2PrefixFocus);
      },
    ),
    const SizedBox(height: 20),
     const Text("Purchase 2 Code"),
                   const Divider(), 
     CustomTextField(
      title: "Purchase No 2 Prefix",
      hintText: "Enter Purchase No 2 Prefix",
      prefixIcon: Icons.add_box,
      controller: purNo2PrefixController,
      focusNode: purNo2PrefixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purchaseNo2Focus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Purchase No 2",
      hintText: "Enter Purchase No 2",
      prefixIcon: Icons.list_alt,
      controller: purchaseNo2Controller,
      focusNode: purchaseNo2Focus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purNo2SuffixFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Purchase No 2 Suffix",
      hintText: "Enter Purchase No 2 Suffix",
      prefixIcon: Icons.confirmation_num_outlined,
      controller: purNo2SuffixController,
      focusNode: purNo2SuffixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purNo2FormalDigitFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Purchase No 2 Formal Digit",
      hintText: "Enter Purchase No 2 Formal Digit",
      prefixIcon: Icons.format_list_numbered,
      controller: purNo2FormalDigitController,
      focusNode: purNo2FormalDigitFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purOrderNoPrefixFocus);
      },
    ),
    const SizedBox(height: 20),
     const Text("Purchase Order Code"),
                   const Divider(), 
    CustomTextField(
      title: "Purchase Order No Prefix",
      hintText: "Enter Purchase Order No Prefix",
      prefixIcon: Icons.add_business,
      controller: purOrderNoPrefixController,
      focusNode: purOrderNoPrefixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purchaseOderNoFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Purchase Order No",
      hintText: "Enter Purchase Order No",
      prefixIcon: Icons.list,
      controller: purchaseOderNoController,
      focusNode: purchaseOderNoFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purOrderNoSuffixFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Purchase Order No Suffix",
      hintText: "Enter Purchase Order No Suffix",
      prefixIcon: Icons.confirmation_num,
      controller: purOrderNoSuffixController,
      focusNode: purOrderNoSuffixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purOrderNoFormalDigitFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Purchase Order No Formal Digit",
      hintText: "Enter Purchase Order No Formal Digit",
      prefixIcon: Icons.format_list_numbered_rtl,
      controller: purOrderNoFormalDigitController,
      focusNode: purOrderNoFormalDigitFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purOrderNo2PrefixFocus);
      },
    ),
    const SizedBox(height: 20),
     const Text("Purchase Order 2 Code"),
                   const Divider(), 
    CustomTextField(
      title: "Purchase Order No 2 Prefix",
      hintText: "Enter Purchase Order No 2 Prefix",
      prefixIcon: Icons.add_box,
      controller: purOrderNo2PrefixController,
      focusNode: purOrderNo2PrefixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purchaseOrderNo2Focus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Purchase Order No 2",
      hintText: "Enter Purchase Order No 2",
      prefixIcon: Icons.list_alt,
      controller: purchaseOrderNo2Controller,
      focusNode: purchaseOrderNo2Focus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purOrderNo2SuffixFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Purchase Order No 2 Suffix",
      hintText: "Enter Purchase Order No 2 Suffix",
      prefixIcon: Icons.confirmation_num_outlined,
      controller: purOrderNo2SuffixController,
      focusNode: purOrderNo2SuffixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(purOrderNo2FormalDigitFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Purchase Order No 2 Formal Digit",
      hintText: "Enter Purchase Order No 2 Formal Digit",
      prefixIcon: Icons.format_list_numbered,
      controller: purOrderNo2FormalDigitController,
      focusNode: purOrderNo2FormalDigitFocus,
      isValidate: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(quoNoPrefixFocus);
      },
    ),
    const SizedBox(height: 20),
     const Text("Quotation Code"),
                   const Divider(), 
      CustomTextField(
      title: "Quotation No Prefix",
      hintText: "Enter Quotation No Prefix",
      prefixIcon: Icons.description,
      controller: quoNoPrefixController,
      focusNode: quoNoPrefixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(quotationNoFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Quotation No",
      hintText: "Enter Quotation No",
      prefixIcon: Icons.confirmation_num,
      controller: quotationNoController,
      focusNode: quotationNoFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(quoNoSuffixFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Quotation No Suffix",
      hintText: "Enter Quotation No Suffix",
      prefixIcon: Icons.confirmation_num_outlined,
      controller: quoNoSuffixController,
      focusNode: quoNoSuffixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(quoNoFormalDigitFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Quotation No Formal Digit",
      hintText: "Enter Quotation No Formal Digit",
      prefixIcon: Icons.format_list_numbered,
      controller: quoNoFormalDigitController,
      focusNode: quoNoFormalDigitFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(quoNo2PrefixFocus);
      },
    ),
    const SizedBox(height: 20),
     const Text("Quotation 2 Code"),
                   const Divider(), 
    CustomTextField(
      title: "Quotation No 2 Prefix",
      hintText: "Enter Quotation No 2 Prefix",
      prefixIcon: Icons.description_outlined,
      controller: quoNo2PrefixController,
      focusNode: quoNo2PrefixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(quotationNo2Focus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Quotation No 2",
      hintText: "Enter Quotation No 2",
      prefixIcon: Icons.confirmation_num,
      controller: quotationNo2Controller,
      focusNode: quotationNo2Focus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(quoNo2SuffixFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Quotation No 2 Suffix",
      hintText: "Enter Quotation No 2 Suffix",
      prefixIcon: Icons.confirmation_num_outlined,
      controller: quoNo2SuffixController,
      focusNode: quoNo2SuffixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(quoNo2FormalDigitFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Quotation No 2 Formal Digit",
      hintText: "Enter Quotation No 2 Formal Digit",
      prefixIcon: Icons.format_list_numbered,
      controller: quoNo2FormalDigitController,
      focusNode: quoNo2FormalDigitFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesNo2PrefixFocus);
      },
    ),
    const SizedBox(height: 20),
     const Text("Sales 2 Code"),
                   const Divider(), 
    CustomTextField(
      title: "Sales No 2 Prefix",
      hintText: "Enter Sales No 2 Prefix",
      prefixIcon: Icons.sell,
      controller: salesNo2PrefixController,
      focusNode: salesNo2PrefixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesNo2Focus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Sales No 2",
      hintText: "Enter Sales No 2",
      prefixIcon: Icons.confirmation_num,
      controller: salesNo2Controller,
      focusNode: salesNo2Focus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesNo2SuffixFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Sales No 2 Suffix",
      hintText: "Enter Sales No 2 Suffix",
      prefixIcon: Icons.confirmation_num_outlined,
      controller: salesNo2SuffixController,
      focusNode: salesNo2SuffixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesNo2FormalDigitFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Sales No 2 Formal Digit",
      hintText: "Enter Sales No 2 Formal Digit",
      prefixIcon: Icons.format_list_numbered,
      controller: salesNo2FormalDigitController,
      focusNode: salesNo2FormalDigitFocus,
      isValidate: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesOrderNoPrefixFocus);
      },
    ),
    const SizedBox(height: 20),
     const Text("Sales Order Code"),
                   const Divider(), 
        CustomTextField(
      title: "Sales Order No Prefix",
      hintText: "Enter Sales Order No Prefix",
      prefixIcon: Icons.sell,
      controller: salesOrderNoPrefixController,
      focusNode: salesOrderNoPrefixFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesOrderNoFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Sales Order No",
      hintText: "Enter Sales Order No",
      prefixIcon: Icons.confirmation_num,
      controller: salesOrderNoController,
      focusNode: salesOrderNoFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesOrderNoFormalDigitFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Sales Order No Formal Digit",
      hintText: "Enter Sales Order No Formal Digit",
      prefixIcon: Icons.format_list_numbered,
      controller: salesOrderNoFormalDigitController,
      focusNode: salesOrderNoFormalDigitFocus,
      isValidate: true,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(salesOrderNoSuffixFocus);
      },
    ),
    const SizedBox(height: 20),
    CustomTextField(
      title: "Sales Order No Suffix",
      hintText: "Enter Sales Order No Suffix",
      prefixIcon: Icons.confirmation_num_outlined,
      controller: salesOrderNoSuffixController,
      focusNode: salesOrderNoSuffixFocus,
      isValidate: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
    ),
    const SizedBox(height: 20),
      //                CustomSwitch(
      //               value: _activeStatus,
      //               title: "Active Status",
      //               onChanged: (val) {
      //                 setState(() {
      //                   _activeStatus = val;
      //                 });
      //               },
      //             ),
      //             const SizedBox(height: 20,),
      //             SearchDropdownField<Info>(
      //               controller: _unitNameController,
      //               hintText: "Area Name",
      //               prefixIcon: Icons.search,
      //               fetchItems: (q) async {
      //                 final response = await _service.getAreaMasterSearch(q);
      //                 if (response.isSuccess) {
      //                   return (response.data?.info ?? []).whereType<Info>().toList();
      //                 }
      //                 return [];
      //               },
      //               displayString: (unit) => unit.areaName ?? "",
      //               onSelected: (country) {
      //                   if (country != null) {
      //      setState(() {
      //                   _unitIdController.text = country.areaCode.toString() ?? "";
      //                   _unitNameController.text = country.areaName ?? "";
      //                   // _createdUserController.text =
      //                   //     country.createdUserCode?.toString() ?? userId.value!;
      //                   _activeStatus = (country.activeStatus ?? 1) == 1;
      //                   _isEditMode = true;
      //                 });
      
      //                 // ✅ Switch form into "Update mode"
      //                 widget.onSaved(false);
      //     }
                  
      //               },
      //                onSubmitted: (typedValue) {
      //     // ✅ User pressed enter or confirmed text without selecting
      //     setState(() {
      //       _unitIdController.clear(); // no id since not from API
      //       _unitNameController.text = typedValue; 
      //       print("_countryNameController.text");// use typed text
      //       print(_unitNameController.text);// use typed text
      //       _createdUserController.text = userId.value!;
      //       _activeStatus = true;
      //             _isEditMode = false;
      //     });
      //     widget.onSaved(false);
      //   },
      //             ),
      
      //             const SizedBox(height: 26),
      //             // SwitchListTile(
      //             //   value: _activeStatus,
      //             //   title: const Text("Active Status"),
      //             //   onChanged: (val) => setState(() => _activeStatus = val),
      //             // ),
           
      //             CustomTextField(
      //               title: "Area Code",
      //               hintText: "Enter Area Code",
      //               controller: _unitIdController,
      //               prefixIcon: Icons.flag_circle,
      //               isValidate: true,
      //               validator: (value) =>
      //                   value == null || value.isEmpty ? "Enter Area Code" : null,
      //               focusNode: _unitIdFocus,
      //               textInputAction: TextInputAction.next,
      //               onEditingComplete: () {
      //                 FocusScope.of(context).requestFocus(_unitNameFocus);
      //               },
      //             ),
      //             const SizedBox(height: 16),
      //             // CustomTextField(
      //             //   title: "Area Name",
      //             //   hintText: "Enter Area Name",
      //             //   controller: _unitNameController,
      //             //   prefixIcon: Icons.flag,
      //             //   isValidate: true,
      //             //   validator: (value) =>
      //             //       value == null || value.isEmpty ? "Enter Area name" : null,
      //             //   focusNode: _unitNameFocus,
      //             //   textInputAction: TextInputAction.next,
      //             //   onEditingComplete: () {
      //             //     // FocusScope.of(context).requestFocus(_createdUserFocus);
      //             //   },
      //             // ),
      //             // const SizedBox(height: 16),
             
      //             CustomDropdownField<int>(
      //               title: "Select State",
      //               hintText: "Choose State",
      //               items: getAllMasterListModel!.info!.states!
      //                   .map((e) => DropdownMenuItem<int>(
      //                         value: e.stateCode, // 🔹 use taxCode as value
      //                         child: Text("${e.stateName} "),
      //                       ))
      //                   .toList(),
      //               // initialValue: _taxCode, // int? taxCode
      //               onChanged: (value) {
      //                 setState(() {
      //                   _stateCode = value;
      //                   //  _taxCode = value;
      //                 });
      
      //                 final selected = getAllMasterListModel!.info!.states!
      //                     .firstWhere((c) => c.stateCode == value,
      //                         orElse: () => master.States());
      // stateCode=selected.stateCode;
      //                 print("Selected GST %: ${selected.stateCode}");
      //                 print("Selected TAX Code: ${selected.stateCode}");
      //               },
      //               isValidate: true,
      //               validator: (value) =>
      //                   value == null ? "Please select State" : null,
      //               addPage: AddStateMasterPage(
      //                 onSaved: (success) {
      //                   if (success) {
      //                     Navigator.pop(context, true);
      //                   }
      //                 },
      //               ),
      //               addTooltip: "Add State",
      //             ),
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
                    text: _isEditMode ? "Update Area" : "Add Number initialize",
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
      ),
    );
  }
}
