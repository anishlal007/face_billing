import 'dart:io';

import 'package:facebilling/core/const.dart';
import 'package:facebilling/ui/screens/masters/generics_master/add_generics_master_page.dart';
import 'package:facebilling/ui/screens/masters/hns_master/add_hns_master_page.dart';
import 'package:facebilling/ui/screens/masters/item_group/AddGroupScreen.dart';
import 'package:facebilling/ui/screens/masters/item_make_master/add_item_make_master.dart';
import 'package:facebilling/ui/screens/masters/tax_master/add_tax_master_page.dart';
import 'package:facebilling/ui/screens/masters/unit/AddUnitScreen.dart';
import 'package:facebilling/ui/screens/masters/user_master/add_user_master_page.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/get_all_master_list_model.dart' as master;
//import '../../../../data/models/tax_master/tax_master_list_model.dart'  as tax;
import '../../../../data/models/get_serial_no_model.dart'as serialno;
import '../../../../data/models/product/add_product_request.dart';
import '../../../../data/models/product/product_master_list_model.dart';
import '../../../../data/services/get_all_master_service.dart';
import '../../../../data/services/get_serial_no_services.dart';
import '../../../../data/services/product_service.dart';
import '../../../../data/services/tax_master_service.dart'
    show TaxMasterService;
import '../../../widgets/custom_checkbox.dart';
import '../../../widgets/custom_dropdown_text_field.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/image_pickerField.dart';
import '../../../widgets/search_dropdown.dart';
import '../../../widgets/search_dropdown_field.dart';


class AddProductMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddProductMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddProductMasterPage> createState() => _AddProductMasterPageState();
}

class _AddProductMasterPageState extends State<AddProductMasterPage> {
  final _formKey = GlobalKey<FormState>(); 
 


  ///services
  final ProductService _service = ProductService();
  final GetAllMasterService _getAllMasterService = GetAllMasterService();
    final GetSerialNoServices _getSerialservice = GetSerialNoServices();
    
  int? _hsntaxCode, _gsttaxCode, _itemGroup, _itemUnit, _itemMake, _itemGeneric, _unitCode;
  bool _activeStatus = true;
  bool _itemIdType = true;        
bool _isItemIdEditable = false;  

  bool _ismfgreatured = true;
  bool _loading = false;
  bool _nonScheduledItem = true,
      _scheduledItem = true,
      _expiryRequired = true,
      _isNarocotic = false,
      _isBatchNumbeRequired = true,
      _isDiscountReq = false;
  String? _message;
  bool _getAllLoading = true;
  File? _image;
  int? selectedPaymentType  = 0;
  int? priceTakenFrom = 0;
  int? selectedExpiryType;
  String? error;

  master.ItemGroups? _selectedItemGroup;
  master.ItemMakes? _selectItemMake;
   master.HsnMasters? _selectHSN;
   master.TaxMasters? _selectgst;
String? groumName ;

  ///model
serialno.GetSerialNoModel?serialNo;
  master.GetAllMasterListModel? getAllMasterListModel;
  late TextEditingController _itemIdController;
  late TextEditingController _itemNameController;
  final TextEditingController productTypeController = TextEditingController();
  final TextEditingController itemgroupController = TextEditingController();
  final TextEditingController pricetakenfromController = TextEditingController();

  late TextEditingController _itemTypeController;
  late TextEditingController _itemGroupCodeController;
  late TextEditingController _itemUnitCodeController;
  late TextEditingController _itemMakeCodeController;
  late TextEditingController _itemGenericCodeController;
  late TextEditingController _nonScheduleItemController;
  late TextEditingController _scheduledH1ItemController;
  late TextEditingController _narcoticItemController;
  late TextEditingController _expiryDateFormatController;
  late TextEditingController _expiryDateRequiredController;
  late TextEditingController _subUnitCodeController;
  late TextEditingController _subQtyController;
  late TextEditingController _subUnitsController;
  late TextEditingController _subQtyFormatController;
  
  late TextEditingController _formaldigitController;
  late TextEditingController _batchNoRequiredController;
  late TextEditingController _minimumStockQtyController;
  late TextEditingController _maximumStockQtyController;
  late TextEditingController _reOrderLevelController;
  late TextEditingController _reOrderQtyController;
  late TextEditingController _priceTakenFromController;
  late TextEditingController _itemDiscountPercentageController;
  late TextEditingController _itemDiscountRequiredController;
  late TextEditingController _itemDiscountValueController;
  late TextEditingController _purchaseRateWTaxController;
  late TextEditingController _purchaseRateController;
  late TextEditingController _salesRateController;
  late TextEditingController _mRPRateController;
  late TextEditingController _gstPercentageController;
  late TextEditingController _createdUserController;

