// import 'package:facebilling/core/const.dart';
// import 'package:facebilling/data/models/get_serial_no_model.dart' as serialno;
// import 'package:facebilling/data/services/supplier_master_service.dart';
// import 'package:facebilling/ui/screens/masters/supplier_group_master/add_supplier_group_master_page.dart';
// import 'package:facebilling/ui/screens/masters/supplier_master/Add_supplier_master_page.dart';
// import 'package:facebilling/ui/widgets/AutoSearchDropdown.dart';
// import 'package:facebilling/ui/widgets/Table_Component/item_add_grid_component.dart';
// import 'package:facebilling/ui/widgets/Table_Component/models/data_cell_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

// import '../../../../core/colors.dart';
// import '../../../../data/models/get_all_master_list_model.dart' as master;
// //import '../../../../data/models/tax_master/tax_master_list_model.dart'  as tax;
// import '../../../../data/models/product/product_master_list_model.dart'
//     as product;
// import '../../../../data/models/purchase_model/add_purchase_master_model.dart';
// import '../../../../data/models/purchase_model/purchase_list_model.dart';
// import '../../../../data/models/supplier_master/supplier_master_list_model.dart';
// import '../../../../data/services/get_all_master_service.dart';
// import '../../../../data/services/get_serial_no_services.dart';
// import '../../../../data/services/product_service.dart';
// import '../../../../data/services/purchase_master_service.dart';
// import '../../../../data/services/tax_master_service.dart'
//     show TaxMasterService;
// import '../../../widgets/custom_dropdown_text_field.dart';
// import '../../../widgets/custom_switch.dart';
// import '../../../widgets/custom_text_field.dart';
// import '../../../widgets/gradient_button.dart';
// import '../../../widgets/gst_calc_table.dart';
// import '../../../widgets/label_textfield.dart';
// import '../../../widgets/product_drop_down_field.dart';
// import '../../../widgets/product_search_field.dart';
// import '../../../widgets/search_dropdown.dart';
// import '../../../widgets/search_dropdown_field.dart';
// import '../../masters/product_master/add_product_master_page.dart';
// import 'add_purchase_controller.dart';

// class AddPurchaseMasterPage extends StatefulWidget {
//   final Info? unitInfo;
//   final Function(bool success) onSaved;
//   const AddPurchaseMasterPage({
//     super.key,
//     this.unitInfo,
//     required this.onSaved,
//   });

//   @override
//   State<AddPurchaseMasterPage> createState() => _AddPurchaseMasterPageState();
// }

// class _AddPurchaseMasterPageState extends State<AddPurchaseMasterPage> {
//   final _formKey = GlobalKey<FormState>();
//   final FocusNode _keyboardFocusNode = FocusNode();

//   Widget suggestionTable = Container();

//   int totalItems = 0;
//   List<Map<String, dynamic>> savedTableData = [];
//   String uom = "PCS";
//   int totalQty = 0;
//   double totalCost = 0.0;
//   double totalvat = 0.00;
//   double grassAmt = 0.00;
//   double discount = 0.00;

//   ///services
//   final PurchaseMasterService _service = PurchaseMasterService();
//   final GetAllMasterService _getAllMasterService = GetAllMasterService();
//   final ProductService _productService = ProductService();
//   final GetSerialNoServices _getSerialservice = GetSerialNoServices();
//   final SupplierMasterService _supplier = SupplierMasterService();
//   product.Info? editingUnit;
//   bool refreshList = false;
//   bool _activeStatus = true;
//   bool _loading = false;
//   String? _message;
//   bool _getAllLoading = true;
//   bool _getSerialNoLoading = true;
//   int? _highlightedIndex; // null = nothing highlighted
//   final FocusNode _subTableFocus = FocusNode(); // focus for keyboard
//   ///sales rate calculation
//   double _totalSalesRate = 0.0;
//   int? selectedPaymentType = 1;
//   int? selectedEntryType = 1;
//   int? selectedEntryMode = 1;
//   int? selectedTaxType;
//   int? selectedGstType;
//   serialno.GetSerialNoModel? serialNo;
// //   void _calculateTotalSalesRate() {
// //     double total = 0.0;
// //     for (var item in items) {
// //     total += item.salesRate ?? 0;
// //     }
// //     setState(() {
// //       _totalSalesRate = total;
// //       print("_totalSalesRate");
// //       print(_totalSalesRate);
// // // Suppose GST = 18% and Sales Rate = 1000
// //       _setGSTValues("18%", _totalSalesRate);
// //       _calculateInvoiceFromTotalSalesRate(_totalSalesRate);
// //     });
// //   }

//   void _calculateTotalSalesRate() {
//     double total = 0.0;
//     for (var item in items) {
//       // Ensure numeric
//       final rate = item.salesRate is num
//           ? item.salesRate!.toDouble()
//           : double.tryParse(item.salesRate.toString()) ?? 0.0;
//       total += rate;
//     }
//     setState(() {
//       _totalSalesRate = total;
//       print("_totalSalesRate: $_totalSalesRate");
//       _setGSTValues("18%", _totalSalesRate);
//       _calculateInvoiceFromTotalSalesRate(_totalSalesRate);
//     });
//   }

//   void _setGSTValues(String gstRate, double totalSalesRate) {
//     final gstPercent = double.tryParse(gstRate.replaceAll('%', '')) ?? 0;

//     // ✅ Percentages
//     final sgstPercent = gstPercent / 2;
//     final cgstPercent = gstPercent / 2;
//     final igstPercent = gstPercent;

//     // ✅ Amounts
//     final gstAmount = totalSalesRate * gstPercent / 100;
//     final sgstAmount = totalSalesRate * sgstPercent / 100;
//     final cgstAmount = totalSalesRate * cgstPercent / 100;
//     final igstAmount = totalSalesRate * igstPercent / 100;

//     // ✅ Set into controllers (percentages)
//     _sgstpreController.text = sgstPercent.toStringAsFixed(2);
//     _cgstpreController.text = cgstPercent.toStringAsFixed(2);
//     _igstpreController.text = igstPercent.toStringAsFixed(2);

//     // ✅ (If you have extra controllers for amounts)
//     _sgstAmtController.text = sgstAmount.toStringAsFixed(2);
//     _cgstAmtController.text = cgstAmount.toStringAsFixed(2);
//     _igstAmtController.text = igstAmount.toStringAsFixed(2);

//     // ✅ Optional: show total amount including GST
//     _totalGstAmtController.text =
//         (totalSalesRate + gstAmount).toStringAsFixed(2);
//   }

//   void _calculateInvoiceFromTotalSalesRate(double totalSalesRate) {
//     // Example: define percentages for discount, GST, etc.
//     const double discountPercent = 10; // 10% discount
//     const double gstPercent = 18; // 18% GST
//     const double freightPercent = 2; // 2% freight
//     // Round off will be calculated automatically to nearest integer

//     // Calculate values based on totalSalesRate
//     final double subTotal = totalSalesRate;
//     final double discount = subTotal * (discountPercent / 100);
//     final double gstValue = (subTotal - discount) * (gstPercent / 100);
//     final double freight = subTotal * (freightPercent / 100);

//     // Net amount before rounding
//     double netAmount = subTotal - discount + gstValue + freight;

//     // Round off to nearest integer
//     final double roundOff = (netAmount - netAmount.floor()) >= 0.5
//         ? (netAmount.ceil() - netAmount)
//         : (netAmount.floor() - netAmount);
//     netAmount += roundOff;

//     // ✅ Update controllers
//     _subTotalValueController.text = subTotal.toStringAsFixed(2);
//     _discountController.text = discount.toStringAsFixed(2);
//     _gstValueController.text = gstValue.toStringAsFixed(2);
//     _roundOffController.text = roundOff.toStringAsFixed(2);
//     _frightChargesController.text = freight.toStringAsFixed(2);
//     _netAmountController.text = netAmount.toStringAsFixed(2);
//   }

//   String? error;
//   bool _isBottomBarExpanded = false;

//   ///model

//   master.GetAllMasterListModel? getAllMasterListModel;
//   product.ProductMasterListModel? productMasterListModel;
//   AddPurchaseMasterModel? addPurchaseMasterModel;
//   List<product.Info> _searchResults = [];
//   bool _showSubTable = false;
//   int? _activeRowIndex; // to know which row we are editing

//   late TextEditingController _supplierNameController;
//   late TextEditingController _supplierInvoicNoController;
//   late TextEditingController _invoiceDateController;
//   late TextEditingController _gstTypeController;
//   late TextEditingController _invoiceAmtController;
//   late TextEditingController _supStateController;
//   late TextEditingController _purchaseNoController;
//   late TextEditingController _purchaseDateController;
//   late TextEditingController _paymentModeController;
//   late TextEditingController _basedOnController;
//   late TextEditingController _accountNameController;
//   late TextEditingController _subTotalValueController;
//   late TextEditingController _gstValueController;
//   late TextEditingController _discountController;
//   late TextEditingController _roundOffController;
//   late TextEditingController _frightChargesController;
//   late TextEditingController _netAmountController;
//   late TextEditingController _sgstpreController;
//   late TextEditingController _cgstpreController;
//   late TextEditingController _igstpreController;
//   late TextEditingController _sgstAmtController;
//   late TextEditingController _cgstAmtController;
//   late TextEditingController _igstAmtController;
//   late TextEditingController _totalGstAmtController;
//   late TextEditingController _qtyTotalController;

//   // final TextEditingController itemCodeController = TextEditingController();
//   // final TextEditingController itemNameController = TextEditingController();

//   final TextEditingController batchNoController = TextEditingController();
//   final TextEditingController expiryController = TextEditingController();
//   final TextEditingController hsnController = TextEditingController();
//   final TextEditingController qtyController = TextEditingController();
//   final TextEditingController mrpController = TextEditingController();
//   final TextEditingController salesRateController = TextEditingController();
//   final TextEditingController gstController = TextEditingController();
//   final TextEditingController taxTypeController = TextEditingController();

//   late TextEditingController _supCodeController;
//   late TextEditingController _purchaseTaxableAmountController;
//   late TextEditingController _purchaseNetAmountController;
//   late TextEditingController _subTotalBeforeDiscountController;
//   late TextEditingController _supDueDaysController;
//   late TextEditingController _paidAmountController;
//   late TextEditingController _purchaseNotesController;
//   late TextEditingController _purchaseAccCodeController;
//   late TextEditingController _purchaseDiscoutPercentageController;
//   late TextEditingController _purchaseDiscountValueController;
//   late TextEditingController _cashDiscountPercentageController;
//   late TextEditingController _cashDiscountValueController;
//   late TextEditingController _frieghtChargesAddWithTotalController;
//   late TextEditingController _frieghtChargesAddWithoutTotalController;
//   late TextEditingController _createUserCodeController;
//   late TextEditingController _computerNameController;
//   late TextEditingController _vehicleNoController;
//   late TextEditingController _finYearCodeController;
//   late TextEditingController _coCodeController;
//   late TextEditingController _purchaseEntryTypeController;
//   late TextEditingController _purchaseEntryModeController;
//   late TextEditingController _taxTypeController;
//   late TextEditingController _supGstTypeController;
//   late TextEditingController _createDateTimeController;

//   // 🔹 FocusNodes
//   final FocusNode _supNameFocus = FocusNode();
//   final FocusNode _spurchaseNoFocus = FocusNode();
//   final FocusNode _itemNameFocus = FocusNode();
//   final FocusNode _invoiceNoFocus = FocusNode();
//   final FocusNode _invoiceDateFocus = FocusNode();
//   final FocusNode _gstTypeFocus = FocusNode();
//   final FocusNode _invoiceAmtFocus = FocusNode();
//   final FocusNode _purchaseNoFocus = FocusNode();
//   final FocusNode _purchaseDateFocus = FocusNode();
//   final FocusNode _paymentModeFocus = FocusNode();
//   final FocusNode _basedOnFocus = FocusNode();
//   final FocusNode _accountNameFocus = FocusNode();
//   final FocusNode _gstValueFocus = FocusNode();
//   final FocusNode _subTotalFocus = FocusNode();
//   final FocusNode _discountFocus = FocusNode();
//   final FocusNode _roundOFfFocus = FocusNode();
//   final FocusNode _frightFocus = FocusNode();
//   final FocusNode _netAmountFocus = FocusNode();
//   late FocusNode _sgstpreFocus;
//   late FocusNode _cgstpreFocus;
//   late FocusNode _igstpreFocus;
//   late FocusNode _sgstAmtFocus;
//   late FocusNode _cgstAmtFocus;
//   late FocusNode _igstAmtFocus;
//   late FocusNode _totalGstAmtFocus;
//   late FocusNode _qtyTotalFocus;
//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(Duration(milliseconds: 300), () {
//       FocusScope.of(context).requestFocus(_spurchaseNoFocus);
//     });
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _keyboardFocusNode.requestFocus();
//     });
//     _loadList();
//     //_itemIdController = TextEditingController(text: widget.unitInfo?.purchaseAccCode.toString() ?? "");

//     _supplierNameController =
//         TextEditingController(text: widget.unitInfo?.supName ?? "");
//     _supplierInvoicNoController =
//         TextEditingController(text: widget.unitInfo?.invoiceNo ?? "");
//     _invoiceDateController = TextEditingController(
//       text: widget.unitInfo?.invoiceDate != null
//           ? DateFormat('dd-MM-yyyy')
//               .format(DateTime.parse(widget.unitInfo!.invoiceDate!))
//           : DateFormat('dd-MM-yyyy').format(DateTime.now()),
//     );
//     _gstTypeController =
//         TextEditingController(text: widget.unitInfo?.taxType.toString() ?? "");
//     _invoiceAmtController = TextEditingController(
//         text: widget.unitInfo?.iGSTAmount?.toString() ?? "");
//     _purchaseNoController =
//         TextEditingController(text: widget.unitInfo?.purchaseNo ?? "");
//     _supStateController = TextEditingController(text: "");
//     _purchaseDateController = TextEditingController(
//       text: widget.unitInfo?.purchaseDate?.isNotEmpty == true
//           ? widget.unitInfo!.purchaseDate
//           : DateFormat('dd-MM-yyyy')
//               .format(DateTime.now()), // YYYY-MM-DD format
//     );
//     _paymentModeController = TextEditingController(
//         text: widget.unitInfo?.paymentType.toString() ?? "");
//     _basedOnController = TextEditingController(text: "");
//     _accountNameController = TextEditingController(text: "");
//     _subTotalValueController = TextEditingController(text: "");
//     _gstValueController = TextEditingController(text: "");
//     _discountController = TextEditingController(text: "");
//     _roundOffController = TextEditingController(text: "");
//     _frightChargesController = TextEditingController(text: "");
//     _netAmountController = TextEditingController(text: "");

//     _sgstpreController = TextEditingController(text: '');
//     _cgstpreController = TextEditingController(text: '');
//     _igstpreController = TextEditingController(text: '');
//     _sgstAmtController = TextEditingController(text: '');
//     _cgstAmtController = TextEditingController(text: '');
//     _igstAmtController = TextEditingController(text: '');
//     _totalGstAmtController = TextEditingController(text: '');
//     _qtyTotalController = TextEditingController(text: '');
//     _supCodeController = TextEditingController();
//     _purchaseTaxableAmountController = TextEditingController();
//     _purchaseNetAmountController = TextEditingController();
//     _subTotalBeforeDiscountController = TextEditingController();
//     _supDueDaysController = TextEditingController();
//     _paidAmountController = TextEditingController();
//     _purchaseNotesController = TextEditingController();
//     _purchaseAccCodeController = TextEditingController();
//     _purchaseDiscoutPercentageController = TextEditingController();
//     _purchaseDiscountValueController = TextEditingController();
//     _cashDiscountPercentageController = TextEditingController();
//     _cashDiscountValueController = TextEditingController();
//     _frieghtChargesAddWithTotalController = TextEditingController();
//     _frieghtChargesAddWithoutTotalController = TextEditingController();
//     _createUserCodeController = TextEditingController();
//     _computerNameController = TextEditingController();
//     _vehicleNoController = TextEditingController();
//     _finYearCodeController = TextEditingController();
//     _coCodeController = TextEditingController();
//     _purchaseEntryTypeController = TextEditingController(text: "ENTRY");
//     _purchaseEntryModeController = TextEditingController();
//     _taxTypeController = TextEditingController();
//     _supGstTypeController = TextEditingController();
//     _createDateTimeController = TextEditingController();
//     // Initialize focus nodes
//     _sgstpreFocus = FocusNode();
//     _cgstpreFocus = FocusNode();
//     _igstpreFocus = FocusNode();
//     _sgstAmtFocus = FocusNode();
//     _cgstAmtFocus = FocusNode();
//     _igstAmtFocus = FocusNode();
//     _totalGstAmtFocus = FocusNode();
//     _qtyTotalFocus = FocusNode();
//   }