  // 🔹 FocusNodes
  final FocusNode _itemIdFocus = FocusNode();
  final FocusNode _itemNameFocus = FocusNode();
  final FocusNode _itemTypeFocus = FocusNode();
  final FocusNode _itemGroupFocus = FocusNode();
  final FocusNode _itemGroupCodeFocus = FocusNode();
  final FocusNode _itemUnitCodeFocus = FocusNode();
  final FocusNode _itemMakeCodeFocus = FocusNode();
  final FocusNode _itemGenericCodeFocus = FocusNode();
  final FocusNode _nonScheduleItemFocus = FocusNode();
  final FocusNode _scheduledH1ItemFocus = FocusNode();
  final FocusNode _narcoticItemFocus = FocusNode();
  final FocusNode _expiryDateFormatFocus = FocusNode();
  final FocusNode _expiryDateRequiredFocus = FocusNode();
  final FocusNode _subUnitCodeFocus = FocusNode();
  final FocusNode _subQtyFocus = FocusNode();
  final FocusNode _subUnitsFocus = FocusNode();
  final FocusNode _subQtyFormat = FocusNode();
  final FocusNode _batchNoRequiredFocus = FocusNode();
  final FocusNode _minimumStockQtyFocus = FocusNode();
  final FocusNode _maximumStockQtyFocus = FocusNode();
  final FocusNode _reOrderLevelFocus = FocusNode();
  final FocusNode _reOrderQtyFocus = FocusNode();
  final FocusNode _priceTakenFromFocus = FocusNode();
  final FocusNode _itemDiscountPercentageFocus = FocusNode();
  final FocusNode _itemDiscountRequiredFocus = FocusNode();
  final FocusNode _itemDiscountValueFocus = FocusNode();
  final FocusNode _purchaseRateWTaxFocus = FocusNode();
  final FocusNode _purchaseRateFocus = FocusNode();
  final FocusNode _salesRateFocus = FocusNode();
  final FocusNode _mRPRateFocus = FocusNode();
  final FocusNode _gstPercentageFocus = FocusNode();
  final FocusNode _createUserFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_itemNameFocus);
    });
    _loadList();
    _itemIdController =
        TextEditingController(text: widget.unitInfo?.itemID ?? "");
    _itemNameController =
        TextEditingController(text: widget.unitInfo?.itemName ?? "");
    _itemTypeController = TextEditingController(
        text: widget.unitInfo?.itemType?.toString() ?? "");
    _itemGroupCodeController = TextEditingController(
        text: widget.unitInfo?.itemGroupCode?.toString() ?? "");
    _itemUnitCodeController = TextEditingController(
        text: widget.unitInfo?.itemUnitCode?.toString() ?? "");
    _itemMakeCodeController = TextEditingController(
        text: widget.unitInfo?.itemMakeCode?.toString() ?? "");
    _itemGenericCodeController = TextEditingController(
        text: widget.unitInfo?.itemGenericCode?.toString() ?? "");
    _nonScheduleItemController = TextEditingController(
        text: widget.unitInfo?.nonScheduleItem?.toString() ?? "");
    _scheduledH1ItemController = TextEditingController(
        text: widget.unitInfo?.scheduledH1Item?.toString() ?? "");
    _narcoticItemController = TextEditingController(
        text: widget.unitInfo?.narcoticItem?.toString() ?? "");
    _expiryDateFormatController =
        TextEditingController(text: widget.unitInfo?.expiryDateFormat ?? "");
    _expiryDateRequiredController =
        TextEditingController(text: widget.unitInfo?.expiryDateRequired ?? "");
    _subUnitCodeController = TextEditingController(
        text: widget.unitInfo?.subUnitCode?.toString() ?? "");
        _formaldigitController = TextEditingController();
    _subQtyFormatController = TextEditingController(
        text: widget.unitInfo?.subQtyFormalDigits?.toString() ?? "");
    _subQtyController =
        TextEditingController(text: widget.unitInfo?.subQty?.toString() ?? "");
    _subUnitsController = TextEditingController(
        text: widget.unitInfo?.subQtyFormalDigits?.toString() ?? "");
    _batchNoRequiredController = TextEditingController(
        text: widget.unitInfo?.batchNoRequired?.toString() ?? "");
    _minimumStockQtyController = TextEditingController(
        text: widget.unitInfo?.minimumStockQty?.toString() ?? "");
    _maximumStockQtyController = TextEditingController(
        text: widget.unitInfo?.maximumStockQty?.toString() ?? "");
    _reOrderLevelController = TextEditingController(
        text: widget.unitInfo?.reOrderLevel?.toString() ?? "");
    _reOrderQtyController = TextEditingController(
        text: widget.unitInfo?.reOrderQty?.toString() ?? "");
    _priceTakenFromController = TextEditingController(
        text: widget.unitInfo?.priceTakenFrom?.toString() ?? "");
    _itemDiscountPercentageController = TextEditingController(
        text: widget.unitInfo?.itemDiscountPercentage?.toString() ?? "");
    _itemDiscountRequiredController = TextEditingController(
        text: widget.unitInfo?.itemDiscountRequired?.toString() ?? "");
    _itemDiscountValueController = TextEditingController(
        text: widget.unitInfo?.itemDiscountValue?.toString() ?? "");
    _purchaseRateWTaxController = TextEditingController(
        text: widget.unitInfo?.purchaseRateWTax?.toString() ?? "");
    _purchaseRateController = TextEditingController(
        text: widget.unitInfo?.purchaseRate?.toString() ?? "");
    _salesRateController = TextEditingController(
        text: widget.unitInfo?.salesRate?.toString() ?? "");
    _mRPRateController =
        TextEditingController(text: widget.unitInfo?.mRPRate?.toString() ?? "");
    _gstPercentageController = TextEditingController(
        text: widget.unitInfo?.gstPercentage?.toString() ?? "");
    _createdUserController = TextEditingController(text: userId.value!);

    _activeStatus = (widget.unitInfo?.createdUserCode ?? 1) == 1;
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

  final serialNoResponse = await _getSerialservice.getSerialNo();
  if (serialNoResponse.isSuccess) {
    setState(() {
      serialNo = serialNoResponse.data!;
      _itemIdController.text = serialNo!.info!.productNextId!;
      _getAllLoading = false;
      error = null;
    });
  } else {
    setState(() {
      error = serialNoResponse.error;
      _getAllLoading = false;
    });
  }
}


  @override
  void dispose() {
    _itemIdController.dispose();
    _itemNameController.dispose();
    _itemTypeController.dispose();
    _itemGroupCodeController.dispose();
    _itemUnitCodeController.dispose();
    _itemMakeCodeController.dispose();
    _itemGenericCodeController.dispose();
    _nonScheduleItemController.dispose();
    _scheduledH1ItemController.dispose();
    _narcoticItemController.dispose();
    _expiryDateFormatController.dispose();
    _expiryDateRequiredController.dispose();
    _subUnitCodeController.dispose();
    _subQtyController.dispose();
    // _subQtyController.dispose();
    _subQtyFormatController.dispose();
    _batchNoRequiredController.dispose();
    _minimumStockQtyController.dispose();
    _maximumStockQtyController.dispose();
    _reOrderLevelController.dispose();
    _reOrderQtyController.dispose();
    _priceTakenFromController.dispose();
    _itemDiscountPercentageController.dispose();
    _itemDiscountRequiredController.dispose();
    _itemDiscountValueController.dispose();
    _purchaseRateWTaxController.dispose();
    _purchaseRateController.dispose();
    _salesRateController.dispose();
    _mRPRateController.dispose();
    _gstPercentageController.dispose();
    _createdUserController.dispose();

    _itemIdFocus.dispose();
    _createUserFocus.dispose();
    _itemNameFocus.dispose();
    _itemTypeFocus.dispose();
    _itemGroupCodeFocus.dispose();
    _itemUnitCodeFocus.dispose();
    _itemMakeCodeFocus.dispose();
    _itemGenericCodeFocus.dispose();
    _nonScheduleItemFocus.dispose();
    _scheduledH1ItemFocus.dispose();
    _narcoticItemFocus.dispose();
    _expiryDateFormatFocus.dispose();
    _expiryDateRequiredFocus.dispose();
    _subUnitCodeFocus.dispose();
    _subQtyFocus.dispose();
    _subUnitsFocus.dispose();
    _subQtyFormat.dispose();
    _batchNoRequiredFocus.dispose();
    _minimumStockQtyFocus.dispose();
    _maximumStockQtyFocus.dispose();
    _reOrderLevelFocus.dispose();
    _reOrderQtyFocus.dispose();
    _priceTakenFromFocus.dispose();
    _itemDiscountPercentageFocus.dispose();
    _itemDiscountRequiredFocus.dispose();
    _itemDiscountValueFocus.dispose();
    _purchaseRateWTaxFocus.dispose();
    _purchaseRateFocus.dispose();
    _salesRateFocus.dispose();
    _mRPRateFocus.dispose();
    _gstPercentageFocus.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() {
    _loading = true;
    _message = null;
  });

  try {
    if (widget.unitInfo == null) {
      // ADD mode
      final request = AddProductMasterModel(
        idtype:_itemIdController.text, 
        itemID: _itemIdController.text.trim(),
        itemName: _itemNameController.text.trim(),
        itemType: selectedPaymentType,
        itemGroupCode: _itemGroup,
        itemUnitCode: _unitCode,
        itemMakeCode: _itemMake,
        itemGenericCode: "1", //int.tryParse(_itemGenericCodeController.text.trim()),
        nonScheduleItem: _nonScheduledItem ? 0 : 1,
        scheduledH1Item: _nonScheduledItem ? 1 : 0,
        narcoticItem: _isNarocotic ? 1 : 0,
        expiryDateRequired: _expiryRequired ? "1" : "0",
        expiryDateFormat:selectedExpiryType.toString(),
        subUnitCode: _unitCode,
        subQty: int.tryParse(_subQtyController.text.trim()),
        batchNoRequired: _isBatchNumbeRequired ? 1 : 0,
        minimumStockQty: "10",//int.tryParse(_minimumStockQtyController.text.trim()),
        maximumStockQty: "10",//int.tryParse(_maximumStockQtyController.text.trim()),
        reOrderLevel:"100", //int.tryParse(_reOrderLevelController.text.trim()),
        reOrderQty: "100",//int.tryParse(_reOrderQtyController.text.trim()),
        priceTakenFrom: priceTakenFrom,
        itemDiscountRequired: _isDiscountReq ? 1 : 0,
        itemDiscountPercentage: _isDiscountReq
            ? double.tryParse(_itemDiscountValueController.text.trim())
            : 0.0,
        itemDiscountValue: _isDiscountReq
            ? double.tryParse(_itemDiscountValueController.text.trim())
            : 0.0,
        purchaseRate: int.tryParse(_purchaseRateController.text.trim()),
        purchaseRateWTax:
            double.tryParse(_purchaseRateWTaxController.text.trim()),
        salesRate: int.tryParse(_salesRateController.text.trim()),
        mRPRate: int.tryParse(_mRPRateController.text.trim()),
        gstPercentage: _gsttaxCode,
        createdDate: DateTime.now().toIso8601String(),
        createdUserCode: 1,
        updatedUserCode: 1,
      );

      print("🟢 Request JSON: ${request.toJson()}");

      final response = await _service.addProductService(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
      final updated = AddProductMasterModel(
        itemName: _itemNameController.text.trim(),
      );

      print("🟡 Updated Request JSON: ${updated.toJson()}");

      final response = await _service.updateProductService(
        widget.unitInfo!.itemCode!,
        updated,
      );
      _handleResponse(response.isSuccess, response.error);
    }
  } catch (e) {
    setState(() {
      _loading = false;
      _message = "Error: $e";
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

  @override
  void didUpdateWidget(covariant AddProductMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      _itemIdController.text = widget.unitInfo?.itemCode.toString() ?? "";
      _itemNameController.text = widget.unitInfo?.itemName ?? "";
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? userId.value!;
      // _activeStatus = (widget.unitInfo?.custActiveStatus ?? 1) == 1;
    }
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
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
                columns = 5;
              } else if (constraints.maxWidth > 800) {
                columns = 4;
              }

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  // Example fields (replace with all your CustomTextField/Dropdown etc.)
                  // SearchDropdownField<Info>(
                  //   hintText: "Search Product",
                  //   // prefixIcon: Icons.search,
                  //   fetchItems: (q) async {
                  //     final response =
                  //         await _service.getProductServiceSearch(q);
                  //     if (response.isSuccess) {
                  //       return (response.data?.info ?? [])
                  //           .whereType<Info>()
                  //           .toList();
                  //     }
                  //     return [];
                  //   },
                  //   displayString: (unit) => unit.itemName ?? "",
                  //   onSelected: (country) {
                  //     setState(() {
                  //       _itemIdController.text =
                  //           country.itemCode.toString() ?? "";
                  //       _itemNameController.text = country.itemName ?? "";
                  //       // _createdUserController.text =
                  //       //     country.createdUserCode?.toString() ?? userId.value!;
                  //       // _activeStatus = (country.custActiveStatus ?? 1) == 1;
                  //     });

                  //     // ✅ Switch form into "Update mode"
                  //     widget.onSaved(false);
                  //   },
                  // ),
                  SizedBox(
                    width: constraints.maxWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Product Status"),
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
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
  width: constraints.maxWidth / columns - 90,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Item ID",
        style: TextStyle(fontSize: 12.0, height: 1.0, color: Colors.black),
      ),
      const SizedBox(height: 4),

      // 🔹 Auto / Manual Switch
            CustomSwitch(
              value: _itemIdType,
              title: "Auto",
              onText: "Auto",
              offText: "Manual",
              activecolor: Colors.black,
              inactiveColor: Colors.blue,
              onChanged: (val) async {
                setState(() {
                  _itemIdType = val;
                });

                if (val) {
                  // 🔸 Switch ON → Auto mode
                  await _loadList(); // fetch from API
                  setState(() {
                    _isItemIdEditable = false; // disable manual edit
                  });
                } else {
                  // 🔸 Switch OFF → Manual mode
                  setState(() {
                    _itemIdController.clear(); // clear text field
                    _isItemIdEditable = true;  // allow manual input
                  });
                }
              },
                    ),
            ],
          ),
        ),
                  SizedBox(
                  width: constraints.maxWidth / columns - 20,
                  child: CustomTextField(
                    title: "Item ID",
                    hintText: "Enter Item ID",
                    isEdit: _isItemIdEditable ?false : true, // disable when auto
                    controller: _itemIdController,
                    isValidate: true,
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter Item Code"
                        : null,
                    focusNode: _itemIdFocus,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                 
                  SizedBox(
                      width: constraints.maxWidth / columns - 30,
                      child: SearchDropdownField<Info>(
                      hintText: "Item Name",
                      prefixIcon: Icons.search,
                      fetchItems: (q) async {
                        final response = await _service.getProductServiceSearch(q);
                        if (response.isSuccess) {
                          return (response.data?.info ?? []).whereType<Info>().toList();
                        }
                        return [];
                      },
                      displayString: (item) => item.itemName ?? "",
                      onSelected: (product) {
                        setState(() {
                          _itemIdController.text = product.itemCode.toString();
                          _itemNameController.text = product.itemName ?? "";
                          _createdUserController.text =
                              product.createdUserCode?.toString() ?? userId.value!;
                          selectedPaymentType = int.tryParse(product.itemType ?? '') ?? 0;
                          priceTakenFrom = int.tryParse(product.priceTakenFrom ?? '') ?? 0;
                          
                          print(product.itemGroupCode);
                          final int itemGroupCode =   int.tryParse(product.itemGroupCode ?? '') ?? 0; // Use a local variable
                          print('Item Group Code from Product: $itemGroupCode (Raw: ${product.itemGroupCode})');
                          _itemGroup = itemGroupCode;
                          _selectedItemGroup = getAllMasterListModel?.info?.itemGroups?.firstWhere(
                                (g) => g.itemGroupCode == itemGroupCode,
                                orElse: () => master.ItemGroups(itemGroupCode: itemGroupCode, itemGroupName: 'Unknown Group'), 
                              ); 

                          final int itemMakeCode = int.tryParse(product.itemMakeCode ?? '') ?? 0; 
                          _itemMake = itemMakeCode;
                          _selectItemMake = getAllMasterListModel?.info?.itemMakes?.firstWhere(
                                (g) => g.itemMakeCode == itemMakeCode,
                                orElse: () => master.ItemMakes(itemMakeCode: itemMakeCode, itemMaketName: 'Unknown Group'),
                              );

                          final int itemHSNCode = int.tryParse(product.hSNCode ?? '') ?? 0; 
                          _hsntaxCode = itemHSNCode;
                          _selectHSN = getAllMasterListModel?.info?.hsnMasters?.firstWhere(
                                (g) => g.hsnCode == itemHSNCode,
                                orElse: () => master.HsnMasters(hsnCode: itemHSNCode, hsnName: 'Unknown Group'),
                              );

                             
                          
                        });
                        widget.onSaved(false);
                      },  
                      onSubmitted: (typedValue) {
                        // ✅ Manual entry (not in list)
                        setState(()  {
                          if(_activeStatus){
                              _loadList();
                          }else{ 
                          }
                          
                          _itemNameController.text = typedValue;
                          _createdUserController.text = userId.value!;
                          _activeStatus = true;
                        });
                        widget.onSaved(false);
                        print(_itemNameController.text);
                      },
                    ),

                    ),


                  SizedBox(
                    width: constraints.maxWidth / columns - 30,
                    child: CustomDropdownField<int>(
                    title: "Product Type",
                    hintText: "Select Product Type",
                    items: const [
                      DropdownMenuItem(value: 0, child: Text("Pharma")),
                      DropdownMenuItem(value: 1, child: Text("Optical")),
                      DropdownMenuItem(value: 2, child: Text("Service")),
                    ],
                    controller: productTypeController,
                    initialValue: selectedPaymentType,
                    onChanged: (val) {
                      setState(() => selectedPaymentType = val ?? 0);
                    },
                    focusNode: _itemTypeFocus,
                      onEditingComplete: () {
                        _fieldFocusChange(context, _itemTypeFocus, _itemGroupFocus);
                      },
                  ),

                  //   CustomDropdownField<int>(
                  //     key: _productTypeKey, // ✅ add key for direct state update
                  //     title: "Product Type",
                  //     hintText: "Select Product Type",
                  //     items: const [
                  //       DropdownMenuItem(value: 0, child: Text("Pharma")),
                  //       DropdownMenuItem(value: 1, child: Text("Optical")),
                  //       DropdownMenuItem(value: 2, child: Text("Service")),
                  //     ],
                  //     initialValue: selectedPaymentType,
                  //     onChanged: (val) {
                  //       setState(() => selectedPaymentType = val ?? 0);
                  //       print("Selected Product Type: $val");
                  //     },
                  //     focusNode: _itemTypeFocus,
                  //     onEditingComplete: () {
                  //       _fieldFocusChange(context, _itemTypeFocus, _itemGroupFocus);
                  //     },
                  //   ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: SearchableDropdown<master.ItemGroups>(
                        
                      hintText: "Item Group",
                      items: getAllMasterListModel!.info!.itemGroups!,
                      initialValue: _selectedItemGroup, 
                      itemLabel: (group) => group.itemGroupName ?? "",
                      onChanged: (group) {
                        setState(() {
                         _itemGroup = group.itemGroupCode; 
                           _selectedItemGroup = group;
                        });
                       
                      },
                      
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _itemGroupFocus,
                        _itemUnitCodeFocus,
                      ),
                      
                      // Add page popup
                      addPage: Addgroupscreen(
                        onSaved: (success) {
                          if (success) {
                            Navigator.pop(context, true);
                          }
                        },
                      ),
                      addTooltip: "Add Item Group",
                    ),
                    
                  ),
                  // SizedBox(
                  //   width: constraints.maxWidth / columns - 20,
                  //   child:
                  //   CustomDropdownField<int>(
                  //     title: "Select Item Group",
                  //     hintText: "Choose Item Group",
                  //     items: getAllMasterListModel!.info!.itemGroups!
                  //         .map((e) => DropdownMenuItem<int>(
                  //               value:
                  //                   e.itemGroupCode, // 🔹 use taxCode as value
                  //               child: Text("${e.itemGroupName} "),
                  //             ))
                  //         .toList(),
                  //     // initialValue: _taxCode, // int? taxCode
                  //     onChanged: (value) {
                  //       setState(() {
                  //         _itemGroup = value;
                  //         //  _taxCode = value;
                  //       });

                  //       final selected = getAllMasterListModel!
                  //           .info!.itemGroups!
                  //           .firstWhere((c) => c.itemGroupCode == value,
                  //               orElse: () => master.ItemGroups());
                  //     },
                  //     isValidate: true,
                  //     validator: (value) =>
                  //         value == null ? "Please select Item Group" : null,
                  //     focusNode: _itemGroupFocus,
                  // onEditingComplete: () => _fieldFocusChange(
                  //   context,
                  //   _itemGroupFocus,
                  //   _itemUnitCodeFocus,
                  // ),
                  //     addPage: Addgroupscreen(
                  //       onSaved: (success) {
                  //         if (success) {
                  //           Navigator.pop(context, true);
                  //         }
                  //       },
                  //     ),
                  //     addTooltip: "Add Item Group",
                  //   ),
                  // ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: SearchableDropdown<master.ItemMakes>(
                      hintText: "Item Make",
                      initialValue: _selectItemMake,
                      items: getAllMasterListModel!.info!.itemMakes!,
                      itemLabel: (group) => group.itemMaketName ?? "",
                      onChanged: (group) {
                        if (group != null) {
                          _itemMake = group.itemMakeCode;
                          _selectItemMake = group;
                          print("Selected Code: ${group.itemMakeCode}");
                          print("Selected Name: ${group.itemMaketName}");
                        }
                      },
                      focusNode: _itemMakeCodeFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _itemMakeCodeFocus,
                        _itemGenericCodeFocus,
                      ),
                      // Add page popup
                      addPage: AddItemMakeMaster(
                        onSaved: (success) {
                          if (success) {
                            Navigator.pop(context, true);
                          }
                        },
                      ),
                      addTooltip: "Add Item Make",
                    ),
                  ),

                  selectedPaymentType == 0
                      ? SizedBox(
                          width: constraints.maxWidth / columns - 20,
                          child: CustomDropdownField<int>(
                            title: "Select Item Generic",
                            hintText: "Choose  IItem Generic",
                            items: getAllMasterListModel!.info!.generics!
                                .map((e) => DropdownMenuItem<int>(
                                      value: e
                                          .genericCode, // 🔹 use taxCode as value
                                      child: Text("${e.genericName} "),
                                    ))
                                .toList(),
                            // initialValue: _taxCode, // int? taxCode
                            onChanged: (value) {
                              setState(() {
                                _itemGeneric = value;
                                //  _taxCode = value;
                              });

                              final selected = getAllMasterListModel!
                                  .info!.generics!
                                  .firstWhere((c) => c.genericCode == value,
                                      orElse: () => master.Generics());

                              print("Selected GST %: ${selected.genericCode}");
                              print(
                                  "Selected TAX Code: ${selected.genericName}");
                            },
                            // isValidate: true,
                            // validator: (value) => value == null
                            //     ? "Please select Item Make Code"
                            //     : null,
                            focusNode: _itemGenericCodeFocus,
                            onEditingComplete: () => _fieldFocusChange(
                              context,
                              _itemGenericCodeFocus,
                              _nonScheduleItemFocus,
                            ),
                            addPage: AddGenericsMasterPage(
                              onSaved: (success) {
                                if (success) {
                                  Navigator.pop(context, true);
                                }
                              },
                            ),
                            addTooltip: "Add Item Generic",
                          ),
                        )
                      : SizedBox(),

                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: SearchableDropdown<master.Units>(
                      hintText: "Select unit",
                      items: getAllMasterListModel!.info!.units!,
                      itemLabel: (group) => group.unitName ?? "",
                      onChanged: (group) {
                        if (group != null) {
                          _unitCode = group.unitCode;
                          print("Selected Code: ${group.unitCode}");
                          print("Selected Name: ${group.unitName}");
                        }
                      },
                      focusNode: _itemUnitCodeFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _itemUnitCodeFocus,
                        _itemMakeCodeFocus,
                      ),
                      addPage: Addunitscreen(
                        onSaved: (success) {
                          if (success) {
                            _loadList();
                            Navigator.pop(context, true);
                          }
                        },
                      ),
                      addTooltip: "Add Unit",
                    ),
                  ),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Conversion Quantity",
                      hintText: "Enter Conversion Quantity",
                      controller: _subQtyController,
                      // isNumeric: true,
                      // isValidate: true,
                      // validator: (value) => value == null || value.isEmpty
                      //     ? "Enter Conversion Quantity"
                      //     : null,
                           onChanged: (value) {
      // ✅ Automatically update formal digit based on conversion value
      if (value.isEmpty) return;

      final double? conversion = double.tryParse(value);
      if (conversion == null) return;

      int formalDigit = 1;

      if (conversion >= 1 && conversion <= 9) {
        formalDigit = 0;
      } else if (conversion >= 10 && conversion <= 99) {
        formalDigit = 1;
      } else if (conversion >= 100 && conversion <= 999) {
        formalDigit = 2;
      } else {
        formalDigit = 4; // default fallback
      }

      setState(() {
        _formaldigitController.text = formalDigit.toString();
      });
    },
                      focusNode: _subQtyFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_subQtyFocus);
                      },
                    ),
                  ),
                  SizedBox(
  width: constraints.maxWidth / columns - 20,
  child: CustomTextField(
    title: "Digital of Formal",
    hintText: "Format Digit",
    controller: _formaldigitController,
    isValidate: true,
    validator: (value) =>
        value == null || value.isEmpty ? "Format Qty" : null,
    focusNode: _subQtyFormat,
    textInputAction: TextInputAction.next,
    onEditingComplete: () {
      FocusScope.of(context).requestFocus(_subQtyFormat);
    },
  ),
),

                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: SearchableDropdown<master.Units>(
                      hintText: "Sub unit",
                      items: getAllMasterListModel!.info!.units!,
                      itemLabel: (group) => group.unitId ?? "",
                      onChanged: (group) {
                        if (group != null) {
                          _unitCode = group.unitCode; 
                        }
                      },
                      focusNode: _itemUnitCodeFocus,
                      onEditingComplete: () => _fieldFocusChange(
                        context,
                        _itemUnitCodeFocus,
                        _itemMakeCodeFocus,
                      ),
                      addPage: Addunitscreen(
                        onSaved: (success) {
                          if (success) {
                            _loadList();
                            Navigator.pop(context, true);
                          }
                        },
                      ),
                      addTooltip: "Add Unit",
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),

                  SizedBox(
                    width: constraints.maxWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        selectedPaymentType == 0
                            ? Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomCheckbox(
                                      label: "Is Batch Number Required",
                                      value: _isBatchNumbeRequired,
                                      onChanged: (val) {
                                        setState(() {
                                          _isBatchNumbeRequired = val ?? false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCheckbox(
                                label: "Is  Narcotic Item",
                                value: _isNarocotic,
                                onChanged: (val) {
                                  setState(() {
                                    _isNarocotic = val ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCheckbox(
                                label: "Scheduled Item",
                                value: _nonScheduledItem,
                                onChanged: (val) {
                                  setState(() {
                                    _nonScheduledItem = val ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCheckbox(
                                label: "Expiry Required",
                                value: _expiryRequired,
                                onChanged: (val) {
                                  setState(() {
                                    _expiryRequired = val ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCheckbox(
                                label: "MFGDateRequired",
                                value: _ismfgreatured,
                                onChanged: (val) {
                                  setState(() {
                                    _ismfgreatured = val ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _expiryRequired
                      ? SizedBox(
                          width: constraints.maxWidth / columns - 30,
                          child: CustomDropdownField<int>(
                            title: "Expiry Date Format",
                            hintText: "Expiry Date Format",
                            items: const [
                              DropdownMenuItem(value: 0, child: Text("DD/YY")),
                              DropdownMenuItem(
                                  value: 1, child: Text("DD/MM/YY")),
                              DropdownMenuItem(
                                  value: 2, child: Text("DD/MM/YYYY")),
                            ],
                            initialValue: selectedExpiryType,
                            onChanged: (val) {
                              setState(() => selectedExpiryType = val);
                              print("Selected PaymentType: $val");
                            },
                            focusNode: _itemTypeFocus,
                            onEditingComplete: () {
                              _fieldFocusChange(
                                  context, _itemTypeFocus, _itemGroupFocus);
                            },
                          ),
                        )
                      : SizedBox(
                          width: 0,
                        ),

                  // SizedBox(
                  //   width: constraints.maxWidth / columns - 20,
                  //   child: CustomTextField(
                  //     title: "Minimum Stock Quantity",
                  //     hintText: "Enter Minimum Stock Quantity",
                  //     controller: _minimumStockQtyController,
                  //     isValidate: true,
                  //     validator: (value) => value == null || value.isEmpty
                  //         ? "Enter Minimum Stock Quantity"
                  //         : null,
                  //     focusNode: _minimumStockQtyFocus,
                  //     isNumeric: true,
                  //     textInputAction: TextInputAction.next,
                  //     onEditingComplete: () {
                  //       FocusScope.of(context)
                  //           .requestFocus(_minimumStockQtyFocus);
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: constraints.maxWidth / columns - 20,
                  //   child: CustomTextField(
                  //     title: "Maximum Stock Quantity",
                  //     hintText: "Enter Maximum Stock Quantity",
                  //     controller: _maximumStockQtyController,
                  //     isValidate: true,
                  //     validator: (value) => value == null || value.isEmpty
                  //         ? "Enter Minimum Stock Quantity"
                  //         : null,
                  //     focusNode: _maximumStockQtyFocus,
                  //     isNumeric: true,
                  //     textInputAction: TextInputAction.next,
                  //     onEditingComplete: () {
                  //       FocusScope.of(context)
                  //           .requestFocus(_maximumStockQtyFocus);
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: constraints.maxWidth / columns - 20,
                  //   child: CustomTextField(
                  //     title: "Re order Level",
                  //     hintText: "Enter Reorder Level",
                  //     controller: _reOrderLevelController,
                  //     isValidate: true,
                  //     validator: (value) => value == null || value.isEmpty
                  //         ? "Enter Reorder Level"
                  //         : null,
                  //     focusNode: _reOrderLevelFocus,
                  //     isNumeric: true,
                  //     textInputAction: TextInputAction.next,
                  //     onEditingComplete: () {
                  //       FocusScope.of(context).requestFocus(_reOrderLevelFocus);
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: constraints.maxWidth / columns - 20,
                  //   child: CustomTextField(
                  //     title: "Re order Quantity",
                  //     hintText: "Enter Reorder Quantity",
                  //     controller: _reOrderQtyController,
                  //     isValidate: true,
                  //     validator: (value) => value == null || value.isEmpty
                  //         ? "Enter Minimum Stock Quantity"
                  //         : null,
                  //     focusNode: _reOrderQtyFocus,
                  //     isNumeric: true,
                  //     textInputAction: TextInputAction.next,
                  //     onEditingComplete: () {
                  //       FocusScope.of(context).requestFocus(_reOrderQtyFocus);
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: SearchableDropdown<master.HsnMasters>(
                      hintText: "HSN Code",
                      items: getAllMasterListModel!.info!.hsnMasters!,
                      itemLabel: (group) => group.hsnName ?? "",
                      initialValue: _selectHSN,  
                      onChanged: (group) {
                        setState(() {
                         _hsntaxCode = group.hsnCode; 
                           _selectHSN = group;

                            final int itemGSTCode = group.hsnCode ?? 0; 
                          _gsttaxCode = itemGSTCode;
                          _selectgst = getAllMasterListModel?.info?.taxMasters?.firstWhere(
                                (g) => g.taxCode == itemGSTCode,
                                orElse: () => master.TaxMasters(taxCode: itemGSTCode, taxName: 'Unknown Group'),
                              );
                        });
                       
                      },
                      // focusNode: _itemUnitCodeFocus,
                      //               onEditingComplete: () => _fieldFocusChange(
                      //                 context,
                      //                 _itemUnitCodeFocus,
                      //                 _itemMakeCodeFocus,
                      //               ),

                      addPage: AddHnsMasterPage(
                        onSaved: (success) {
                          if (success) {
                            Navigator.pop(context, true);
                          }
                        },
                      ),
                      addTooltip: "Add HSN",
                    ),
                  ),
SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: SearchableDropdown<master.TaxMasters>( 
                      hintText: "Choose a GST",
                      items: getAllMasterListModel!.info!.taxMasters!,
                      itemLabel: (group) => group.taxName ?? "",
                      initialValue: _selectgst,  
                      onChanged: (group) {
                        setState(() {
                         _hsntaxCode = group.taxCode; 
                           _selectgst = group;
 
                        });
                       
                      },
                      // focusNode: _itemUnitCodeFocus,
                      //               onEditingComplete: () => _fieldFocusChange(
                      //                 context,
                      //                 _itemUnitCodeFocus,
                      //                 _itemMakeCodeFocus,
                      //               ),

                     
                    ),
                  ),
                  // SizedBox(
                  //   width: constraints.maxWidth / columns - 20,
                  //   child: CustomDropdownField<int>(
                  //     title: "Select GST",
                  //     hintText: "Choose a GST",
                  //     items: getAllMasterListModel!.info!.taxMasters!
                  //         .map((e) => DropdownMenuItem<int>(
                  //               value: e.taxCode, // 🔹 use taxCode as value
                  //               child:
                  //                   Text("${e.taxName} (${e.taxPercentage}%)"),
                  //             ))
                  //         .toList(),
                  //     initialValue: _selectHSN,  
                  //     onChanged: (value) {
                  //       setState(() {
                  //        _gsttaxCode = value.ta; 
                  //          _selectHSN = group;
                           
                  //         _hsntaxCode = value;
                  //         //  _taxCode = value;
                  //       });

                  //       final selected = getAllMasterListModel!
                  //           .info!.taxMasters!
                  //           .firstWhere((c) => c.taxCode == value,
                  //               orElse: () => master.TaxMasters());

                  //       print("Selected GST %: ${selected.taxPercentage}");
                  //       print("Selected TAX Code: ${selected.taxCode}");
                  //     },
                  //     isValidate: true,
                  //     validator: (value) =>
                  //         value == null ? "Please select a GST" : null,

                  //     // addPage: AddTaxMasterPage(
                  //     //   onSaved: (success) {
                  //     //     if (success) {
                  //     //       Navigator.pop(context, true);
                  //     //     }
                  //     //   },
                  //     // ),
                  //     // addTooltip: "Add Tax",
                  //   ),
                  // ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 30,
                    child: CustomDropdownField<int>(
                    title: "Price Taken From",
                      hintText: "Price Taken From",
                     items: const [
                        DropdownMenuItem(value: 0, child: Text("Purchase")),
                        DropdownMenuItem(value: 1, child: Text("Master")),
                      ],
                      controller: pricetakenfromController,
                    initialValue: priceTakenFrom,
                    onChanged: (val) {
                      setState(() => priceTakenFrom = val ?? 0);
                    },
                    focusNode: _priceTakenFromFocus,
                      onEditingComplete: () {
                        _fieldFocusChange(
                            context, _priceTakenFromFocus, _itemGroupFocus);
                      },
                  ),
                  ),
                  // SizedBox(
                  //   width: constraints.maxWidth / columns - 30,
                  //   child: CustomDropdownField<int>(
                  //     title: "Price Taken From",
                  //     hintText: "Price Taken From",
                  //     items: const [
                  //       DropdownMenuItem(value: 0, child: Text("Purchase")),
                  //       DropdownMenuItem(value: 1, child: Text("Master")),
                  //     ],
                  //     controller: pricetakenfromController,
                  //   initialValue: priceTakenFrom,
                  //   onChanged: (val) {
                  //     setState(() => priceTakenFrom = val ?? 0);
                  //   },
                  //     focusNode: _priceTakenFromFocus,
                  //     onEditingComplete: () {
                  //       _fieldFocusChange(
                  //           context, _priceTakenFromFocus, _itemGroupFocus);
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Purchase Rate",
                      hintText: "Enter Purchase Rate",
                      controller: _purchaseRateController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Purchase Rate"
                          : null,
                      focusNode: _purchaseRateFocus,
                      isNumeric: true,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_purchaseRateFocus);
                      },
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Purchase Rate With Tax",
                      hintText: "Enter Purchase Rate WithTax",
                      controller: _purchaseRateWTaxController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Purchase Rate With Tax"
                          : null,
                      focusNode: _purchaseRateWTaxFocus,
                      isNumeric: true,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(_purchaseRateWTaxFocus);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Sales Rate",
                      hintText: "Enter Sales Rate",
                      controller: _salesRateController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter Sales Rate "
                          : null,
                      focusNode: _salesRateFocus,
                      isNumeric: true,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_salesRateFocus);
                      },
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "MRP Rate",
                      hintText: "Enter MRP Rate",
                      controller: _mRPRateController,
                      isValidate: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter MRP Rate"
                          : null,
                      focusNode: _mRPRateFocus,
                      isNumeric: true,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_mRPRateFocus);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCheckbox(
                              label: "Discount",
                              value: _isDiscountReq,
                              onChanged: (val) {
                                setState(() {
                                  _isDiscountReq = val ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),

                  _isDiscountReq
                      ? SizedBox(
                          width: constraints.maxWidth / columns - 20,
                          child: CustomTextField(
                            title: "Discount %",
                            hintText: "Enter Discount Percentage",
                            controller: _itemDiscountPercentageController,
                            isValidate: true,
                            validator: (value) => value == null || value.isEmpty
                                ? "Enter Discount Percentage"
                                : null,
                            focusNode: _itemDiscountPercentageFocus,
                            isNumeric: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(_itemDiscountPercentageFocus);
                            },
                          ))
                      : SizedBox(),
                  _isDiscountReq
                      ? SizedBox(
                          width: constraints.maxWidth / columns - 20,
                          child: CustomTextField(
                            title: "Discount Value",
                            hintText: "Enter Discount value",
                            controller: _itemDiscountValueController,
                            isValidate: true,
                            validator: (value) => value == null || value.isEmpty
                                ? "Enter Discount Value"
                                : null,
                            focusNode: _itemDiscountValueFocus,
                            isNumeric: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(_itemDiscountValueFocus);
                            },
                          ))
                      : SizedBox(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImagePickerField(
                        title: "Choose Image",
                        onImageSelected: (file) {
                          setState(() {
                            _image = file;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: constraints.maxWidth / columns - 20,
                    child: CustomTextField(
                      title: "Create User",
                      controller: _createdUserController,
                      // prefixIcon: Icons.person,
                      isEdit: true,
                      focusNode: _createUserFocus,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _submit,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_loading)
                    const CircularProgressIndicator()
                  else
                    GradientButton(
                        text: isEdit ? "Update Product" : "Add Product",
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

// import 'package:facebilling/core/const.dart';
// import 'package:flutter/material.dart';

// import '../../../../data/models/get_all_master_list_model.dart' as master;
// //import '../../../../data/models/tax_master/tax_master_list_model.dart'  as tax;
// import '../../../../data/models/product/add_product_request.dart';
// import '../../../../data/models/product/product_master_list_model.dart';
// import '../../../../data/services/get_all_master_service.dart';
// import '../../../../data/services/product_service.dart';
// import '../../../../data/services/tax_master_service.dart' show TaxMasterService;
// import '../../../widgets/custom_dropdown_text_field.dart';
// import '../../../widgets/custom_switch.dart';
// import '../../../widgets/custom_text_field.dart';
// import '../../../widgets/gradient_button.dart';
// import '../../../widgets/search_dropdown_field.dart';

// class AddProductMasterPage extends StatefulWidget {
//   final Info? unitInfo;
//   final Function(bool success) onSaved;
//   const AddProductMasterPage({
//     super.key,
//     this.unitInfo,
//     required this.onSaved,
//   });

//   @override
//   State<AddProductMasterPage> createState() => _AddProductMasterPageState();
// }

// class _AddProductMasterPageState extends State<AddProductMasterPage> {
//   final _formKey = GlobalKey<FormState>();
//   ///services
//   final ProductService _service = ProductService();
//   final GetAllMasterService _getAllMasterService = GetAllMasterService();

//   bool _activeStatus = true;
//   bool _loading = false;
//   String? _message;
//     bool _getAllLoading = true;

//   String? error;
// ///model

// master. GetAllMasterListModel?getAllMasterListModel;
//    late TextEditingController _itemIdController;
//   late TextEditingController _itemNameController;
//   late TextEditingController _itemTypeController;
//   late TextEditingController _itemGroupCodeController;
//   late TextEditingController _itemUnitCodeController;
//   late TextEditingController _itemMakeCodeController;
//   late TextEditingController _itemGenericCodeController;
//   late TextEditingController _nonScheduleItemController;
//   late TextEditingController _scheduledH1ItemController;
//   late TextEditingController _narcoticItemController;
//   late TextEditingController _expiryDateFormatController;
//   late TextEditingController _expiryDateRequiredController;
//   late TextEditingController _subUnitCodeController;
//   late TextEditingController _subQtyController;
//   late TextEditingController _batchNoRequiredController;
//   late TextEditingController _minimumStockQtyController;
//   late TextEditingController _maximumStockQtyController;
//   late TextEditingController _reOrderLevelController;
//   late TextEditingController _reOrderQtyController;
//   late TextEditingController _priceTakenFromController;
//   late TextEditingController _itemDiscountPercentageController;
//   late TextEditingController _itemDiscountRequiredController;
//   late TextEditingController _itemDiscountValueController;
//   late TextEditingController _purchaseRateWTaxController;
//   late TextEditingController _purchaseRateController;
//   late TextEditingController _salesRateController;
//   late TextEditingController _mRPRateController;
//   late TextEditingController _gstPercentageController;
//   late TextEditingController _createdUserController;

//   // 🔹 FocusNodes
//   final FocusNode _itemIdFocus = FocusNode();
//   final FocusNode _itemNameFocus = FocusNode();
//   final FocusNode _itemTypeFocus = FocusNode();
//   final FocusNode _itemGroupCodeFocus = FocusNode();
//   final FocusNode _itemUnitCodeFocus = FocusNode();
//   final FocusNode _itemMakeCodeFocus = FocusNode();
//   final FocusNode _itemGenericCodeFocus = FocusNode();
//   final FocusNode _nonScheduleItemFocus = FocusNode();
//   final FocusNode _scheduledH1ItemFocus = FocusNode();
//   final FocusNode _narcoticItemFocus = FocusNode();
//   final FocusNode _expiryDateFormatFocus = FocusNode();
//   final FocusNode _expiryDateRequiredFocus = FocusNode();
//   final FocusNode _subUnitCodeFocus = FocusNode();
//   final FocusNode _subQtyFocus = FocusNode();
//   final FocusNode _batchNoRequiredFocus = FocusNode();
//   final FocusNode _minimumStockQtyFocus = FocusNode();
//   final FocusNode _maximumStockQtyFocus = FocusNode();
//   final FocusNode _reOrderLevelFocus = FocusNode();
//   final FocusNode _reOrderQtyFocus = FocusNode();
//   final FocusNode _priceTakenFromFocus = FocusNode();
//   final FocusNode _itemDiscountPercentageFocus = FocusNode();
//   final FocusNode _itemDiscountRequiredFocus = FocusNode();
//   final FocusNode _itemDiscountValueFocus = FocusNode();
//   final FocusNode _purchaseRateWTaxFocus = FocusNode();
//   final FocusNode _purchaseRateFocus = FocusNode();
//   final FocusNode _salesRateFocus = FocusNode();
//   final FocusNode _mRPRateFocus = FocusNode();
//   final FocusNode _gstPercentageFocus = FocusNode();
//   final FocusNode _createUserFocus = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     _loadList();
//     _itemIdController = TextEditingController(text: widget.unitInfo?.itemID ?? "");
//     _itemNameController = TextEditingController(text: widget.unitInfo?.itemName ?? "");
//     _itemTypeController = TextEditingController(text: widget.unitInfo?.itemType?.toString() ?? "");
//     _itemGroupCodeController = TextEditingController(text: widget.unitInfo?.itemGroupCode?.toString() ?? "");
//     _itemUnitCodeController = TextEditingController(text: widget.unitInfo?.itemUnitCode?.toString() ?? "");
//     _itemMakeCodeController = TextEditingController(text: widget.unitInfo?.itemMakeCode?.toString() ?? "");
//     _itemGenericCodeController = TextEditingController(text: widget.unitInfo?.itemGenericCode?.toString() ?? "");
//     _nonScheduleItemController = TextEditingController(text: widget.unitInfo?.nonScheduleItem?.toString() ?? "");
//     _scheduledH1ItemController = TextEditingController(text: widget.unitInfo?.scheduledH1Item?.toString() ?? "");
//     _narcoticItemController = TextEditingController(text: widget.unitInfo?.narcoticItem?.toString() ?? "");
//     _expiryDateFormatController = TextEditingController(text: widget.unitInfo?.expiryDateFormat ?? "");
//     _expiryDateRequiredController = TextEditingController(text: widget.unitInfo?.expiryDateRequired ?? "");
//     _subUnitCodeController = TextEditingController(text: widget.unitInfo?.subUnitCode?.toString() ?? "");
//     _subQtyController = TextEditingController(text: widget.unitInfo?.subQty?.toString() ?? "");
//     _batchNoRequiredController = TextEditingController(text: widget.unitInfo?.batchNoRequired?.toString() ?? "");
//     _minimumStockQtyController = TextEditingController(text: widget.unitInfo?.minimumStockQty?.toString() ?? "");
//     _maximumStockQtyController = TextEditingController(text: widget.unitInfo?.maximumStockQty?.toString() ?? "");
//     _reOrderLevelController = TextEditingController(text: widget.unitInfo?.reOrderLevel?.toString() ?? "");
//     _reOrderQtyController = TextEditingController(text: widget.unitInfo?.reOrderQty?.toString() ?? "");
//     _priceTakenFromController = TextEditingController(text: widget.unitInfo?.priceTakenFrom?.toString() ?? "");
//     _itemDiscountPercentageController = TextEditingController(text: widget.unitInfo?.itemDiscountPercentage?.toString() ?? "");
//     _itemDiscountRequiredController = TextEditingController(text: widget.unitInfo?.itemDiscountRequired?.toString() ?? "");
//     _itemDiscountValueController = TextEditingController(text: widget.unitInfo?.itemDiscountValue?.toString() ?? "");
//     _purchaseRateWTaxController = TextEditingController(text: widget.unitInfo?.purchaseRateWTax?.toString() ?? "");
//     _purchaseRateController = TextEditingController(text: widget.unitInfo?.purchaseRate?.toString() ?? "");
//     _salesRateController = TextEditingController(text: widget.unitInfo?.salesRate?.toString() ?? "");
//     _mRPRateController = TextEditingController(text: widget.unitInfo?.mRPRate?.toString() ?? "");
//     _gstPercentageController = TextEditingController(text: widget.unitInfo?.gstPercentage?.toString() ?? "");
//     _createdUserController = TextEditingController(text: userId.value!);

//     _activeStatus = (widget.unitInfo?.createdUserCode ?? 1) == 1;
//   }
// Future<void> _loadList() async {
//     final response = await _getAllMasterService.getAllMasterService();
//     if (response.isSuccess) {
//       setState(() {
//         getAllMasterListModel = response.data!;
//         _getAllLoading = false;
//         error = null;
//       });
//     } else {
//       setState(() {
//         error = response.error;
//         _getAllLoading = false;
//       });
//     }
//   }
//   @override
//   void dispose() {
//     _itemIdController.dispose();
//     _itemNameController.dispose();
//     _itemTypeController.dispose();
//     _itemGroupCodeController.dispose();
//     _itemUnitCodeController.dispose();
//     _itemMakeCodeController.dispose();
//     _itemGenericCodeController.dispose();
//     _nonScheduleItemController.dispose();
//     _scheduledH1ItemController.dispose();
//     _narcoticItemController.dispose();
//     _expiryDateFormatController.dispose();
//     _expiryDateRequiredController.dispose();
//     _subUnitCodeController.dispose();
//     _subQtyController.dispose();
//     _batchNoRequiredController.dispose();
//     _minimumStockQtyController.dispose();
//     _maximumStockQtyController.dispose();
//     _reOrderLevelController.dispose();
//     _reOrderQtyController.dispose();
//     _priceTakenFromController.dispose();
//     _itemDiscountPercentageController.dispose();
//     _itemDiscountRequiredController.dispose();
//     _itemDiscountValueController.dispose();
//     _purchaseRateWTaxController.dispose();
//     _purchaseRateController.dispose();
//     _salesRateController.dispose();
//     _mRPRateController.dispose();
//     _gstPercentageController.dispose();
//     _createdUserController.dispose();

//     _itemIdFocus.dispose();
//     _createUserFocus.dispose();
//     _itemNameFocus.dispose();
//     _itemTypeFocus.dispose();
//     _itemGroupCodeFocus.dispose();
//     _itemUnitCodeFocus.dispose();
//     _itemMakeCodeFocus.dispose();
//     _itemGenericCodeFocus.dispose();
//     _nonScheduleItemFocus.dispose();
//     _scheduledH1ItemFocus.dispose();
//     _narcoticItemFocus.dispose();
//     _expiryDateFormatFocus.dispose();
//     _expiryDateRequiredFocus.dispose();
//     _subUnitCodeFocus.dispose();
//     _subQtyFocus.dispose();
//     _batchNoRequiredFocus.dispose();
//     _minimumStockQtyFocus.dispose();
//     _maximumStockQtyFocus.dispose();
//     _reOrderLevelFocus.dispose();
//     _reOrderQtyFocus.dispose();
//     _priceTakenFromFocus.dispose();
//     _itemDiscountPercentageFocus.dispose();
//     _itemDiscountRequiredFocus.dispose();
//     _itemDiscountValueFocus.dispose();
//     _purchaseRateWTaxFocus.dispose();
//     _purchaseRateFocus.dispose();
//     _salesRateFocus.dispose();
//     _mRPRateFocus.dispose();
//     _gstPercentageFocus.dispose();

//     super.dispose();
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _loading = true;
//       _message = null;
//     });

//     if (widget.unitInfo == null) {
//       // ADD mode
//   //       String? userId;
//   // String? userName;
//   // String? userPassword;
//   // int? userType;
//   // int? activeStatus;
//      final request = AddProductMasterModel(
//   itemName:_itemNameController .text.trim(),
//     // current timestamp
//  // custActiveStatus: _activeStatus ? 1 : 0,
// );
// print("request");
// print(request);
//       final response = await _service.addProductService(request);
//       _handleResponse(response.isSuccess, response.error);
//     } else {
//       // EDIT mode
//  final updated = AddProductMasterModel(
//   itemName: _itemNameController.text.trim(),
//     // current timestamp
//  // custActiveStatus: _activeStatus ? 1 : 0,
// );
//      print("updated");
//      print(updated);
//       final response = await _service.updateProductService(
//         widget.unitInfo!.itemCode!,
//         updated,
//       );
//       _handleResponse(response.isSuccess, response.error);
//     }
//   }

//   void _handleResponse(bool success, String? error) {
//     setState(() {
//       _loading = false;
//       _message = success ? "Saved successfully!" : error;
//     });
//     if (success) widget.onSaved(true);
//   }

//   @override
//   void didUpdateWidget(covariant AddProductMasterPage oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.unitInfo != oldWidget.unitInfo) {
//       _itemIdController.text = widget.unitInfo?.itemCode.toString() ?? "";
//       _itemNameController.text = widget.unitInfo?.itemName ?? "";
//       // _createdUserController.text =
//       //     widget.countryInfo?.createdUserCode?.toString() ?? userId.value!;
//      // _activeStatus = (widget.unitInfo?.custActiveStatus ?? 1) == 1;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//         if (_getAllLoading) return const Center(child: CircularProgressIndicator());
//     if (error != null) return Center(child: Text("Error: $error"));

//     final isEdit = widget.unitInfo != null;

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child:
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             SearchDropdownField<Info>(
//               hintText: "Search Product",
//               prefixIcon: Icons.search,
//               fetchItems: (q) async {
//                 final response = await _service.getProductServiceSearch(q);
//                 if (response.isSuccess) {
//                   return (response.data?.info ?? [])
//                       .whereType<Info>()
//                       .toList();
//                 }
//                 return [];
//               },
//               displayString: (unit) => unit.itemName ?? "",
//               onSelected: (country) {
//                 setState(() {
//                _itemIdController.text = country.itemCode.toString() ?? "";
//       _itemNameController.text = country.itemName ?? "";
//                   // _createdUserController.text =
//                   //     country.createdUserCode?.toString() ?? userId.value!;
//                  // _activeStatus = (country.custActiveStatus ?? 1) == 1;
//                 });

//                 // ✅ Switch form into "Update mode"
//                 widget.onSaved(false);
//               },
//             ),

//             const SizedBox(height: 26),
//             // SwitchListTile(
//             //   value: _activeStatus,
//             //   title: const Text("Active Status"),
//             //   onChanged: (val) => setState(() => _activeStatus = val),
//             // ),
//             CustomSwitch(
//               value: _activeStatus,
//               title: "Active Status",
//               onChanged: (val) {
//                 setState(() {
//                   _activeStatus = val;
//                 });
//               },
//             ),
//             CustomTextField(
//               title: "Item Code",
//               hintText: "Enter Item Code",
//               controller: _itemIdController,
//               prefixIcon: Icons.flag_circle,
//               isValidate: true,
//               validator: (value) =>
//                   value == null || value.isEmpty ? "Enter unit ID" : null,
//               focusNode: _itemIdFocus,
//               textInputAction: TextInputAction.next,
//               onEditingComplete: () {
//                 FocusScope.of(context).requestFocus(_itemIdFocus);
//               },
//             ),
//             const SizedBox(height: 16),
//             CustomTextField(
//               title: "Product Name",
//               hintText: "Enter Product Name",
//               controller: _itemNameController,
//               prefixIcon: Icons.flag,
//               isValidate: true,
//               validator: (value) =>
//                   value == null || value.isEmpty ? "Enter Product name" : null,
//               focusNode: _itemNameFocus,
//               textInputAction: TextInputAction.next,
//               onEditingComplete: () {
//                 // FocusScope.of(context).requestFocus(_createdUserFocus);
//               },
//             ),
//             const SizedBox(height: 16),
//          CustomDropdownField<int>(
//   title: "Select GST",
//   hintText: "Choose a GST",
//   items: getAllMasterListModel!.info!.taxMasters!
//       .map((e) => DropdownMenuItem<int>(
//             value: e.taxCode, // 🔹 use taxCode as value
//             child: Text("${e.taxName} (${e.taxPercentage}%)"),
//           ))
//       .toList(),
//  // initialValue: _taxCode, // int? taxCode
//   onChanged: (value) {
//     setState(() {
//     //  _taxCode = value;
//     });

//     final selected = getAllMasterListModel!.info!.taxMasters!
//         .firstWhere((c) => c.taxCode == value, orElse: () => master.TaxMasters());

//     print("Selected GST %: ${selected.taxPercentage}");
//     print("Selected TAX Code: ${selected.taxCode}");
//   },
//   isValidate: true,
//   validator: (value) => value == null ? "Please select a GST" : null,
// ),
//  const SizedBox(height: 10),
//             CustomTextField(
//               title: "Create User",
//               controller: _createdUserController,
//               prefixIcon: Icons.person,
//               isEdit: true,
//               focusNode: _createUserFocus,
//               textInputAction: TextInputAction.done,
//               onEditingComplete: _submit,
//             ),
//             const SizedBox(height: 16),
//             // SwitchListTile(
//             //   value: _activeStatus,
//             //   title: const Text("Active Status"),
//             //   onChanged: (val) => setState(() => _activeStatus = val),
//             // ),
//             const SizedBox(height: 16),
//             if (_loading)
//               const CircularProgressIndicator()
//             else
//               GradientButton(
//                   text: isEdit ? "Update User" : "Add User",
//                   onPressed: _submit),
//             if (_message != null) ...[
//               const SizedBox(height: 16),
//               Text(
//                 _message!,
//                 style: TextStyle(
//                   color: _message!.contains("successfully")
//                       ? Colors.green
//                       : Colors.red,
//                 ),
//               ),
//             ]
//           ],
//         ),

//       ),
//     );
//   }
// }