//   String? serialError;

//   Future<void> _loadList() async {
//     setState(() {
//       _getAllLoading = true;
//       error = null;
//       print("error 5");
//       print(error);
//     });

//     try {
//       // 🔹 Load master data
//       final response = await _getAllMasterService.getAllMasterService();
//       if (response.isSuccess) {
//         getAllMasterListModel = response.data!;
//       } else {
//         print("error 6");
//         print(response.error);
//         throw Exception(response.error);
//       }

//       // 🔹 Load product list
//       final productResponse = await _productService.getSProductService();
//       if (productResponse.isSuccess) {
//         productMasterListModel = productResponse.data!;
//         items = productMasterListModel!.info!;
//         print("items.length");
//         print(items.length);
//       } else {
//         print("error 7");
//         print(response.error);
//         throw Exception(productResponse.error);
//       }

//       // 🔹 Load serial no. separately
//       await _loadSerialNo();
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         print("error 4");
//         print(error);
//       });
//     } finally {
//       setState(() {
//         _getAllLoading = false;
//       });
//     }
//   }

//   Future<void> _loadSerialNo() async {
//     try {
//       final serialNoResponse = await _getSerialservice.getSerialNo();
//       if (serialNoResponse.isSuccess) {
//         setState(() {
//           serialNo = serialNoResponse.data!;
//           _purchaseNoController.text = serialNo?.info?.purchaseNextId ?? "";
//           serialError = null;
//           print("error 1");
//           print(serialError); // ✅ clear if success
//         });
//       } else {
//         setState(() {
//           serialError = serialNoResponse.error ?? "Serial number not found.";
//           print("error 2");
//           print(serialError);
//         });
//       }
//     } catch (e) {
//       setState(() {
//         serialError = e.toString();
//         print("error 3");
//         print(serialError);
//       });
//     }
//   }

//   void _onSaved(bool success) {
//     if (success) {
//       setState(() {
//         editingUnit = null; // reset after save
//         refreshList = true; // trigger reload
//       });
//     }
//   }

//   @override
//   void dispose() {
//     // 🔹 Dispose controllers
//     _supplierNameController.dispose();
//     _supplierInvoicNoController.dispose();
//     _invoiceDateController.dispose();
//     _gstTypeController.dispose();
//     _invoiceAmtController.dispose();
//     _purchaseNoController.dispose();
//     _supStateController.dispose();
//     _purchaseDateController.dispose();
//     _paymentModeController.dispose();
//     _basedOnController.dispose();
//     _accountNameController.dispose();
//     _sgstpreController.dispose();
//     _cgstpreController.dispose();
//     _igstpreController.dispose();
//     _sgstAmtController.dispose();
//     _cgstAmtController.dispose();
//     _igstAmtController.dispose();
//     _totalGstAmtController.dispose();
//     _qtyTotalController.dispose();

//     // Dispose focus nodes
//     _sgstpreFocus.dispose();
//     _cgstpreFocus.dispose();
//     _igstpreFocus.dispose();
//     _sgstAmtFocus.dispose();
//     _cgstAmtFocus.dispose();
//     _igstAmtFocus.dispose();
//     _totalGstAmtFocus.dispose();
//     _qtyTotalFocus.dispose();
//     // 🔹 Dispose FocusNodes
//     _supNameFocus.dispose();
//     _itemNameFocus.dispose();
//     _invoiceNoFocus.dispose();
//     _invoiceDateFocus.dispose();
//     _gstTypeFocus.dispose();
//     _invoiceAmtFocus.dispose();
//     _purchaseNoFocus.dispose();
//     _purchaseDateFocus.dispose();
//     _paymentModeFocus.dispose();
//     _basedOnFocus.dispose();
//     _accountNameFocus.dispose();

//     super.dispose();
//   }

//   List<product.Info> items = [
//     product.Info(
//       itemCode: null, // Item Code
//       itemName: '', // Item Name
//       batchNoRequired: 0, // Batch Number
//       expiryDateFormat: '', // Expiry Date
//       hSNCode: '', // HSN Code
//       maximumStockQty: 0, // Quantity
//       mRPRate: 0, // MRP / Rate
//       // netRate: 0,            // Net Rate
//       // netValue: 0,           // Net Value
//       salesRate: 0, // Sale Rate
//       gstPercentage: 0, // GST %
//       // finYearCode : "2025-26",
//       // gstPercentage: 0,           // GST Value
//       // supName: '',           // Supplier Name
//       //purchaseAccCode: null, // Purchase Account Code
//       // add other fields in your model as needed
//     ),
//   ];
//   List<ItemRowControllers> controllers = [ItemRowControllers()];
//   Future<void> _pickDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(), // default date
//       firstDate: DateTime(2000), // earliest date allowed
//       lastDate: DateTime(2100), // latest date allowed
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _invoiceDateController.text =
//             DateFormat('dd-MM-yyyy').format(pickedDate);
//       });
//     }
//   }

//   List<Items> itemsList = []; // Empty list
//   // will fill from API
//   void loadItemsFromApi() async {
//     final response = await _productService.getProductServiceSearch("");
//     if (response.isSuccess) {
//       items = (response.data?.info ?? [])
//           .map((e) => product.Info(
//                 itemCode: e.itemCode!,
//                 itemName: e.itemName ?? '',
//                 // barcode: e.barcode ?? '',
//                 // uom: 'PCS',
//                 // rate: e.rate?.toDouble() ?? 0,
//                 // qty: 0,
//                 // grossAmt: 0,
//                 // vatAmt: 0,
//                 // netAmt: 0,
//               ))
//           .toList();
//       setState(() {});
//     }
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _loading = true;
//       _message = null;
//     });
//     final filledItems = itemsList.map((item) {
//       // finYearCode
//       if (item.finYearCode == null || item.finYearCode!.isEmpty) {
//         item.finYearCode = _finYearCodeController.text.trim().isNotEmpty
//             ? _finYearCodeController.text.trim()
//             : "2025-26";
//       }

//       // ExpiryDate
//       if (item.expiryDate == null || item.expiryDate!.isEmpty) {
//         // Set default or nullable value
//         item.expiryDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
//       } else {
//         try {
//           // Ensure valid date format
//           final parsedDate = DateTime.parse(item.expiryDate!);
//           item.expiryDate = DateFormat('yyyy-MM-dd').format(parsedDate);
//         } catch (e) {
//           // fallback if parsing fails
//           item.expiryDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
//         }
//       }

//       return item;
//     }).toList();

//     final purchaseDate = _purchaseDateController.text.trim();
//     final invoiceDate = _invoiceDateController.text.trim();

//     final formattedPurchaseDate = DateFormat('dd-MM-yyyy').parse(purchaseDate);
//     final formattedInvoiceDate = DateFormat('dd-MM-yyyy').parse(invoiceDate);

//     if (widget.unitInfo == null) {
//       // ADD mode
//       //       String? userId;
//       // String? userName;
//       // String? userPassword;
//       // int? userType;
//       // int? activeStatus;
//       final request = AddPurchaseMasterModel(
// // Basic info

//         invoiceNo: _supplierInvoicNoController.text.trim(),
//         purchaseDate: DateFormat('yyyy-MM-dd').format(formattedPurchaseDate),
//         invoiceDate: DateFormat('yyyy-MM-dd').format(formattedInvoiceDate),
//         purchaseOrderNo: _purchaseNoController.text.trim(),
//         purchaseOrderDate:
//             DateFormat('yyyy-MM-dd').format(formattedPurchaseDate),
//         supName: _supplierNameController.text.trim(),
//         supCode: int.tryParse(_supplierNameController.text) ?? 0,

//         // Payment & purchase types
//         paymentType: selectedPaymentType, // from dropdown (0,1,2)
//         purchaseEntryType: selectedEntryType, // from dropdown (0,1,2)
//         purchaseEntryMode: selectedEntryMode, // from dropdown (1,2)
//         taxType: selectedTaxType ?? 0, // from dropdown (0,1)
//         supGstType: selectedGstType ?? 0, // from dropdown (0,1,2)

//         // Amounts
//         purchaseTaxableAmount: int.tryParse(_gstValueController.text) ?? 0,
//         purchaseGstAmount: int.tryParse(_gstValueController.text) ?? 0,
//         purchaseNetAmount: int.tryParse(_netAmountController.text) ?? 0,
//         subTotalBeforeDiscount:
//             int.tryParse(_subTotalValueController.text) ?? 0,
//         sGSTAmount: int.tryParse(_sgstAmtController.text) ?? 0,
//         cGSTAmount: int.tryParse(_cgstAmtController.text) ?? 0,
//         iGSTAmount: int.tryParse(_igstAmtController.text) ?? 0,
//         roundOffAmount: double.tryParse(_roundOffController.text) ?? 0.0,
//         frieghtChargesAddWithTotal:
//             int.tryParse(_frightChargesController.text) ?? 10,

//         // Discounts
//         purchaseDiscoutPercentage: int.tryParse(_discountController.text) ?? 0,
//         purchaseDiscountValue: int.tryParse(_discountController.text) ?? 0,
//         cashDiscountPercentage: int.tryParse(_discountController.text) ?? 0,
//         cashDiscountValue: int.tryParse(_cashDiscountValueController.text) ?? 0,
//         frieghtChargesAddWithoutTotal: 0,
//         // Other details
//         paidAmount: int.tryParse(_paidAmountController.text) ?? 0,
//         supDueDays: int.tryParse(_supDueDaysController.text) ?? 0,
//         createUserCode: int.tryParse(userId.value!),
//         createDateTime:
//             DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
//         computerName: "computerName",
//         vehicleNo: "00",
//         finYearCode: _finYearCodeController.text.trim().isNotEmpty
//             ? _finYearCodeController.text.trim()
//             : "2025-26",
//         coCode: 0,
//         purchaseNotes: "",
//         purchaseAccCode: 0,

//         // Items list
//         // Ensure all items have a valid finYearCode

//         items: filledItems, // List<Items> you've populated earlier
//       );

// // Print the full request as JSON
//       print("AddPurchaseMasterModel request:");
//       print(request.toJson());
//       final response = await _service.addPurchaseMaster(request);

//       _handleResponse(response.isSuccess, response.error);
//       if (response.isSuccess) {
//         // Clear all text fields
//         _supplierInvoicNoController.clear();
//         _purchaseNoController.clear();
//         _supStateController.clear();
//         _purchaseDateController.clear();
//         _invoiceDateController.clear();
//         _supplierNameController.clear();
//         _gstValueController.clear();
//         _netAmountController.clear();
//         _subTotalValueController.clear();
//         _sgstAmtController.clear();
//         _cgstAmtController.clear();
//         _igstAmtController.clear();
//         _roundOffController.clear();
//         _frightChargesController.clear();
//         _discountController.clear();
//         _cashDiscountValueController.clear();
//         _paidAmountController.clear();
//         _supDueDaysController.clear();
//         _vehicleNoController.clear();
//         _finYearCodeController.clear();
//         items.clear();
//         _isBottomBarExpanded = false;
//         // Clear items list
//         setState(() {
//           itemsList.clear();
//         });

//         // Optionally, reset dropdowns
//         selectedPaymentType = 0;
//         selectedEntryType = 0;
//         selectedEntryMode = 1;
//         selectedTaxType = 0;
//         selectedGstType = 0;
//       }

//       setState(() {
//         _loading = false;
//       });
//     } else {
//       // EDIT mode
//       final updated = AddPurchaseMasterModel(
//         purchaseDate: DateFormat('yyyy-MM-dd').format(formattedPurchaseDate),
//         invoiceDate: DateFormat('yyyy-MM-dd').format(formattedInvoiceDate),
//         // Basic info
//         // purchaseDate: _purchaseDateController.text.trim(),
//         // invoiceNo: _invoiceNoController.text.trim(),
//         // invoiceDate: _invoiceDateController.text.trim(),
//         // purchaseOrderNo: _purchaseOrderNoController.text.trim(),
//         // purchaseOrderDate: _purchaseOrderDateController.text.trim(),
//         // supName: _supplierNameController.text.trim(),
//         supCode: int.tryParse(_supplierNameController.text) ?? 0,

//         // Payment & purchase types
//         paymentType: selectedPaymentType, // from dropdown (0,1,2)
//         purchaseEntryType: selectedEntryType, // from dropdown (0,1,2)
//         purchaseEntryMode: selectedEntryMode, // from dropdown (1,2)
//         taxType: selectedTaxType, // from dropdown (0,1)
//         supGstType: selectedGstType, // from dropdown (0,1,2)

//         // Amounts
//         purchaseTaxableAmount: int.tryParse(_gstValueController.text) ?? 0,
//         purchaseGstAmount: int.tryParse(_gstValueController.text) ?? 0,
//         purchaseNetAmount: int.tryParse(_netAmountController.text) ?? 0,
//         subTotalBeforeDiscount:
//             int.tryParse(_subTotalValueController.text) ?? 0,
//         sGSTAmount: int.tryParse(_sgstAmtController.text) ?? 0,
//         cGSTAmount: int.tryParse(_cgstAmtController.text) ?? 0,
//         iGSTAmount: int.tryParse(_igstAmtController.text) ?? 0,
//         roundOffAmount: double.tryParse(_roundOffController.text) ?? 0.0,
//         frieghtChargesAddWithTotal:
//             int.tryParse(_frightChargesController.text) ?? 0,

//         // Discounts
//         purchaseDiscoutPercentage: int.tryParse(_discountController.text) ?? 0,
//         purchaseDiscountValue: int.tryParse(_discountController.text) ?? 0,
//         cashDiscountPercentage: int.tryParse(_discountController.text) ?? 0,
//         cashDiscountValue: int.tryParse(_cashDiscountValueController.text) ?? 0,

//         // Other details
//         paidAmount: int.tryParse(_paidAmountController.text) ?? 0,
//         supDueDays: int.tryParse(_supDueDaysController.text) ?? 0,
//         createUserCode: int.tryParse(userId.value!),
//         createDateTime:
//             DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
//         computerName: "computerName",
//         vehicleNo: _vehicleNoController.text.trim(),
//         finYearCode: _finYearCodeController.text.trim().isNotEmpty
//             ? _finYearCodeController.text.trim()
//             : "2025-26", // example default
//         coCode: 0,
//         purchaseNotes: "",
//         purchaseAccCode: 0,

//         // Items list

//         items: filledItems, // List<Items> you've populated earlier
//       );
//       print("updated");
//       print(updated);
//       final response = await _service.updatePurchaseMaster(
//         widget.unitInfo!.purchaseAccCode!,
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

//     if (success) {
//       // Clear all text fields
//       _supplierInvoicNoController.clear();
//       _purchaseNoController.clear();
//       _supStateController.clear();
//       _purchaseDateController.clear();
//       _invoiceDateController.clear();
//       _supplierNameController.clear();
//       _gstValueController.clear();
//       _netAmountController.clear();
//       _subTotalValueController.clear();
//       _sgstAmtController.clear();
//       _cgstAmtController.clear();
//       _igstAmtController.clear();
//       _roundOffController.clear();
//       _frightChargesController.clear();
//       _discountController.clear();
//       _cashDiscountValueController.clear();
//       _paidAmountController.clear();
//       _supDueDaysController.clear();
//       _vehicleNoController.clear();
//       _finYearCodeController.clear();

//       // Clear items list
//       itemsList.clear();
//       _isBottomBarExpanded = false;

//       // Reset dropdowns
//       selectedPaymentType = 0;
//       selectedEntryType = 0;
//       selectedEntryMode = 1;
//       selectedTaxType = 0;
//       selectedGstType = 0;

//       setState(() {}); // Update the UI

//       // Notify parent widget if needed
//       widget.onSaved(true);
//     }
//   }

//   @override
//   void didUpdateWidget(covariant AddPurchaseMasterPage oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.unitInfo != oldWidget.unitInfo) {
//       //  _itemIdController.text = widget.unitInfo?.purchaseAccCode.toString() ?? "";
//       _supplierNameController.text = widget.unitInfo?.purchaseNo ?? "";
//       // _createdUserController.text =
//       //     widget.countryInfo?.createdUserCode?.toString() ?? userId.value!;
//       // _activeStatus = (widget.unitInfo?.custActiveStatus ?? 1) == 1;
//     }
//   }

//   void _fieldFocusChange(
//       BuildContext context, FocusNode current, FocusNode next) {
//     current.unfocus();
//     FocusScope.of(context).requestFocus(next);
//   }

//   void _showAddProductPopup(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Prevent accidental closing
//       builder: (BuildContext context) {
//         final screenSize = MediaQuery.of(context).size;
//         final dialogWidth = screenSize.width * 0.7;
//         final dialogHeight = screenSize.height * 0.9;

//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           insetPadding: EdgeInsets.symmetric(
//             horizontal: screenSize.width * 0.15,
//             vertical: screenSize.height * 0.2,
//           ),
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               maxWidth: dialogWidth,
//               maxHeight: dialogHeight,
//             ),
//             child: Scaffold(
//               backgroundColor: white,
//               appBar: AppBar(
//                 title: const Text("Add Product"),
//                 backgroundColor: const Color(0xFF0B2046),
//                 foregroundColor: white,
//                 centerTitle: true,
//                 automaticallyImplyLeading: false,
//                 actions: [
//                   IconButton(
//                     icon: const Icon(Icons.close, color: white),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//               body: AddProductMasterPage(
//                 onSaved: (bool success) {
//                   if (success) {
//                     Navigator.pop(context);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text("Product added successfully")),
//                     );
//                     setState(() {
//                       // 🔹 Optionally reload your table data
//                       // _fetchProducts();
//                     });
//                   }
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_getAllLoading) return const Center(child: CircularProgressIndicator());
//     if (error != null) return Center(child: Text("Error: $error"));

//     final isEdit = widget.unitInfo != null;

//     return RawKeyboardListener(
//       focusNode: _keyboardFocusNode,
//       autofocus: true,
//       onKey: (RawKeyEvent event) {
//         if (event is RawKeyDownEvent) {
//           final isShiftPressed = event.isShiftPressed;
//           final keyLabel = event.logicalKey.keyLabel.toLowerCase();

//           if (isShiftPressed && keyLabel == 'm') {
//             setState(() {
//               selectedEntryMode = (selectedEntryMode == 1) ? 2 : 1;
//             });

//             debugPrint("🟢 Entry Mode changed to: $selectedEntryMode");

//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text("Entry Mode switched to: $selectedEntryMode"),
//                 duration: const Duration(seconds: 1),
//               ),
//             );
//           }
//         }
//       },

//       // ✅ your existing UI starts here
//       child: Scaffold(
//           backgroundColor: selectedEntryMode == 1 ? white : lightblue,
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: LayoutBuilder(builder: (context, constraints) {
//                   int columns = 1; // default mobile
//                   if (constraints.maxWidth > 1200) {
//                     columns = 4;
//                   } else if (constraints.maxWidth > 800) {
//                     columns = 3;
//                   }
//                   return Wrap(
//                     spacing: 16,
//                     runSpacing: 16,
//                     children: [
//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         // 1. Ensure the generic type is your Product model (e.g., ProductMasterInfo)
//                         child: AutoSuggestion<SupplierInfo>(
//                           controller: _supplierNameController,
//                           labelText: 'Supplier Name',
//                           hintText: 'Search by Supplier Name',

//                           suggestionsCallback: (pattern) async {
//                             final apiResponse = await _supplier
//                                 .getSupplierMasterSearch(pattern);

//                             if (apiResponse.error != null) {
//                               return [];
//                             }

//                             return apiResponse.data?.info ?? [];
//                           },

//                           // 🎯 FIX: Use Product-specific fields
//                           itemBuilder: (context, suggestion) {
//                             // Assuming suggestion is now ProductMasterInfo
//                             return ListTile(
//                               title: Text(
//                                   suggestion.supName ?? ""), // Use item name
//                               subtitle: Text(
//                                   'mobile: ${suggestion.supMobileNo ?? ""}'), // Use item code
//                             );
//                           },

//                           onSuggestionSelected: (supplier) {
//                             // Assuming you have a ProductMasterInfo variable like _selectedProduct
//                             // setState(() => _selectedProduct = product);
//                             print('Selected Product: ${supplier.supCode}');
//                             // You should update your product-related state here, not a customer state
//                           },

//                           // 🎯 FIX: Use Product-specific text extractor
//                           getDisplayString: (product) => product.supName ?? "",
//                           addPage: AddSupplierMasterPage(
//                             onSaved: (success) async {
//                               if (success) {
//                                 Navigator.pop(context, true);
//                                 await _loadList();
//                               }
//                             },
//                           ),
//                           addTooltip: "Add Item Make",
//                         ),
//                       ),
//                       // SizedBox(
//                       //   width: constraints.maxWidth / columns - 20,
//                       //   child: SearchableDropdown<master.Suppliers>(
//                       //     hintText: "Supplier Name",
//                       //     items: getAllMasterListModel!.info!.suppliers!,
//                       //     itemLabel: (supplier) => supplier.supName ?? "",
//                       //     onChanged: (supplier) {
//                       //       if (supplier != null) {
//                       //         _supplierNameController.text =
//                       //             supplier.supCode.toString();
//                       //         print("Selected Code: ${supplier.supCode}");
//                       //         print("Selected Name: ${supplier.supName}");
//                       //         print(
//                       //             "Selected GSt type: ${supplier.supGSTType}");

//                       //         // TaxType: 0=Exclusive, 1=Inclusive
//                       //         if (supplier.taxIsIncluded == 1) {
//                       //           selectedTaxType = 1;
//                       //           selectedGstType = 1;
//                       //           taxTypeController.text = "Inclusive";
//                       //         } else {
//                       //           selectedTaxType = 0;
//                       //           selectedGstType = 0;
//                       //           taxTypeController.text = 'Exclusive';
//                       //         }
//                       //         //_gstTypeController
//                       //         if (supplier.supGSTType == 1) {
//                       //           _gstTypeController.text = "";
//                       //         } else {
//                       //           _gstTypeController.text = "";
//                       //         }
//                       //       }
//                       //     },
//                       //     addPage: AddSupplierMasterPage(
//                       //       onSaved: (success) async {
//                       //         if (success) {
//                       //           Navigator.pop(context, true);
//                       //           await _loadList();
//                       //         }
//                       //       },
//                       //     ),
//                       //     addTooltip: "Add Item Make",
//                       //   ),
//                       // ),
//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         child: CustomTextField(
//                           title: "Supplier State",
//                           hintText: "Supplier State",
//                           controller: _supStateController,
//                           // prefixIcon: Icons.person,
//                           isEdit: true,
//                           focusNode: _spurchaseNoFocus,
//                           textInputAction: TextInputAction.done,
//                           onEditingComplete: () => _fieldFocusChange(
//                               context, _supNameFocus, _invoiceDateFocus),
//                         ),
//                       ),
//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         child: CustomTextField(
//                           title: "Purches No",
//                           hintText: "Purches No",
//                           controller: _purchaseNoController,
//                           // prefixIcon: Icons.person,
//                           isEdit: true,
//                           focusNode: _spurchaseNoFocus,
//                           textInputAction: TextInputAction.done,
//                           onEditingComplete: () => _fieldFocusChange(
//                               context, _supNameFocus, _invoiceDateFocus),
//                         ),
//                       ),
//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         child: CustomTextField(
//                           title: "Supplier Invoice No",
//                           hintText: "Invoice No",
//                           controller: _supplierInvoicNoController,
//                           // prefixIcon: Icons.person,
//                           isEdit: false,
//                           focusNode: _supNameFocus,
//                           textInputAction: TextInputAction.done,
//                           onEditingComplete: () => _fieldFocusChange(
//                               context, _supNameFocus, _invoiceDateFocus),
//                         ),
//                       ),
//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         child: CustomTextField(
//                           title: " Supplier GST Type",
//                           hintText: "Supplier GST Type",
//                           controller: _gstTypeController,
//                           // prefixIcon: Icons.person,
//                           isEdit: true,
//                           focusNode: _gstTypeFocus,
//                           textInputAction: TextInputAction.done,
//                           onEditingComplete: () => _fieldFocusChange(
//                               context, _gstTypeFocus, _invoiceAmtFocus),
//                         ),
//                       ),
//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         child: CustomTextField(
//                           title: "Purchase Date",
//                           controller: _purchaseDateController,
//                           // prefixIcon: Icons.person,
//                           isEdit: true,
//                           focusNode: _purchaseDateFocus,
//                           textInputAction: TextInputAction.done,
//                           onEditingComplete: () => _fieldFocusChange(
//                               context, _purchaseDateFocus, _basedOnFocus),
//                         ),
//                       ),
//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         child: GestureDetector(
//                           onTap: () {
//                             _pickDate();
//                           },
//                           child: CustomTextField(
//                             title: "Invoice Date",
//                             controller: _invoiceDateController,
//                             // prefixIcon: Icons.person,
//                             isEdit: true,
//                             focusNode: _invoiceDateFocus,
//                             textInputAction: TextInputAction.done,
//                             onEditingComplete: () => _fieldFocusChange(
//                                 context, _invoiceDateFocus, _gstTypeFocus),
//                           ),
//                         ),
//                       ),

//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         child: CustomTextField(
//                           title: "Tax Type",
//                           controller: taxTypeController,
//                           // prefixIcon: Icons.person,
//                           isEdit: true,
//                           focusNode: _invoiceDateFocus,
//                           textInputAction: TextInputAction.done,
//                           onEditingComplete: () => _fieldFocusChange(
//                               context, _invoiceDateFocus, _gstTypeFocus),
//                         ),
//                       ),
//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         child: CustomDropdownField<int>(
//                           title: "Payment Type",
//                           hintText: "Select Payment Type",
//                           items: const [
//                             DropdownMenuItem(value: 0, child: Text("Credit")),
//                             DropdownMenuItem(value: 1, child: Text("Cash")),
//                             DropdownMenuItem(value: 2, child: Text("Cheque")),
//                           ],
//                           initialValue: selectedPaymentType,
//                           onChanged: (val) {
//                             setState(() => selectedPaymentType = val);
//                             print("Selected PaymentType: $val");
//                           },
//                         ),
//                       ),

//                       // PurchaseEntryType : 0=Opening,1=Entry,2=Order

//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         child: CustomTextField(
//                           title: "Invoice Amount",
//                           hintText: "Invoice Amount",
//                           controller: _invoiceAmtController,
//                           // prefixIcon: Icons.person,
//                           isEdit: false,
//                           focusNode: _invoiceAmtFocus,
//                           textInputAction: TextInputAction.done,
//                           onEditingComplete: () => _fieldFocusChange(
//                               context, _gstTypeFocus, _purchaseNoFocus),
//                         ),
//                       ),
//                       SizedBox(
//                         width: constraints.maxWidth / columns - 20,
//                         child: CustomTextField(
//                           title: "Purchase Entry Type",
//                           hintText: "Purchase Entry Type",
//                           controller: _purchaseEntryTypeController,
//                           // prefixIcon: Icons.person,
//                           isEdit: true,
//                           // focusNode: _spurchaseNoFocus,
//                           textInputAction: TextInputAction.done,
//                           // onEditingComplete: () => _fieldFocusChange(
//                           //     context, _supNameFocus, _invoiceDateFocus),
//                         ),
//                       ),
// //New Table
//                       CustomDataTableComponent(
//                         dataList: [
//                           DataCellModel(
//                               label: "SL No",
//                               dataCellSize: DataCellSize.XS,
//                               editable: true),
//                           DataCellModel(
//                               label: "ITEM CODE", dataCellSize: DataCellSize.S),
//                           DataCellModel(
//                               label: "BARCODE NO",
//                               dataCellSize: DataCellSize.M),
//                           DataCellModel(
//                               label: "ITEM NAME",
//                               dataCellSize: DataCellSize.L,
//                               dataCellDataType: DataCellDataType.TEXT,
//                               editable: true),
//                           DataCellModel(
//                             label: "UOM",
//                             dataCellSize: DataCellSize.S,
//                             dataCellDataType: DataCellDataType.TEXT,
//                           ),
//                           DataCellModel(
//                               label: "QTY",
//                               dataCellSize: DataCellSize.XS,
//                               editable: true),
//                           DataCellModel(
//                               label: "RATE", dataCellSize: DataCellSize.S),
//                           // DataCellModel(
//                           //     label: "COST RATE",
//                           //     dataCellSize: DataCellSize.S),
//                           DataCellModel(
//                               label: "GROSS AMOUNT",
//                               editable: false,
//                               dataCellSize: DataCellSize.S),
//                           DataCellModel(label: "VAT AMOUNT", editable: false),
//                           DataCellModel(label: "NET AMOUNT", editable: false),
//                           DataCellModel(
//                               label: "ACTION",
//                               dataCellSize: DataCellSize.S,
//                               dataCellDataType: DataCellDataType.BUTTON),
//                         ],
//                         callBack: () {
//                           // Call this function every time the table updates
//                           setState(() {});
//                         },
//                         suggestionData: (k) {
//                           suggestionTable = k;

//                           setState(() {});
//                         },
//                         onUpdate: (items, qty, cost) {
//                           if (!mounted)
//                             return; // Ensure the widget is still in the tree

//                           WidgetsBinding.instance.addPostFrameCallback((_) {
//                             if (!mounted)
//                               return; // Double check before updating state
//                             setState(() {
//                               totalItems = items;
//                               totalQty = qty;
//                               totalCost = cost;
//                               print(
//                                   "Total Items: $totalItems, Total Qty: $totalQty, Total Cost: $totalCost");
//                             });
//                           });
//                         },
//                         onSave: (data) {
//                           WidgetsBinding.instance.addPostFrameCallback((_) {
//                             setState(() {
//                               savedTableData = data;
//                               print("Saved Table Data: $savedTableData");
//                             });
//                           });
//                         },
//                       ),
//                       // Old Table //

//                       // SizedBox(
//                       //   width: constraints.maxWidth / columns - 20,
//                       //   child: CustomDropdownField<int>(
//                       //     title: "Purchase Entry Type",
//                       //     hintText: "Select Entry Type",
//                       //     items: const [
//                       //       DropdownMenuItem(value: 0, child: Text("Opening")),
//                       //       DropdownMenuItem(value: 1, child: Text("Entry")),
//                       //       DropdownMenuItem(value: 2, child: Text("Order")),
//                       //     ],
//                       //     initialValue: selectedEntryType,
//                       //     onChanged: (val) {
//                       //       setState(() => selectedEntryType = val);
//                       //       print("Selected EntryType: $val");
//                       //     },
//                       //   ),
//                       // ),

//                       // PurchaseEntryMode: 1=Mode1,2=Mode2
//                       // SizedBox(
//                       //   width: constraints.maxWidth / columns - 20,
//                       //   child: CustomDropdownField<int>(
//                       //     title: "Purchase Entry Mode",
//                       //     hintText: "Select Mode",
//                       //     items: const [
//                       //       DropdownMenuItem(value: 1, child: Text("Mode1")),
//                       //       DropdownMenuItem(value: 2, child: Text("Mode2")),
//                       //     ],
//                       //     initialValue: selectedEntryMode,
//                       //     onChanged: (val) {
//                       //       setState(() => selectedEntryMode = val);
//                       //       print("Selected EntryMode: $val");
//                       //     },
//                       //   ),
//                       // ),

//                       // TaxType: 0=Exclusive, 1=Inclusive

//                       const Divider(),

//                       // SupGstType: 0=No Gst, 1=SGST,2=IGST

//                       // SizedBox(
//                       //   width: constraints.maxWidth / columns - 20,
//                       //   child: CustomTextField(
//                       //     title: "Based On",
//                       //     hintText: "Based On",
//                       //     controller: _basedOnController,
//                       //     // prefixIcon: Icons.person,
//                       //     isEdit: false,
//                       //     focusNode: _basedOnFocus,
//                       //     textInputAction: TextInputAction.done,
//                       //     onEditingComplete: () => _fieldFocusChange(
//                       //         context, _purchaseDateFocus, _accountNameFocus),
//                       //   ),
//                       // ),
//                       // SizedBox(
//                       //   width: constraints.maxWidth / columns - 20,
//                       //   child: CustomTextField(
//                       //     title: "Amount Name",
//                       //     hintText: "Amount Name",
//                       //     controller: _accountNameController,
//                       //     // prefixIcon: Icons.person,
//                       //     isEdit: false,
//                       //     focusNode: _accountNameFocus,
//                       //     textInputAction: TextInputAction.done,
//                       //     onEditingComplete: _submit,
//                       //   ),
//                       // ),

//                       // const SizedBox(height: 26),

//                       const SizedBox(
//                         height: 10,
//                       ),

//                       SizedBox(
//                         width: double.infinity,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: DataTable(
//                             headingRowHeight: 30,
//                             dataRowMinHeight: 40,
//                             dataRowMaxHeight:
//                                 40, // ✅ same value prevents constraint issues
//                             showCheckboxColumn: false,
//                             border: TableBorder.all(color: primary),
//                             columnSpacing: 20,
//                             headingRowColor: MaterialStateProperty.all(primary),
//                             columns: [
//                               const DataColumn(
//                                   label: Text("SL No",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("Item Id",
//                                       style: TextStyle(color: white))),
//                               DataColumn(
//                                 label: Row(
//                                   children: [
//                                     const Text("Item Name",
//                                         style: TextStyle(color: white)),
//                                     const SizedBox(width: 4),
//                                     IconButton(
//                                       icon: const Icon(
//                                           Icons.add_circle_outline_rounded,
//                                           color: white,
//                                           size: 20),
//                                       onPressed: () {},
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const DataColumn(
//                                   label: Text("HSN Code",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("Batch No",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("Expiry",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("UOM",
//                                       style: TextStyle(color: white))),

//                               const DataColumn(
//                                   label: Text("Qty",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("Purchase Rate",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("MRP/Rate",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("Sales Rate",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("GST %",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("Discount %",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("Taxable Value",
//                                       style: TextStyle(color: white))),
//                               const DataColumn(
//                                   label: Text("Net Rate %",
//                                       style: TextStyle(
//                                           color: white))), //sales rate
//                               const DataColumn(
//                                   label: Text("Net Value",
//                                       style: TextStyle(
//                                           color: white))), // qty x sales Rate
//                               const DataColumn(
//                                   label: Text("Action",
//                                       style: TextStyle(color: white))),
//                             ],
//                             rows: List.generate(items.length, (index) {
//                               // if (index >= controllers.length) {
//                               //   controllers.add(ItemRowControllers());
//                               // }
//                               if (controllers.length < items.length) {
//                                 for (int i = controllers.length;
//                                     i < items.length;
//                                     i++) {
//                                   controllers.add(ItemRowControllers());
//                                 }
//                               } else if (controllers.length > items.length) {
//                                 controllers.removeRange(
//                                     items.length, controllers.length);
//                               }
//                               final controller = controllers[index];
//                               final item = items[index];

//                               return DataRow(cells: [
//                                 DataCell(Text("${index + 1}")),
//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.itemCodeController,
//                                   focusNode: controller.itemCodeFocus,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) => item.itemCode = val,
//                                 )),
//                                 DataCell(
//                                   TextFormField(
//                                     style: TextStyle(fontSize: 12),
//                                     controller: controller.itemNameController,
//                                     focusNode: controller.itemNameFocus,
//                                     decoration: const InputDecoration(
//                                         hintText: "Item Name",
//                                         border: InputBorder.none),
//                                     onChanged: (val) async {
//                                       if (val.isNotEmpty) {
//                                         final response = await _productService
//                                             .getProductServiceSearch(val);
//                                         if (response.isSuccess &&
//                                             response.data!.info!.isNotEmpty) {
//                                           setState(() {
//                                             _searchResults =
//                                                 response.data!.info!;
//                                             _showSubTable = true;
//                                             _activeRowIndex = index;
//                                           });
//                                         }
//                                       } else {
//                                         setState(() {
//                                           _searchResults.clear();
//                                           _showSubTable = false;
//                                           _activeRowIndex = null;
//                                         });
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.hsnController,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) => item.hSNCode = val,
//                                 )),

//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.batchNoController,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) => item.batchNoRequired =
//                                       int.tryParse(val) ?? 0,
//                                 )),
//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.expiryController,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) =>
//                                       item.expiryDateFormat = val,
//                                 )),
//                                 DataCell(Text(item.itemBoxNo ?? "")),
//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.qtyController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) => item.maximumStockQty =
//                                       int.tryParse(val) ?? 0,
//                                 )),

//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.purchaseRateController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) =>
//                                       item.mRPRate = double.tryParse(val) ?? 0,
//                                 )),

//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.mrpController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) =>
//                                       item.mRPRate = double.tryParse(val) ?? 0,
//                                 )),

//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.salesRateController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) => item.salesRate =
//                                       double.tryParse(val) ?? 0,
//                                 )),

//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.gstController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) => item.gstPercentage =
//                                       int.tryParse(val) ?? 0,
//                                 )),

//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller:
//                                       controller.discountPercentageController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) =>
//                                       item.itemDiscountPercentage =
//                                           int.tryParse(val) ?? 0,
//                                 )),
//                                 // DataCell(Text(item.itemBoxNo ?? "")),

//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.taxableValueController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) =>
//                                       item.itemDiscountPercentage =
//                                           int.tryParse("10") ?? 0,
//                                 )),
//                                 // DataCell(Text(item.itemBoxNo ?? "")),

//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.netRateController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) => item
//                                           .itemDiscountPercentage =
//                                       int.tryParse(item.salesRate.toString()) ??
//                                           0,
//                                 )),
//                                 DataCell(TextFormField(
//                                   style: TextStyle(fontSize: 12),
//                                   controller: controller.netValueController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                       border: InputBorder.none),
//                                   onChanged: (val) => item
//                                           .itemDiscountPercentage =
//                                       int.tryParse(item.salesRate.toString()) ??
//                                           0,
//                                 )),
//                                 // DataCell(Text(item.itemBoxNo ?? "")),

//                                 DataCell(
//                                   controller.itemNameController.text.isNotEmpty
//                                       ? Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             // Edit icon
//                                             IconButton(
//                                               icon: const Icon(Icons.edit,
//                                                   color: primary),
//                                               onPressed: () {
//                                                 _showEditPopup(context, index);
//                                               },
//                                             ),
//                                             // Delete icon
//                                             IconButton(
//                                               icon: const Icon(Icons.delete,
//                                                   color: red),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   items.removeAt(index);
//                                                   controllers.removeAt(index);

//                                                   // Always keep at least 1 blank row
//                                                   if (items.isEmpty) {
//                                                     items.add(product.Info(
//                                                       itemCode: null,
//                                                       itemName: '',
//                                                       batchNoRequired: 0,
//                                                       expiryDateFormat: '',
//                                                       hSNCode: '',
//                                                       maximumStockQty: 0,
//                                                       mRPRate: 0,
//                                                       salesRate: 0,
//                                                       gstPercentage: 0,
//                                                     ));
//                                                     controllers.add(
//                                                         ItemRowControllers());
//                                                   }
//                                                 });
//                                               },
//                                             ),
//                                           ],
//                                         )
//                                       : const SizedBox
//                                           .shrink(), // Nothing is shown if itemNameController is empty
//                                 ),
//                               ]);
//                             }),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(
//                         height: 0,
//                       ),
//                       if (!_showSubTable)
//                         SizedBox(
//                           height: 200,
//                         ),
//                       if (_showSubTable)
//                       SizedBox(
//                         height: 800,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.vertical,
//                             child: _searchResults.isNotEmpty
//                                 ? DataTable(
//                                     headingRowHeight:
//                                         30, // <-- Reduce header height
//                                     dataRowHeight: 40,
//                                     showCheckboxColumn: false,
//                                     border: TableBorder.all(color: lightgray),
//                                     headingRowColor:
//                                         MaterialStateProperty.all(primary),
//                                     columns: const [
//                                       DataColumn(
//                                           label: Text(
//                                         "SL No",
//                                         style: TextStyle(color: white),
//                                       )),
//                                       DataColumn(
//                                           label: Text(
//                                         "Item Id",
//                                         style: TextStyle(color: white),
//                                       )),
//                                       DataColumn(
//                                           label: Text(
//                                         "Item Name",
//                                         style: TextStyle(color: white),
//                                       )),
//                                       DataColumn(
//                                           label: Text(
//                                         "Batch No",
//                                         style: TextStyle(color: white),
//                                       )),
//                                       DataColumn(
//                                           label: Text(
//                                         "Expiry",
//                                         style: TextStyle(color: white),
//                                       )),
//                                       DataColumn(
//                                           label: Text(
//                                         "VOM",
//                                         style: TextStyle(color: white),
//                                       )),
//                                       DataColumn(
//                                           label: Text(
//                                         "HSN Code",
//                                         style: TextStyle(color: white),
//                                       )),
//                                       DataColumn(
//                                           label: Text(
//                                         "FreeQty",
//                                         style: TextStyle(color: white),
//                                       )),
//                                       DataColumn(
//                                           label: Text(
//                                         "MRP/Rate",
//                                         style: TextStyle(color: white),
//                                       )),
//                                       // DataColumn(label: Text("Net Rate")),
//                                       // DataColumn(label: Text("Net Value")),
//                                       DataColumn(
//                                           label: Text(
//                                         "Purchase Rate",
//                                         style: TextStyle(color: white),
//                                       )),
//                                       DataColumn(
//                                           label: Text(
//                                         "Sales Rate",
//                                         style: TextStyle(color: white),
//                                       )),
//                                     ],
//                                     rows: _searchResults
//                                         .asMap()
//                                         .entries
//                                         .map((entry) {
//                                       final index = entry
//                                           .key; // <-- gives you the index
//                                       final p = entry
//                                           .value; // <-- this is your Info object

//                                       return DataRow(
//                                         onSelectChanged: (_) {
//                                           setState(() {
//                                             if (_activeRowIndex != null) {
//                                               // final p = _searchResults[_activeRowIndex!];
//                                               final item =
//                                                   items[_activeRowIndex!];
//                                               final controller = controllers[
//                                                   _activeRowIndex!];
//                                               item.itemID = p.itemID;
//                                               item.itemName =
//                                                   p.itemName ?? '';
//                                               item.batchNoRequired =
//                                                   p.batchNoRequired ?? 0;
//                                               item.expiryDateFormat =
//                                                   p.expiryDateFormat ?? '';

//                                               item.hSNCode = p.hSNCode ?? '';
//                                               item.maximumStockQty =
//                                                   p.maximumStockQty ?? 0;
//                                               item.mRPRate = p.mRPRate ?? 0;
//                                               item.salesRate =
//                                                   p.salesRate ?? 0;
//                                               item.gstPercentage =
//                                                   p.gstPercentage ?? 0;

//                                               // Update controllers
//                                               controller.itemCodeController
//                                                       .text =
//                                                   item.itemID?.toString() ??
//                                                       '';
//                                               controller.itemNameController
//                                                   .text = item.itemName ?? '';
//                                               controller.batchNoController
//                                                       .text =
//                                                   item.batchNoRequired
//                                                       .toString();
//                                               controller
//                                                       .expiryController.text =
//                                                   item.expiryDateFormat ?? '';
//                                               controller.hsnController.text =
//                                                   item.hSNCode ?? '';
//                                               controller
//                                                       .purchaseRateController
//                                                       .text =
//                                                   item.purchaseRate ?? "";
//                                               controller
//                                                   .discountPercentageController
//                                                   .text = item
//                                                       .itemDiscountPercentage ??
//                                                   "0";
//                                               controller.netRateController
//                                                   .text = item.salesRate;
//                                               //
//                                               controller.qtyController.text =
//                                                   item.maximumStockQty
//                                                       .toString();
//                                               controller.mrpController.text =
//                                                   item.mRPRate.toString();
//                                               controller.salesRateController
//                                                       .text =
//                                                   item.salesRate.toString();
//                                               controller.gstController.text =
//                                                   item.gstPercentage
//                                                       .toString();
//                                               // controller.gstValueController
//                                               //         .text =
//                                               //     item.gstPercentage
//                                               //         .toString();
//                                               double salesRate =
//                                                   double.tryParse(item
//                                                           .salesRate
//                                                           .toString()) ??
//                                                       0;
//                                               double qty = double.tryParse(
//                                                       item.maximumStockQty
//                                                           .toString()) ??
//                                                   0;
//                                               controller.netValueController
//                                                       .text =
//                                                   (salesRate * qty)
//                                                       .toStringAsFixed(2);
//                                               double gstPercentage =
//                                                   double.tryParse(item
//                                                           .gstPercentage
//                                                           .toString()) ??
//                                                       0;

//                                               print(
//                                                   "Net Value: ${controller.netValueController.text}");
//                                               double gstAmount = salesRate *
//                                                   gstPercentage /
//                                                   100;

//                                               double discountPercentage =
//                                                   double.tryParse(item
//                                                           .itemDiscountPercentage
//                                                           .toString()) ??
//                                                       0;

//                                               controller.gstValueController
//                                                       .text =
//                                                   gstAmount
//                                                       .toStringAsFixed(2);

//                                               print(
//                                                   "GST Amount: ${controller.gstValueController.text}");
//                                               double discountAmount =
//                                                   salesRate *
//                                                       discountPercentage /
//                                                       100;

//                                               controller
//                                                       .discountValueController
//                                                       .text =
//                                                   discountAmount
//                                                       .toStringAsFixed(2);

//                                               _calculateTotalSalesRate();
//                                               // Convert Info to Items
//                                               final newItem = Items(
//                                                 itemCode: p.itemCode,
//                                                 itemID: p.itemID ?? '',
//                                                 itemName: p.itemName ?? '',
//                                                 itemGroupCode:
//                                                     p.itemGroupCode ?? 0,
//                                                 itemMakeCode:
//                                                     p.itemMakeCode ?? 0,
//                                                 itemGenericCode:
//                                                     p.itemGenericCode ?? 0,
//                                                 barCodeId: '',
//                                                 batchNo: p.batchNoRequired
//                                                         ?.toString() ??
//                                                     '',
//                                                 mFGDate: "2025-10-01",
//                                                 expiryDate: "2025-10-07",
//                                                 //  mFGDate: '2025-10-01',
//                                                 //   expiryDate:
//                                                 //       p.expiryDateFormat ?? '',
//                                                 hsnCode: int.tryParse(
//                                                         p.hSNCode ?? '0') ??
//                                                     0,
//                                                 gstPercentage:
//                                                     p.gstPercentage ?? 0,

//                                                 itemQuantity:
//                                                     p.maximumStockQty ?? 0,
//                                                 freeQuantity: 0,
//                                                 itemUnitCode:
//                                                     p.itemUnitCode ?? 0,
//                                                 subQuantity: 0,
//                                                 subQtyUnitCode: 0,
//                                                 subQtyPurchaseRate: 0,
//                                                 itemPurchaseRate:
//                                                     p.purchaseRate ?? 0,
//                                                 purchaseRateBeforeTax: 0.0,
//                                                 itemDiscountPercentage: 0,
//                                                 itemDiscountValue: 0,
//                                                 itemGstValue: 0,
//                                                 itemValue: 0,
//                                                 actualPurchaseRate: 0.0,
//                                                 itemSaleRate:
//                                                     p.salesRate ?? 0,
//                                                 itemMRPRate: p.mRPRate ?? 0,
//                                                 itemSGSTPercentage: 0,
//                                                 itemCGSTPercentage: 0,
//                                                 itemIGSTPercentage: 0,
//                                                 itemSGSTAmount: 0,
//                                                 itemCGSTAmount: 0,
//                                                 itemIGSTAmount: 0,
//                                                 purchaseEntryMode: 0,
//                                                 purchaseEntryType: 0,
//                                                 createdUserCode:
//                                                     p.createdUserCode ?? 0,
//                                                 createdDate:
//                                                     "2025-09-24 00:23:30",
//                                                 // createdDate: p.createdDate ??
//                                                 //     DateTime.now()
//                                                 //         .toIso8601String(),
//                                                 updatedUserCode: int.tryParse(
//                                                     userId.value ?? '0'),
//                                                 updatedDate: DateFormat(
//                                                         'yyyy-MM-dd')
//                                                     .format(DateTime.now()),
//                                                 coCode: 0,
//                                                 computerName: 'computername',
//                                                 finYearCode: '',
//                                                 stockRequiredEffect: 0,
//                                                 frieghtChargesAddWithoutTotal:
//                                                     0,
//                                               );

//                                               // Add to itemsList
//                                               itemsList.add(newItem);
//                                               if (_activeRowIndex ==
//                                                   items.length - 1) {
//                                                 items.add(product.Info());
//                                                 controllers.add(
//                                                     ItemRowControllers());
//                                               }

//                                               // Hide sub-table & clear selection
//                                               _showSubTable = false;
//                                               _searchResults.clear();
//                                               _activeRowIndex = null;
//                                               // Print current count
//                                               print(
//                                                   "Current itemsList count: ${itemsList.length}");
//                                             }
//                                           });
//                                         },
//                                         cells: [
//                                           DataCell(Text(
//                                             "${index + 1}",
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                           DataCell(Text(
//                                             p.itemID?.toString() ?? "",
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                           DataCell(Text(
//                                             p.itemName ?? "",
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                           DataCell(Text(
//                                             p.batchNoRequired.toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                           DataCell(Text(
//                                             p.expiryDateFormat ?? "",
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                           DataCell(Text(
//                                             p.hSNCode.toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                           DataCell(Text(
//                                             p.maximumStockQty.toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                           DataCell(Text(
//                                             p.maximumStockQty.toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                           DataCell(Text(
//                                             p.mRPRate.toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                           DataCell(Text(
//                                             p.purchaseRate.toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                           DataCell(Text(
//                                             p.salesRate.toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 12.0,
//                                                 height: 1.0,
//                                                 color: black),
//                                           )),
//                                         ],
//                                       );
//                                     }).toList(),
//                                   )
//                                 : Container(
//                                     padding: const EdgeInsets.all(12),
//                                     alignment: Alignment.center,
//                                     child: const Text(
//                                       "No item found",
//                                       style: TextStyle(
//                                         color: red,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       )
//                     ],
//                   );
//                 }),
//               ),
//             ),
//           ),
//           bottomNavigationBar: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 400),
//                 curve: Curves.easeInOut,
//                 height: _isBottomBarExpanded ? 350 : 60, // adjust max height
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: lightgray,
//                   border: const Border(
//                     top: BorderSide(color: gray, width: 1), // ✅ only top border
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color.fromARGB(50, 0, 0, 0),
//                       blurRadius: 4,
//                       offset: Offset(0, -2), // ✅ shadow above (negative y)
//                     ),
//                   ],
//                 ),

//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const SizedBox(height: 16),
//                       if (_isBottomBarExpanded) ...[
//                         // 👉 Content when expanded
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             GstDataTableWidget(totalAmount: _totalSalesRate),
//                             const SizedBox(width: 16),

//                             // First column
//                             Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 LabeledTextField(
//                                   focusNode: _sgstpreFocus,
//                                   label: "SGST %",
//                                   controller: _sgstpreController,
//                                 ),
//                                 LabeledTextField(
//                                   focusNode: _cgstpreFocus,
//                                   label: "CGST %",
//                                   controller: _cgstpreController,
//                                   readOnly: true,
//                                 ),
//                                 LabeledTextField(
//                                   focusNode: _igstpreFocus,
//                                   label: "IGST %",
//                                   controller: _igstpreController,
//                                   readOnly: true,
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(width: 16),

//                             // Second column
//                             Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 LabeledTextField(
//                                   focusNode: _sgstAmtFocus,
//                                   label: "SGST Amount",
//                                   controller: _sgstAmtController,
//                                   readOnly: true,
//                                 ),
//                                 LabeledTextField(
//                                   focusNode: _cgstAmtFocus,
//                                   label: "CGST Amount",
//                                   controller: _cgstAmtController,
//                                   readOnly: true,
//                                 ),
//                                 LabeledTextField(
//                                   focusNode: _igstAmtFocus,
//                                   label: "IGST Amount",
//                                   controller: _igstAmtController,
//                                   readOnly: true,
//                                 ),
//                                 LabeledTextField(
//                                   focusNode: _totalGstAmtFocus,
//                                   label: "Total GST Amount",
//                                   controller: _totalGstAmtController,
//                                   readOnly: true,
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(width: 16),

//                             // Third column
//                             Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 LabeledTextField(
//                                   focusNode: _subTotalFocus,
//                                   label: "Sub Total Value",
//                                   controller: _subTotalValueController,
//                                   readOnly: true,
//                                 ),
//                                 LabeledTextField(
//                                   focusNode: _gstValueFocus,
//                                   label: "GST Value",
//                                   controller: _gstValueController,
//                                   readOnly: true,
//                                 ),
//                                 LabeledTextField(
//                                   focusNode: _discountFocus,
//                                   label: "Discount",
//                                   controller: _discountController,
//                                   readOnly: true,
//                                 ),
//                                 LabeledTextField(
//                                   focusNode: _roundOFfFocus,
//                                   label: "Round Off",
//                                   controller: _roundOffController,
//                                   readOnly: true,
//                                 ),
//                                 LabeledTextField(
//                                   focusNode: _frightFocus,
//                                   label: "Freight Charges",
//                                   controller: _frightChargesController,
//                                   readOnly: true,
//                                 ),
//                                 LabeledTextField(
//                                   focusNode: _roundOFfFocus,
//                                   label: "Net Amount",
//                                   controller: _netAmountController,
//                                   readOnly: true,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 16),

//                         // Save / Edit / Delete buttons
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: green,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               onPressed: _submit,
//                               child: const Text("Save",
//                                   style: TextStyle(color: white)),
//                             ),
//                             const SizedBox(width: 20),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: primary,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               onPressed: _submit,
//                               child: const Text("Edit",
//                                   style: TextStyle(color: white)),
//                             ),
//                             const SizedBox(width: 20),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: red,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 // Delete logic
//                               },
//                               child: const Text("Delete",
//                                   style: TextStyle(color: white)),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),

//               // Toggle Button
//               Positioned(
//                 right: 50,
//                 top: -30,
//                 child: Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: const BoxDecoration(
//                     color: lightgray,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color.fromARGB(50, 0, 0, 0),
//                         blurRadius: 2,
//                         offset: Offset(1, 1),
//                       ),
//                     ],
//                   ),
//                   child: IconButton(
//                     icon: Icon(
//                       _isBottomBarExpanded
//                           ? Icons.arrow_drop_down
//                           : Icons.arrow_drop_up,
//                       color: primary,
//                       size: 30,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isBottomBarExpanded = !_isBottomBarExpanded;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }

//   void _showEditPopup(BuildContext context, int index) {
//     final controller = controllers[index]; // get row’s controllers

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: white,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           content: SizedBox(
//             width: 600,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "Purchase Entry",
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: black,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     "Product Name: ${controller.itemNameController.text}",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: black,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Left Column - existing fields
//                       Expanded(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             _buildTextField(
//                                 "Item Name", controller.itemNameController),
//                             _buildTextField(
//                                 "Batch No", controller.batchNoController),
//                             _buildTextField(
//                                 "Expiry", controller.expiryController),
//                             _buildTextField(
//                                 "HSN Code", controller.hsnController),
//                             _buildTextField("Qty", controller.qtyController,
//                                 keyboardType: TextInputType.number),
//                             _buildTextField(
//                                 "MRP/Rate", controller.mrpController,
//                                 keyboardType: TextInputType.number),
//                             _buildTextField(
//                                 "Sales Rate", controller.salesRateController,
//                                 keyboardType: TextInputType.number),
//                             _buildTextField("GST %", controller.gstController,
//                                 keyboardType: TextInputType.number),
//                             _buildTextField(
//                                 "GST Value", controller.gstValueController,
//                                 keyboardType: TextInputType.number),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 16),

//                       // Right Column - new controllers
//                       Expanded(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             _buildTextField("Discount %",
//                                 controller.discountPercentageController,
//                                 keyboardType: TextInputType.number),
//                             _buildTextField("Discount Value",
//                                 controller.discountValueController,
//                                 keyboardType: TextInputType.number),
//                             // _buildTextField(
//                             //     "GST %", controller.gstPercentageController,
//                             //     keyboardType: TextInputType.number),
//                             // _buildTextField(
//                             //     "GST Value", controller.gstValueController,
//                             //     keyboardType: TextInputType.number),
//                             _buildTextField("Taxable Value",
//                                 controller.taxableValueController,
//                                 keyboardType: TextInputType.number),
//                             _buildTextField(
//                                 "Net Rate", controller.netRateController,
//                                 keyboardType: TextInputType.number),
//                             _buildTextField(
//                                 "Net Value", controller.netValueController,
//                                 keyboardType: TextInputType.number),
//                             _buildTextField(
//                                 "Remark", controller.remarkController),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _calculateTotalSalesRate();
//                   // No need to manually assign — controllers are already linked to DataTable
//                 });
//                 Navigator.pop(context);
//               },
//               child: const Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller,
//       {TextInputType keyboardType = TextInputType.text}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   void _showAddEditBottomSheet(product.Info? unit) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // almost full screen
//       backgroundColor: white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom, // handle keyboard
//         ),
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height * 0.85,
//           child: AddProductMasterPage(
//             unitInfo: unit,
//             onSaved: (success) {
//               Navigator.pop(context); // close sheet
//               _onSaved(success); // your callback
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }














import 'package:facebilling/core/app_styles.dart';
import 'package:facebilling/core/const.dart';
import 'package:facebilling/core/gst_calcusator.dart';
import 'package:facebilling/data/models/get_serial_no_model.dart' as serialno;
import 'package:facebilling/data/models/product/product_master_list_model.dart';
import 'package:facebilling/data/models/table/ProductRow.dart';
import 'package:facebilling/data/services/supplier_master_service.dart';
import 'package:facebilling/ui/screens/masters/supplier_group_master/add_supplier_group_master_page.dart';
import 'package:facebilling/ui/screens/masters/supplier_master/Add_supplier_master_page.dart';
import 'package:facebilling/ui/widgets/AutoSearchDropdown.dart';
import 'package:facebilling/ui/widgets/BorderLine.dart';
import 'package:facebilling/ui/widgets/DatePickerField.dart';
import 'package:facebilling/ui/widgets/SuggestionTable.dart';
import 'package:facebilling/ui/widgets/TableTextField.dart';
import 'package:facebilling/ui/widgets/Table_Component/item_add_grid_component.dart';
import 'package:facebilling/ui/widgets/Table_Component/models/data_cell_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../core/colors.dart';
import '../../../../data/models/get_all_master_list_model.dart' as master;
//import '../../../../data/models/tax_master/tax_master_list_model.dart'  as tax;
import '../../../../data/models/product/product_master_list_model.dart'
    as product;
import '../../../../data/models/purchase_model/add_purchase_master_model.dart';
import '../../../../data/models/purchase_model/purchase_list_model.dart';
import '../../../../data/models/supplier_master/supplier_master_list_model.dart';
import '../../../../data/services/get_all_master_service.dart';
import '../../../../data/services/get_serial_no_services.dart';
import '../../../../data/services/product_service.dart';
import '../../../../data/services/purchase_master_service.dart';
import '../../../../data/services/tax_master_service.dart'
    show TaxMasterService;
import '../../../widgets/custom_dropdown_text_field.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/gst_calc_table.dart';
import '../../../widgets/label_textfield.dart';
import '../../../widgets/product_drop_down_field.dart';
import '../../../widgets/product_search_field.dart';
import '../../../widgets/search_dropdown.dart';
import '../../../widgets/search_dropdown_field.dart';
import '../../masters/product_master/add_product_master_page.dart';
import 'add_purchase_controller.dart';

class AddPurchaseMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddPurchaseMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddPurchaseMasterPage> createState() => _AddPurchaseMasterPageState();
}

class _AddPurchaseMasterPageState extends State<AddPurchaseMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _keyboardFocusNode = FocusNode();

  Widget suggestionTable = Container();

  int totalItems = 0;
  List<Map<String, dynamic>> savedTableData = [];
  String uom = "PCS";
  int totalQty = 0;
  double totalCost = 0.0;
  double totalvat = 0.00;
  double grassAmt = 0.00;
  double discount = 0.00;
// supplier tax type
  int supplierTaxTypr = 1;

  ///services
  final PurchaseMasterService _service = PurchaseMasterService();
  final GetAllMasterService _getAllMasterService = GetAllMasterService();
  final ProductService _productService = ProductService();
  final GetSerialNoServices _getSerialservice = GetSerialNoServices();
  final SupplierMasterService _supplier = SupplierMasterService();
  product.productListInfo? editingUnit;
  bool refreshList = false;
  int _supplierCode = 1;
  bool _loading = false;
  String? _message;
  bool _getAllLoading = true;
  bool _getSerialNoLoading = true;
  int? _highlightedIndex; // null = nothing highlighted
  final FocusNode _subTableFocus = FocusNode(); // focus for keyboard
  ///sales rate calculation
  double _totalSalesRate = 0.0;
  int? selectedPaymentType = 1;
  int? selectedEntryType = 1;
  int? selectedEntryMode = 1;
  int? selectedTaxType;
  int? selectedGstType;
  serialno.GetSerialNoModel? serialNo;
// Bootom Calculation Variables

  double _subTotal = 0.00;
  double _gstValue = 0.00;
  double _discountValue = 0.00;
  double _freightCharge = 0.00;
  double _roundOffValue = 0.00;
  double totalSalesRate = 0;

  // void _calculateTotalSalesRate() {
  //   double total = 0.0;
  //   for (var item in items) {
  //     // Ensure numeric
  //     final rate = item.salesRate is num
  //         ? item.salesRate!.toDouble()
  //         : double.tryParse(item.salesRate.toString()) ?? 0.0;
  //     total += rate;
  //   }
  //   setState(() {
  //     _totalSalesRate = total;
  //     print("_totalSalesRate: $_totalSalesRate");
  //     _setGSTValues("18%", _totalSalesRate);
  //     _calculateInvoiceFromTotalSalesRate(_totalSalesRate);
  //   });
  // }

  void _setGSTValues(String gstRate, double totalSalesRate) {
    final gstPercent = double.tryParse(gstRate.replaceAll('%', '')) ?? 0;

    // ✅ Percentages
    final sgstPercent = gstPercent / 2;
    final cgstPercent = gstPercent / 2;
    final igstPercent = gstPercent;

    // ✅ Amounts
    final gstAmount = totalSalesRate * gstPercent / 100;
    final sgstAmount = totalSalesRate * sgstPercent / 100;
    final cgstAmount = totalSalesRate * cgstPercent / 100;
    final igstAmount = totalSalesRate * igstPercent / 100;

    // ✅ Set into controllers (percentages)
    _sgstpreController.text = sgstPercent.toStringAsFixed(2);
    _cgstpreController.text = cgstPercent.toStringAsFixed(2);
    _igstpreController.text = igstPercent.toStringAsFixed(2);

    // ✅ (If you have extra controllers for amounts)
    _sgstAmtController.text = sgstAmount.toStringAsFixed(2);
    _cgstAmtController.text = cgstAmount.toStringAsFixed(2);
    _igstAmtController.text = igstAmount.toStringAsFixed(2);

    // ✅ Optional: show total amount including GST
    _totalGstAmtController.text =
        (totalSalesRate + gstAmount).toStringAsFixed(2);
  }

  // void _calculateInvoiceFromTotalSalesRate(double totalSalesRate) {
  //   // Example: define percentages for discount, GST, etc.
  //   const double discountPercent = 10; // 10% discount
  //   const double gstPercent = 18; // 18% GST
  //   const double freightPercent = 2; // 2% freight

  //   // Calculate values based on totalSalesRate
  //   final double subTotal = totalSalesRate;
  //   final double discount = subTotal * (discountPercent / 100);
  //   final double gstValue = (subTotal - discount) * (gstPercent / 100);
  //   final double freight = subTotal * (freightPercent / 100);

  //   // Net amount before rounding
  //   double netAmount = subTotal - discount + gstValue + freight;

  //   // Round off to nearest integer
  //   final double roundOff = (netAmount - netAmount.floor()) >= 0.5
  //       ? (netAmount.ceil() - netAmount)
  //       : (netAmount.floor() - netAmount);
  //   netAmount += roundOff;

  //   // ✅ Update controllers
  //   _subTotalValueController.text = subTotal.toStringAsFixed(2);
  //   _discountController.text = discount.toStringAsFixed(2);
  //   _gstValueController.text = gstValue.toStringAsFixed(2);
  //   _roundOffController.text = roundOff.toStringAsFixed(2);
  //   _frightChargesController.text = freight.toStringAsFixed(2);
  //   _netAmountController.text = netAmount.toStringAsFixed(2);
  // }

  String? error;
  bool _isBottomBarExpanded = false;

  ///model

  master.GetAllMasterListModel? getAllMasterListModel;
  product.ProductMasterListModel? productMasterListModel;
  AddPurchaseMasterModel? addPurchaseMasterModel;
  List<product.productListInfo> _searchResults = [];
  bool _showSubTable = false;
  int? _activeRowIndex; // to know which row we are editing

  late TextEditingController _supplierNameController;
  late TextEditingController _supplierInvoicNoController;
  late TextEditingController _invoiceDateController;
  late TextEditingController _gstTypeController;
  late TextEditingController _invoiceAmtController;
  late TextEditingController _supStateController;
  late TextEditingController _purchaseNoController;
  late TextEditingController _purchaseDateController;
  late TextEditingController _paymentModeController;
  late TextEditingController _basedOnController;
  late TextEditingController _accountNameController;
  late TextEditingController _subTotalValueController;
  late TextEditingController _gstValueController;
  late TextEditingController _discountController;
  late TextEditingController _roundOffController;
  late TextEditingController _frightChargesController;
  late TextEditingController _netAmountController;
  late TextEditingController _sgstpreController;
  late TextEditingController _cgstpreController;
  late TextEditingController _igstpreController;
  late TextEditingController _sgstAmtController;
  late TextEditingController _cgstAmtController;
  late TextEditingController _igstAmtController;
  late TextEditingController _totalGstAmtController;
  late TextEditingController _qtyTotalController;

  // final TextEditingController itemCodeController = TextEditingController();
  // final TextEditingController itemNameController = TextEditingController();

  final TextEditingController batchNoController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController hsnController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController salesRateController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController taxTypeController = TextEditingController();

  final TextEditingController _totalQtyController = TextEditingController();
  final TextEditingController _totalPurchaseRateController =
      TextEditingController();
  final TextEditingController _totalSalesRateController =
      TextEditingController();
  final TextEditingController _totalNetValueController =
      TextEditingController();

  final FocusNode _totalQtyFocus = FocusNode();
  final FocusNode _totalPurchaseRateFocus = FocusNode();
  final FocusNode _totalSalesRateFocus = FocusNode();
  final FocusNode _totalNetValueFocus = FocusNode();

  late TextEditingController _supDueDaysController;
  late TextEditingController _paidAmountController;
  late TextEditingController _cashDiscountValueController;
  late TextEditingController _vehicleNoController;
  late TextEditingController _finYearCodeController;
  late TextEditingController _purchaseEntryTypeController;

  // 🔹 FocusNodes
  final FocusNode _supNameFocus = FocusNode();
  final FocusNode _spurchaseNoFocus = FocusNode();
  final FocusNode _itemNameFocus = FocusNode();
  final FocusNode _invoiceNoFocus = FocusNode();
  final FocusNode _invoiceDateFocus = FocusNode();
  final FocusNode _gstTypeFocus = FocusNode();
  final FocusNode _invoiceAmtFocus = FocusNode();
  final FocusNode _purchaseNoFocus = FocusNode();
  final FocusNode _purchaseDateFocus = FocusNode();
  final FocusNode _paymentModeFocus = FocusNode();
  final FocusNode _basedOnFocus = FocusNode();
  final FocusNode _accountNameFocus = FocusNode();
  late FocusNode _sgstpreFocus;
  late FocusNode _cgstpreFocus;
  late FocusNode _igstpreFocus;
  late FocusNode _sgstAmtFocus;
  late FocusNode _cgstAmtFocus;
  late FocusNode _igstAmtFocus;
  late FocusNode _totalGstAmtFocus;
  late FocusNode _qtyTotalFocus;

  final FocusNode _gstValueFocus = FocusNode();
  final FocusNode _subTotalFocus = FocusNode();
  final FocusNode _discountFocus = FocusNode();
  final FocusNode _roundOFfFocus = FocusNode();
  final FocusNode _frightFocus = FocusNode();
  // List<ProductRow> mainTable = [];
  List<productListInfo> suggestionList = [];
  final TextEditingController searchController = TextEditingController();
  bool showSuggestion = false;
  int? editingRowIndex;
  List<MainTableRow> mainTable = [MainTableRow.empty()];

  @override
  void initState() {
    super.initState();
    mainTable = [MainTableRow.empty()];
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_spurchaseNoFocus);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _keyboardFocusNode.requestFocus();
    });
    _loadList();
    //_itemIdController = TextEditingController(text: widget.unitInfo?.purchaseAccCode.toString() ?? "");

    _supplierNameController =
        TextEditingController(text: widget.unitInfo?.supName ?? "");
    _supplierInvoicNoController =
        TextEditingController(text: widget.unitInfo?.invoiceNo ?? "");
    _invoiceDateController = TextEditingController(
      text: widget.unitInfo?.invoiceDate != null
          ? DateFormat('dd-MM-yyyy')
              .format(DateTime.parse(widget.unitInfo!.invoiceDate!))
          : DateFormat('dd-MM-yyyy').format(DateTime.now()),
    );
    _gstTypeController =
        TextEditingController(text: widget.unitInfo?.taxType.toString() ?? "");
    _invoiceAmtController = TextEditingController(
        text: widget.unitInfo?.iGSTAmount?.toString() ?? "");
    _purchaseNoController =
        TextEditingController(text: widget.unitInfo?.purchaseNo ?? "");
    _supStateController = TextEditingController(text: "");
    _purchaseDateController = TextEditingController(
      text: widget.unitInfo?.purchaseDate?.isNotEmpty == true
          ? widget.unitInfo!.purchaseDate
          : DateFormat('dd-MM-yyyy')
              .format(DateTime.now()), // YYYY-MM-DD format
    );
    _paymentModeController = TextEditingController(
        text: widget.unitInfo?.paymentType.toString() ?? "");
    _basedOnController = TextEditingController(text: "");
    _accountNameController = TextEditingController(text: "");
    _subTotalValueController = TextEditingController(text: "");
    _gstValueController = TextEditingController(text: "");
    _discountController = TextEditingController(text: "");
    _roundOffController = TextEditingController(text: "");
    _frightChargesController = TextEditingController(text: "");
    _netAmountController = TextEditingController(text: "");

    _sgstpreController = TextEditingController(text: '');
    _cgstpreController = TextEditingController(text: '');
    _igstpreController = TextEditingController(text: '');
    _sgstAmtController = TextEditingController(text: '');
    _cgstAmtController = TextEditingController(text: '');
    _igstAmtController = TextEditingController(text: '');
    _totalGstAmtController = TextEditingController(text: '');
    _qtyTotalController = TextEditingController(text: '');
    _supDueDaysController = TextEditingController();
    _paidAmountController = TextEditingController();
    _cashDiscountValueController = TextEditingController();
    _vehicleNoController = TextEditingController();
    _finYearCodeController = TextEditingController();
    _purchaseEntryTypeController = TextEditingController(text: "ENTRY");
    // Initialize focus nodes
    _sgstpreFocus = FocusNode();
    _cgstpreFocus = FocusNode();
    _igstpreFocus = FocusNode();
    _sgstAmtFocus = FocusNode();
    _cgstAmtFocus = FocusNode();
    _igstAmtFocus = FocusNode();
    _totalGstAmtFocus = FocusNode();
    _qtyTotalFocus = FocusNode();
  }

  Future<void> fetchSuggestions(String query, int rowIndex) async {
    if (query.isEmpty) {
      setState(() {
        showSuggestion = false;
        suggestionList = [];
      });
      return;
    }

    try {
      final response = await _productService.getProductServiceSearch(query);
      final data = response.data; // Already parsed ProductMasterListModel

      final filtered = data?.info
              ?.where((p) =>
                  p.itemName?.toLowerCase().contains(query.toLowerCase()) ??
                  false ||
                      p.itemCode?.toLowerCase().contains(query.toLowerCase()) ??
                  false)
              .toList() ??
          [];

      setState(() {
        suggestionList = filtered;
        showSuggestion = true;
        editingRowIndex = rowIndex;
      });
    } catch (e) {
      setState(() {
        suggestionList = [];
        showSuggestion = true;
        editingRowIndex = rowIndex;
      });
    }
  }

  void addItemFromSuggestion(productListInfo item) {
    if (editingRowIndex == null) return;

    setState(() {
      final matchedTax = getAllMasterListModel!.info!.taxMasters!.firstWhere(
        (tax) => tax.taxId == item.gstPercentage,
        orElse: () => master.TaxMasters(taxPercentage: "5"),
      );
      print(item.gstPercentage);
      final uom = getAllMasterListModel!.info!.units!.firstWhere(
        (unit) => unit.unitId == item.itemUnitCode,
        orElse: () => master.Units(unitName: "PCS"),
      );
      mainTable[editingRowIndex!] = MainTableRow(
        itemCode: item.itemCode?.toString() ?? '',
        itemName: item.itemName ?? '',
        hsn: item.hSNCode ?? "",
        subUnitCode: item.itemUnitCode?.toString() ?? '',
        qty: '1',
        salesRate: item.salesRate?.toString() ?? '',
        mrpRate: item.salesRate?.toString() ?? '',
        gstPercentage: item.gstPercentage ?? "5",
        // purchaseRate: "0.00",
        // discountPercentage: "0.00"
      );

      // Always ensure last row is empty
      if (mainTable.isEmpty || mainTable.last.isEmpty) {
        mainTable = [MainTableRow.empty()];
      } else {
        mainTable.add(MainTableRow.empty());
      }
      calculateTotals();
      // Reset suggestion
      showSuggestion = false;
      suggestionList = [];
      editingRowIndex = null;
    });
  }

  // Delete row
  void deleteRow(int index) {
    if (mainTable[index].isEmpty) return;

    setState(() {
      mainTable.removeAt(index);

      if (mainTable.isEmpty) mainTable.add(MainTableRow.empty());
      for (var row in mainTable) {
        calculateRowValues(row);
      }

      // Update totals after deletion
      calculateTotals();
    });
  }

  void calculateRowValues(MainTableRow row) {
    Map<String, double> _results = {};
    print("supplierTaxTypr${row.gstPercentageController.text}");
    final qty = double.tryParse(row.qtyController.text) ?? 0;
    final double originalAmount =
        double.tryParse(row.purchaseRateController.text) ?? 0;
    final double discountPercentage =
        double.tryParse(row.discountPercentageController.text) ?? 0;
    final double gstPercentage =
        double.tryParse(row.gstPercentageController.text) ?? 0;

    final GstCalculator calculator = GstCalculator();
    final calculationResults = calculator.calculate(
      taxType: supplierTaxTypr,
      originalAmount: originalAmount,
      discountPercentage: discountPercentage,
      gstPercentage: gstPercentage,
    );

    setState(() {
      _results = calculationResults;
      row.gstValue = _results['gstAmount'] ?? 0.00;
      row.discountValue = _results['discountAmount'] ?? 0.00;
      row.netRate = _results['netRate'] ?? 0.00;
      row.taxableRate = qty * (_results["beforTaxAmount"] ?? 0.00);
      row.netValue = qty * (_results['netRate'] ?? 0.00);
    });
   
  }

  // void calculateTotals() {
  //   double totalQty = 0;
  //   double totalPurchaseRate = 0;
  //   double totalNetValue = 0.00;
    
  //   _subTotal = 0.00;
  //   _gstValue = 0.00;
  //   _roundOffValue = 0.00;
  //   _discountValue = 0.00;
  //   totalSalesRate = 0.00;
  //   for (var row in mainTable) {
  //     print("sub total - ${row.taxableRate}");
  //     // final qty = double.tryParse(row.qtyController.text) ?? 0;
  //     // final purchaseRate =
  //     //     double.tryParse(row.purchaseRateController.text) ?? 0;
  //     // final discount =
  //     //     double.tryParse(row.discountPercentageController.text) ?? 0;
  //     // final netRate = double.tryParse(row.netRateController.text) ?? 0;

  //     _subTotal += double.parse(row.purchaseRateController.text);
  //     _gstValue += row.gstValue;
  //     _discountValue += row.discountValue;
  //     totalNetValue = row.netValue;
  //     // _roundOffValue
  //   }
  //   final int wholePart = totalSalesRate.floor();
  //   final double fractionalPart =
  //       totalSalesRate - wholePart; // e.g., 999.45 - 999 = 0.45

  //   double roundedTotalNetValue;
  //   if (fractionalPart >= 0.50) {
  //     roundedTotalNetValue = (wholePart + 1).toDouble();
  //   } else {
  //     roundedTotalNetValue = wholePart.toDouble();
  //   }

  //   final double roundOffValue = roundedTotalNetValue - totalNetValue;
  //   totalSalesRate = roundedTotalNetValue;

  //   _subTotalValueController.text = _subTotal.toStringAsFixed(2);
  //   _totalQtyController.text = totalQty.toStringAsFixed(2);
  //   _totalPurchaseRateController.text = totalPurchaseRate.toStringAsFixed(2);
  //   _totalSalesRateController.text = totalSalesRate.toStringAsFixed(2);
  //   _totalNetValueController.text = totalNetValue.toStringAsFixed(2);
  // }
  void calculateTotals() {
    double totalQty = 0.0;
    // double totalPurchaseRateSum = 0.0;
    double totalNetValue = 0.00;
    _subTotal = 0.00;
    _gstValue = 0.00;
    _roundOffValue = 0.00;
    _discountValue = 0.00;
    double finalBillTotal = 0.00;

    for (var row in mainTable) {
      final qty = double.tryParse(row.qtyController.text) ?? 0.0;
      final purchaseRate =
          double.tryParse(row.purchaseRateController.text) ?? 0.0;

      final taxableValue = qty * purchaseRate;

      // 2. Accumulate Totals
      totalQty += qty;
      _subTotal += purchaseRate;
      // _subTotal += taxableValue;
      _gstValue += row.gstValue;
      _discountValue += row.discountValue;

      // 3. FIX: Accumulate Total Net Value
      totalNetValue +=
          row.netValue; // This is the total bill amount *before* rounding
    }

    // The final total to be rounded is totalNetValue
    final double valueToRound = totalNetValue;
    final int wholePart = valueToRound.floor();
    final double fractionalPart = valueToRound - wholePart;

    double roundedTotal;

    // 4. Rounding Logic
    if (fractionalPart >= 0.50) {
      roundedTotal = (wholePart + 1).toDouble();
    } else {
      roundedTotal = wholePart.toDouble();
    }

    // 5. Update Total Sales Rate (Final Bill Total) and Round Off
    _roundOffValue = roundedTotal - totalNetValue;
    finalBillTotal = roundedTotal; // Storing the rounded total
    totalSalesRate =
        finalBillTotal; // Assuming totalSalesRate is the final total

    // 6. Update Controllers
    // Use _subTotal for the taxable subtotal
    _subTotalValueController.text = _subTotal.toStringAsFixed(2);
    _totalQtyController.text = totalQty.toStringAsFixed(2);
    // Using the totalPurchaseRateSum (which is the sum of rates, as the original code seemed to do)
    _totalPurchaseRateController.text = _subTotal.toStringAsFixed(3);
    _totalSalesRateController.text =
        finalBillTotal.toStringAsFixed(2); // The final rounded value
    _totalNetValueController.text =
        totalNetValue.toStringAsFixed(2); // The unrounded Net Value
  }

  String? serialError;

  Future<void> _loadList() async {
    setState(() {
      _getAllLoading = true;
      error = null;
      print("error 5");
      print(error);
    });

    try {
      // 🔹 Load master data
      final response = await _getAllMasterService.getAllMasterService();
      if (response.isSuccess) {
        getAllMasterListModel = response.data!;
      } else {
        print("error 6");
        print(response.error);
        throw Exception(response.error);
      }

      // 🔹 Load product list
      final productResponse = await _productService.getSProductService();
      if (productResponse.isSuccess) {
        productMasterListModel = productResponse.data!;
        items = productMasterListModel!.info!;
        print("items.length");
        print(items.length);
      } else {
        print("error 7");
        print(response.error);
        throw Exception(productResponse.error);
      }

      // 🔹 Load serial no. separately
      await _loadSerialNo();
    } catch (e) {
      setState(() {
        error = e.toString();
        print("error 4");
        print(error);
      });
    } finally {
      setState(() {
        _getAllLoading = false;
      });
    }
  }

  Future<void> _loadSerialNo() async {
    try {
      final serialNoResponse = await _getSerialservice.getSerialNo();

      if (serialNoResponse.isSuccess) {
        final data = serialNoResponse.data;
        final purchaseNextId = data?.info?.purchaseNextId;

        if (data == null || purchaseNextId == null || purchaseNextId.isEmpty) {
          setState(() {
            serialError = "Serial number data is empty or invalid.";
            _purchaseNoController.text =
                "No Purchase No"; // clear text field safely
            print("⚠️ error 1a: $serialError");
          });
          return;
        }

        setState(() {
          serialNo = data;
          _purchaseNoController.text = purchaseNextId;
          serialError = null; // ✅ clear error if success
          print("✅ Serial loaded successfully: $purchaseNextId");
        });
      } else {
        setState(() {
          serialError = serialNoResponse.error ?? "Serial number not found.";
          _purchaseNoController.text = ""; // clear field safely
          print("❌ error 2: $serialError");
        });
      }
    } catch (e, stack) {
      setState(() {
        serialError = "Unexpected error: $e";
        _purchaseNoController.text = ""; // clear safely
        print("💥 error 3: $serialError");
        print(stack);
      });
    }
  }

  void _onSaved(bool success) {
    if (success) {
      setState(() {
        editingUnit = null; // reset after save
        refreshList = true; // trigger reload
      });
    }
  }

  @override
  void dispose() {
    // 🔹 Dispose controllers
    _supplierNameController.dispose();
    _supplierInvoicNoController.dispose();
    _invoiceDateController.dispose();
    _gstTypeController.dispose();
    _invoiceAmtController.dispose();
    _purchaseNoController.dispose();
    _supStateController.dispose();
    _purchaseDateController.dispose();
    _paymentModeController.dispose();
    _basedOnController.dispose();
    _accountNameController.dispose();
    _sgstpreController.dispose();
    _cgstpreController.dispose();
    _igstpreController.dispose();
    _sgstAmtController.dispose();
    _cgstAmtController.dispose();
    _igstAmtController.dispose();
    _totalGstAmtController.dispose();
    _qtyTotalController.dispose();

    // Dispose focus nodes
    _sgstpreFocus.dispose();
    _cgstpreFocus.dispose();
    _igstpreFocus.dispose();
    _sgstAmtFocus.dispose();
    _cgstAmtFocus.dispose();
    _igstAmtFocus.dispose();
    _totalGstAmtFocus.dispose();
    _qtyTotalFocus.dispose();
    // 🔹 Dispose FocusNodes
    _supNameFocus.dispose();
    _itemNameFocus.dispose();
    _invoiceNoFocus.dispose();
    _invoiceDateFocus.dispose();
    _gstTypeFocus.dispose();
    _invoiceAmtFocus.dispose();
    _purchaseNoFocus.dispose();
    _purchaseDateFocus.dispose();
    _paymentModeFocus.dispose();
    _basedOnFocus.dispose();
    _accountNameFocus.dispose();

    super.dispose();
  }

  List<product.productListInfo> items = [
    product.productListInfo(
      itemCode: null, // Item Code
      itemName: '', // Item Name
      batchNoRequired: 0, // Batch Number
      expiryDateFormat: '', // Expiry Date
      hSNCode: '', // HSN Code
      maximumStockQty: 0, // Quantity
      mRPRate: 0, // MRP / Rate
      // netRate: 0,            // Net Rate
      // netValue: 0,           // Net Value
      salesRate: 0, // Sale Rate
      gstPercentage: 0, // GST %
      // finYearCode : "2025-26",
      // gstPercentage: 0,           // GST Value
      // supName: '',           // Supplier Name
      //purchaseAccCode: null, // Purchase Account Code
      // add other fields in your model as needed
    ),
  ];
  List<ItemRowControllers> controllers = [ItemRowControllers()];
  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // default date
      firstDate: DateTime(2000), // earliest date allowed
      lastDate: DateTime(2100), // latest date allowed
    );

    if (pickedDate != null) {
      setState(() {
        _invoiceDateController.text =
            DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  List<Items> itemsList = []; // Empty list
  // will fill from API
  void loadItemsFromApi() async {
    final response = await _productService.getProductServiceSearch("");
    if (response.isSuccess) {
      items = (response.data?.info ?? [])
          .map((e) => product.productListInfo(
                itemCode: e.itemCode!,
                itemName: e.itemName ?? '',
              ))
          .toList();
      setState(() {});
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    // Prepare items from mainTable
    List<Items> itemsList = [];
    for (var row in mainTable) {
      if (row.itemCodeController.text.isEmpty &&
          row.itemNameController.text.isEmpty) continue;

      itemsList.add(
        Items(
          itemCode: row.itemCodeController.text,
          itemName: row.itemNameController.text,
          batchNo: row.batchNoRequired.text,
          expiryDate: row.expiryDateFormat.text,
          itemQuantity: double.tryParse(row.qtyController.text) ?? 0,
          itemPurchaseRate:
              double.tryParse(row.purchaseRateController.text) ?? 0,
          itemMRPRate: double.tryParse(row.mrpRateController.text) ?? 0,
          itemSaleRate: double.tryParse(row.salesRateController.text) ?? 0,
          itemDiscountPercentage:
              double.tryParse(row.discountPercentageController.text) ?? 0,
          itemValue: row.netValue,
          purchaseRateBeforeTax: row.taxableRate,
          itemUnitCode: row.subUnitCode,
          // batchNo: row.batchNoRequired,
          // expiryDate: row.expiryDateFormat,
          gstPercentage: double.tryParse(row.gstPercentageController.text) ?? 0,
          actualPurchaseRate: row.netValue,
          // itemPurchaseRate: row.netRate,
        ),
      );
    }

    if (itemsList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least one item")),
      );
      return;
    }

    // Prepare the request model
    AddPurchaseMasterModel request = AddPurchaseMasterModel(
      purchaseDate: _purchaseDateController.text,
      invoiceNo: _supplierInvoicNoController.text,
      invoiceDate: _invoiceDateController.text,
      paymentType: selectedPaymentType,
      supCode: _supplierCode, // store selected supplier code
      supName: _supplierNameController.text,
      taxType: taxTypeController.text,
      purchaseEntryType: _purchaseEntryTypeController.text,
      purchaseTaxableAmount: _subTotalValueController.text,
      purchaseGstAmount: _totalGstAmtController.text,
      purchaseNetAmount: _netAmountController.text,
      sGSTAmount: _sgstAmtController.text,
      cGSTAmount: _cgstAmtController.text,
      iGSTAmount: _igstAmtController.text,
      roundOffAmount: double.tryParse(_roundOffController.text) ?? 0,
      frieghtChargesAddWithTotal:
          double.tryParse(_frightChargesController.text) ?? 0,
      items: itemsList,
    );

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final response = await _service.addPurchaseMaster(request);

      Navigator.pop(context); // close loading

      if (response.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Purchase saved successfully")),
        );

        // Clear form and table
        _formKey.currentState!.reset();
        mainTable.clear();
        mainTable.add(MainTableRow.empty());
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.error ?? "Failed to save purchase")),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void _handleResponse(bool success, String? error) {
    setState(() {
      _loading = false;
      _message = success ? "Saved successfully!" : error;
    });

    if (success) {
      // Clear all text fields
      _supplierInvoicNoController.clear();
      _purchaseNoController.clear();
      _supStateController.clear();
      _purchaseDateController.clear();
      _invoiceDateController.clear();
      _supplierNameController.clear();
      _gstValueController.clear();
      _netAmountController.clear();
      _subTotalValueController.clear();
      _sgstAmtController.clear();
      _cgstAmtController.clear();
      _igstAmtController.clear();
      _roundOffController.clear();
      _frightChargesController.clear();
      _discountController.clear();
      _cashDiscountValueController.clear();
      _paidAmountController.clear();
      _supDueDaysController.clear();
      _vehicleNoController.clear();
      _finYearCodeController.clear();

      // Clear items list
      itemsList.clear();
      _isBottomBarExpanded = false;

      // Reset dropdowns
      selectedPaymentType = 0;
      selectedEntryType = 0;
      selectedEntryMode = 1;
      selectedTaxType = 0;
      selectedGstType = 0;

      setState(() {}); // Update the UI

      // Notify parent widget if needed
      widget.onSaved(true);
    }
  }

  @override
  void didUpdateWidget(covariant AddPurchaseMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
      //  _itemIdController.text = widget.unitInfo?.purchaseAccCode.toString() ?? "";
      _supplierNameController.text = widget.unitInfo?.purchaseNo ?? "";
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

  void _showAddProductPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent accidental closing
      builder: (BuildContext context) {
        final screenSize = MediaQuery.of(context).size;
        final dialogWidth = screenSize.width * 0.7;
        final dialogHeight = screenSize.height * 0.9;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.15,
            vertical: screenSize.height * 0.2,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: dialogWidth,
              maxHeight: dialogHeight,
            ),
            child: Scaffold(
              backgroundColor: white,
              appBar: AppBar(
                title: const Text("Add Product"),
                backgroundColor: const Color(0xFF0B2046),
                foregroundColor: white,
                centerTitle: true,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close, color: white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              body: AddProductMasterPage(
                onSaved: (bool success) {
                  if (success) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Product added successfully")),
                    );
                    setState(() {
                      // 🔹 Optionally reload your table data
                      // _fetchProducts();
                    });
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_getAllLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text("Error: $error"));

    final isEdit = widget.unitInfo != null;

    return RawKeyboardListener(
      focusNode: _keyboardFocusNode,
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          final isShiftPressed = event.isShiftPressed;
          final keyLabel = event.logicalKey.keyLabel.toLowerCase();

          if (isShiftPressed && keyLabel == 'm') {
            setState(() {
              selectedEntryMode = (selectedEntryMode == 1) ? 2 : 1;
            });

            debugPrint("🟢 Entry Mode changed to: $selectedEntryMode");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Entry Mode switched to: $selectedEntryMode"),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        }
      },

      // ✅ your existing UI starts here
      child: Scaffold(
        backgroundColor: selectedEntryMode == 1 ? white : lightblue,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int columns = 1;
                    if (constraints.maxWidth > 1200) {
                      columns = 5;
                    } else if (constraints.maxWidth > 800) {
                      columns = 4;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            // ===== Supplier Name =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: AutoSuggestion<SupplierInfo>(
                                // focusNode: _supNameFocus,
                                controller: _supplierNameController,
                                labelText: 'Supplier Name',
                                hintText: 'Search by Supplier Name',
                                suggestionsCallback: (pattern) async {
                                  final apiResponse = await _supplier
                                      .getSupplierMasterSearch(pattern);
                                  if (apiResponse.error != null) return [];
                                  return apiResponse.data?.info ?? [];
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(suggestion.supName ?? ""),
                                    subtitle: Text(
                                        'mobile: ${suggestion.supMobileNo ?? ""}'),
                                  );
                                },
                                onSuggestionSelected: (supplier) {
                                  supplierTaxTypr =
                                      int.parse(supplier.taxIsIncluded);
                                  _supplierCode = supplier.supCode;
                                  print(supplier.supGSTType);
                                  if (supplier.supGSTType == 0) {
                                    _gstTypeController.text = "No Tax";
                                  } else if (supplier.supGSTType == 1) {
                                    _gstTypeController.text = "SGST";
                                  } else {
                                    _gstTypeController.text = "IGST";
                                  }

                                  if (supplier.taxIsIncluded == 1) {
                                    taxTypeController.text = "Inincluded";
                                  } else {
                                    taxTypeController.text = "Excluded";
                                  }

                                  final stateMaster = getAllMasterListModel!
                                      .info!.states!
                                      .firstWhere(
                                    (state) =>
                                        state.stateCode ==
                                        supplier.supStateCode,
                                    orElse: () =>
                                        master.States(stateName: "Tamil Nadu"),
                                  );
                                  _supStateController.text =
                                      stateMaster.stateName ?? "Tamil Nadu";
                                  _fieldFocusChange(
                                      context, _supNameFocus, _invoiceNoFocus);
                                },
                                getDisplayString: (supplier) =>
                                    supplier.supName ?? "",
                                addPage: AddSupplierMasterPage(
                                  onSaved: (success) async {
                                    if (success) {
                                      Navigator.pop(context, true);
                                      await _loadList();
                                    }
                                  },
                                ),
                                addTooltip: "Add Supplier",
                              ),
                            ),

                            // ===== Supplier State =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: CustomTextField(
                                title: "Supplier State",
                                hintText: "Supplier State",
                                controller: _supStateController,
                                isEdit: true,
                                focusNode: _spurchaseNoFocus,
                                textInputAction: TextInputAction.done,
                              ),
                            ),

                            // ===== Purchase No =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: CustomTextField(
                                title: "Purchase No",
                                hintText: "Purchase No",
                                controller: _purchaseNoController,
                                isEdit: true,
                                focusNode: _spurchaseNoFocus,
                              ),
                            ),

                            // ===== Supplier Invoice No =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: CustomTextField(
                                title: "Supplier Invoice No",
                                hintText: "Invoice No",
                                controller: _supplierInvoicNoController,
                                isEdit: false,
                                focusNode: _invoiceNoFocus,
                                onEditingComplete: () => _fieldFocusChange(
                                    context, _invoiceNoFocus, _invoiceAmtFocus),
                              ),
                            ),

                            // ===== Supplier GST Type =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: CustomTextField(
                                title: "Supplier GST Type",
                                hintText: "Supplier GST Type",
                                controller: _gstTypeController,
                                isEdit: true,
                                focusNode: _gstTypeFocus,
                              ),
                            ),

                            // ===== Purchase Date =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: GestureDetector(
                                  onTap: () {
                                    _pickDate();
                                  },
                                  child: DatePickerField(
                                      label: "Purchase Date",
                                      controller: _purchaseDateController,
                                      onDateSelected: (date) {
                                        print("Selected date: $date");
                                      })),
                            ),
                            // SizedBox(
                            //   width: constraints.maxWidth / columns - 20,
                            //   child: CustomTextField(
                            //     title: "Purchase Date",
                            //     controller: _purchaseDateController,
                            //     isEdit: true,
                            //     focusNode: _purchaseDateFocus,
                            //   ),
                            // ),

                            // ===== Invoice Date =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: GestureDetector(
                                  onTap: () {
                                    _pickDate();
                                  },
                                  child: DatePickerField(
                                      label: "Invoice Date",
                                      controller: _invoiceDateController,
                                      onDateSelected: (date) {
                                        print("Selected date: $date");
                                      })),
                              // GestureDetector(
                              //   onTap: _pickDate,
                              //   child: CustomTextField(
                              //     title: "Invoice Date",
                              //     controller: _invoiceDateController,
                              //     isEdit: true,
                              //     focusNode: _invoiceDateFocus,
                              //   ),
                              // ),
                            ),

                            // ===== Tax Type =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: CustomTextField(
                                title: "Tax Type",
                                controller: taxTypeController,
                                isEdit: true,
                                focusNode: _invoiceDateFocus,
                              ),
                            ),

                            // ===== Payment Type =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: CustomDropdownField<int>(
                                title: "Payment Type",
                                hintText: "Select Payment Type",
                                items: const [
                                  DropdownMenuItem(
                                      value: 0, child: Text("Credit")),
                                  DropdownMenuItem(
                                      value: 1, child: Text("Cash")),
                                  DropdownMenuItem(
                                      value: 2, child: Text("Cheque")),
                                ],
                                initialValue: selectedPaymentType,
                                onChanged: (val) {
                                  setState(() => selectedPaymentType = val);
                                  print("Selected PaymentType: $val");
                                },
                              ),
                            ),

                            // ===== Invoice Amount =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: CustomTextField(
                                title: "Invoice Amount",
                                hintText: "Invoice Amount",
                                controller: _invoiceAmtController,
                                isEdit: false,
                                focusNode: _invoiceAmtFocus,
                                onEditingComplete: () => _fieldFocusChange(
                                    context, _invoiceAmtFocus, _itemNameFocus),
                              ),
                            ),

                            // ===== Purchase Entry Type =====
                            SizedBox(
                              width: constraints.maxWidth / columns - 20,
                              child: CustomTextField(
                                title: "Purchase Entry Type",
                                hintText: "Purchase Entry Type",
                                controller: _purchaseEntryTypeController,
                                isEdit: true,
                              ),
                            ),

                            SizedBox(
                              // height: 500  ,
                              width: double.infinity,
                              child: Scrollbar(
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        Container(
                                          color: primary,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 4),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                child: Center(
                                                  child: Text(
                                                    'Sl.No',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    'Item Id',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 250,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        'Item Name',
                                                        style:
                                                            tableHeadingStyle,
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          _showAddEditBottomSheet(
                                                              editingUnit);
                                                        },
                                                        icon: const Icon(
                                                            Icons
                                                                .add_shopping_cart,
                                                            color: white),
                                                      )

                                                      // product.productListInfo? editingUnit;
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    'HSN',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    'Batch No',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    'Exp/Date',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 80,
                                                child: Center(
                                                  child: Text(
                                                    'UOM',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 60,
                                                child: Center(
                                                  child: Text(
                                                    'Qty',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 130,
                                                child: Center(
                                                  child: Text(
                                                    'Purchase Rate',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    'MRP',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    'Sales Rate',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: white, thickness: 0.5),
                                              SizedBox(
                                                width: 80,
                                                child: Center(
                                                  child: Text(
                                                    'Discount %',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 60,
                                                child: Center(
                                                  child: Text(
                                                    'GST %',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 120,
                                                child: Center(
                                                  child: Text(
                                                    'GST Value',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 120,
                                                child: Center(
                                                  child: Text(
                                                    'Taxable Value',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 80,
                                                child: Center(
                                                  child: Text(
                                                    'Net Rate',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 80,
                                                child: Center(
                                                  child: Text(
                                                    'Net Value',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                              const BorderLine(
                                                  color: primary,
                                                  thickness: 0.5),
                                              SizedBox(
                                                width: 50,
                                                child: Center(
                                                  child: Text(
                                                    'Action',
                                                    style: tableHeadingStyle,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Column(
                                            children: mainTable
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final i = entry.key;
                                              final row = entry.value;

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        right: BorderSide(
                                                            color: primary,
                                                            width: 0.5),
                                                        left: BorderSide(
                                                            color: primary,
                                                            width: 0.5),
                                                        bottom: BorderSide(
                                                            color: primary,
                                                            width: 0.5),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 55,
                                                          child: Center(
                                                            child: Text(
                                                                '${i + 1}'),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            child:
                                                                TableTextField(
                                                              controller: row
                                                                  .itemCodeController,
                                                              hintText:
                                                                  'Item Code',
                                                              width: 100,
                                                              onChanged: (v) =>
                                                                  fetchSuggestions(
                                                                      v, i),
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 250,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8),
                                                            child:
                                                                TableTextField(
                                                                    focusNode:
                                                                        _itemNameFocus,
                                                                    controller: row
                                                                        .itemNameController,
                                                                    hintText:
                                                                        'Item Name',
                                                                    width: 250,
                                                                    onChanged:
                                                                        (v) {
                                                                      fetchSuggestions(
                                                                          v, i);
                                                                      calculateRowValues(
                                                                          row);
                                                                      calculateTotals();
                                                                      setState(
                                                                          () {});
                                                                    }),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 100,
                                                          child: Center(
                                                            child: Text(
                                                              row.hsn ?? '',
                                                              style:
                                                                  blueTextStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 100,
                                                          child: Center(
                                                            child:
                                                                TableTextField(
                                                              focusNode:
                                                                  _basedOnFocus,
                                                              controller: row
                                                                  .batchNoRequired,
                                                              hintText:
                                                                  'Batch No',
                                                              width: 250,
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 100,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              // 🗓️ Open date picker
                                                              final DateTime?
                                                                  pickedDate =
                                                                  await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        2000),
                                                                lastDate:
                                                                    DateTime(
                                                                        2100),
                                                              );

                                                              if (pickedDate !=
                                                                  null) {
                                                                // ✅ Format selected date
                                                                final formatted =
                                                                    DateFormat(
                                                                            'dd-MM-yyyy')
                                                                        .format(
                                                                            pickedDate);

                                                                setState(() {
                                                                  row.expiryDateFormat =
                                                                      formatted;
                                                                });
                                                              }
                                                            },
                                                            child: Center(
                                                              child: Text(
                                                                (row.expiryDateFormat
                                                                            ?.isNotEmpty ??
                                                                        false)
                                                                    ? row
                                                                        .expiryDateFormat!
                                                                    : DateFormat(
                                                                            'dd-MM-yyyy')
                                                                        .format(
                                                                            DateTime.now()),
                                                                style:
                                                                    const TextStyle(
                                                                  color: black,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 80,
                                                          child: Center(
                                                            child: Text(
                                                                row.subUnitCode ??
                                                                    ''),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 60,
                                                          child: TableTextField(
                                                            textAlign: TextAlign
                                                                .center,
                                                            hintText: 'Qty',
                                                            controller: row
                                                                .qtyController,
                                                            inputType:
                                                                TextInputType
                                                                    .number,
                                                            onChanged: (v) {
                                                              calculateRowValues(
                                                                  row);
                                                              calculateTotals();
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 130,
                                                          child: Center(
                                                            child:
                                                                TableTextField(
                                                              showCurrency:
                                                                  true,
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              hintText:
                                                                  'Purchase Rate',
                                                              controller: row
                                                                  .purchaseRateController,
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged: (v) {
                                                                calculateRowValues(
                                                                    row);
                                                                calculateTotals();
                                                                setState(
                                                                    () {}); // refresh UI
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 100,
                                                          child: Center(
                                                            child:
                                                                TableTextField(
                                                              showCurrency:
                                                                  true,
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              controller: row
                                                                  .mrpRateController,
                                                              hintText: 'MRP',
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged: (v) {
                                                                // trigger amount calculation or add empty row
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 100,
                                                          child: Center(
                                                            child:
                                                                TableTextField(
                                                              showCurrency:
                                                                  true,
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              controller: row
                                                                  .salesRateController,
                                                              hintText:
                                                                  'Sales Rate',
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged: (v) {
                                                                // trigger amount calculation or add empty row
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 80,
                                                          child: Center(
                                                            child:
                                                                TableTextField(
                                                              persentage: true,
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              hintText:
                                                                  'Discount %',
                                                              controller: row
                                                                  .discountPercentageController,
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged: (v) {
                                                                calculateRowValues(
                                                                    row);
                                                                calculateTotals();
                                                                setState(() {});
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 60,
                                                          child: Center(
                                                            child:
                                                                TableTextField(
                                                              persentage: true,
                                                              controller: row
                                                                  .gstPercentageController,
                                                              hintText: 'GST %',
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged: (v) {
                                                                // trigger amount calculation or add empty row
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child: Text(
                                                              row.gstValue
                                                                  .toStringAsFixed(
                                                                      2),
                                                              style:
                                                                  blueTextStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 120,
                                                          child: Center(
                                                            child: Text(
                                                              row.taxableRate
                                                                  .toStringAsFixed(
                                                                      2),
                                                              style:
                                                                  blueTextStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        // Net Rate
                                                        SizedBox(
                                                          width: 80,
                                                          child: Center(
                                                            child: Text(
                                                              row.netRate
                                                                  .toStringAsFixed(
                                                                      2),
                                                              style:
                                                                  blueTextStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        // SizedBox(
                                                        //   width: 80,
                                                        //   child: Center(
                                                        //     child:
                                                        //         TableTextField(
                                                        //             showCurrency:
                                                        //                 true,
                                                        //             textAlign:
                                                        //                 TextAlign
                                                        //                     .right,
                                                        //             hintText:
                                                        //                 'Net Rate',
                                                        //             controller: row
                                                        //                 .netRateController,
                                                        //             inputType:
                                                        //                 TextInputType
                                                        //                     .number,
                                                        //             onChanged:
                                                        //                 (v) {
                                                        //               calculateRowValues(
                                                        //                   row);
                                                        //               calculateTotals();
                                                        //               setState(
                                                        //                   () {});
                                                        //             }),
                                                        //   ),
                                                        // ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        // Net Value
                                                        SizedBox(
                                                          width: 80,
                                                          child: Center(
                                                            child: Text(
                                                              row.netValue
                                                                  .toStringAsFixed(
                                                                      2),
                                                              style:
                                                                  blueTextStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        const BorderLine(
                                                            color: primary,
                                                            thickness: 0.5),
                                                        SizedBox(
                                                          width: 50,
                                                          child: Center(
                                                            child: IconButton(
                                                              icon: const Icon(
                                                                  Icons.delete,
                                                                  color: red),
                                                              onPressed: () =>
                                                                  deleteRow(i),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Suggestion Table for this row
                                                  if (showSuggestion &&
                                                      editingRowIndex == i)
                                                    SuggestionTable(
                                                      suggestions:
                                                          suggestionList,
                                                      onSelect:
                                                          addItemFromSuggestion,
                                                    ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        // Space Scrool bar view
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        // ======= BOTTOM NAVIGATION BAR =======
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: _isBottomBarExpanded ? 350 : 60, // adjust max height
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: lightgray,
                border: const Border(
                  top: BorderSide(color: gray, width: 1), // ✅ only top border
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(50, 0, 0, 0),
                    blurRadius: 4,
                    offset: Offset(0, -2), // ✅ shadow above (negative y)
                  ),
                ],
              ),

              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    if (_isBottomBarExpanded) ...[
                      // 👉 Content when expanded
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GstDataTableWidget(totalAmount: _totalSalesRate),
                          const SizedBox(width: 16),

                          // First column
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LabeledTextField(
                                focusNode: _sgstpreFocus,
                                label: "SGST %",
                                calculateValue: _subTotal,
                              ),
                              LabeledTextField(
                                focusNode: _cgstpreFocus,
                                label: "CGST %",
                                calculateValue: _subTotal,
                                readOnly: true,
                              ),
                              LabeledTextField(
                                focusNode: _igstpreFocus,
                                label: "IGST %",
                                calculateValue: _subTotal,
                                readOnly: true,
                              ),
                            ],
                          ),

                          const SizedBox(width: 16),

                          // Second column
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LabeledTextField(
                                focusNode: _sgstAmtFocus,
                                label: "SGST Amount",
                                calculateValue: _subTotal,
                                readOnly: true,
                              ),
                              LabeledTextField(
                                focusNode: _cgstAmtFocus,
                                label: "CGST Amount",
                                calculateValue: _subTotal,
                                readOnly: true,
                              ),
                              LabeledTextField(
                                focusNode: _igstAmtFocus,
                                label: "IGST Amount",
                                calculateValue: _subTotal,
                                readOnly: true,
                              ),
                              LabeledTextField(
                                focusNode: _totalGstAmtFocus,
                                label: "Total GST Amount",
                                calculateValue: _subTotal,
                                readOnly: true,
                              ),
                            ],
                          ),

                          const SizedBox(width: 16),

                          // Third column
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LabeledTextField(
                                calculateValue: _subTotal,
                                focusNode: _subTotalFocus,
                                label: "Sub Total Value",
                                readOnly: true,
                              ),
                              LabeledTextField(
                                calculateValue: _gstValue,
                                focusNode: _gstValueFocus,
                                label: "GST Value",
                                readOnly: true,
                              ),
                              LabeledTextField(
                                focusNode: _discountFocus,
                                controller: _discountController,
                                label: "Discount",
                                readOnly: false,
                                isTextField: true,
                              ),
                              LabeledTextField(
                                focusNode: _frightFocus,
                                label: "Freight Charges",
                                controller: _frightChargesController,
                                readOnly: true,
                                isTextField: true,
                              ),
                              LabeledTextField(
                                calculateValue: _subTotal,
                                focusNode: _roundOFfFocus,
                                label: "Round Off",
                                readOnly: true,
                              ),
                              LabeledTextField(
                                calculateValue: _subTotal,
                                focusNode: _roundOFfFocus,
                                label: "Net Amount",
                                readOnly: true,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Save / Edit / Delete buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _submit,
                            child: const Text("Save",
                                style: TextStyle(color: white)),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _submit,
                            child: const Text("Edit",
                                style: TextStyle(color: white)),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              // Delete logic
                            },
                            child: const Text("Delete",
                                style: TextStyle(color: white)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),
            Positioned(
              right: 50,
              top: -30,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: lightgray,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 0, 0, 0),
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    _isBottomBarExpanded
                        ? Icons.arrow_drop_down
                        : Icons.arrow_drop_up,
                    color: primary,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _isBottomBarExpanded = !_isBottomBarExpanded;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditPopup(BuildContext context, int index) {
    final controller = controllers[index]; // get row’s controllers

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Purchase Entry",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Product Name: ${controller.itemNameController.text}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column - existing fields
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildTextField(
                                "Item Name", controller.itemNameController),
                            _buildTextField(
                                "Batch No", controller.batchNoController),
                            _buildTextField(
                                "Expiry", controller.expiryController),
                            _buildTextField(
                                "HSN Code", controller.hsnController),
                            _buildTextField("Qty", controller.qtyController,
                                keyboardType: TextInputType.number),
                            _buildTextField(
                                "MRP/Rate", controller.mrpController,
                                keyboardType: TextInputType.number),
                            _buildTextField(
                                "Sales Rate", controller.salesRateController,
                                keyboardType: TextInputType.number),
                            _buildTextField("GST %", controller.gstController,
                                keyboardType: TextInputType.number),
                            _buildTextField(
                                "GST Value", controller.gstValueController,
                                keyboardType: TextInputType.number),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Right Column - new controllers
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildTextField("Discount %",
                                controller.discountPercentageController,
                                keyboardType: TextInputType.number),
                            _buildTextField("Discount Value",
                                controller.discountValueController,
                                keyboardType: TextInputType.number),
                            // _buildTextField(
                            //     "GST %", controller.gstPercentageController,
                            //     keyboardType: TextInputType.number),
                            // _buildTextField(
                            //     "GST Value", controller.gstValueController,
                            //     keyboardType: TextInputType.number),
                            _buildTextField("Taxable Value",
                                controller.taxableValueController,
                                keyboardType: TextInputType.number),
                            _buildTextField(
                                "Net Rate", controller.netRateController,
                                keyboardType: TextInputType.number),
                            _buildTextField(
                                "Net Value", controller.netValueController,
                                keyboardType: TextInputType.number),
                            _buildTextField(
                                "Remark", controller.remarkController),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // _calculateTotalSalesRate();
                  // No need to manually assign — controllers are already linked to DataTable
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _showAddEditBottomSheet(product.productListInfo? unit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // almost full screen
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // handle keyboard
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: AddProductMasterPage(
            unitInfo: unit,
            onSaved: (success) {
              Navigator.pop(context); // close sheet
              _onSaved(success); // your callback
            },
          ),
        ),
      ),
    );
  }
}
