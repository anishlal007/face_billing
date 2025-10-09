import 'package:facebilling/core/colors.dart';
import 'package:facebilling/core/const.dart';
import 'package:facebilling/data/models/get_serial_no_model.dart' as serialno;
import 'package:facebilling/ui/screens/masters/customer_master/add_customer_master_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../data/models/get_all_master_list_model.dart' as master;
//import '../../../../data/models/tax_master/tax_master_list_model.dart'  as tax;
import '../../../../data/models/product/product_master_list_model.dart'
    as product;
import '../../../../data/models/purchase_model/add_purchase_master_model.dart';
import '../../../../data/models/purchase_model/purchase_list_model.dart';
import '../../../../data/models/sales/add_sales_req_model.dart';
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
import '../../entrys/purchase/add_purchase_controller.dart';
import '../../masters/product_master/add_product_master_page.dart';

class AddSalesEntryMasterPage extends StatefulWidget {
  final Info? unitInfo;
  final Function(bool success) onSaved;
  const AddSalesEntryMasterPage({
    super.key,
    this.unitInfo,
    required this.onSaved,
  });

  @override
  State<AddSalesEntryMasterPage> createState() =>
      _AddSalesEntryMasterPageState();
}

class _AddSalesEntryMasterPageState extends State<AddSalesEntryMasterPage> {
  final _formKey = GlobalKey<FormState>();

  ///services
  final PurchaseMasterService _service = PurchaseMasterService();
  final GetAllMasterService _getAllMasterService = GetAllMasterService();
  final ProductService _productService = ProductService();
  final GetSerialNoServices _getSerialservice = GetSerialNoServices();
  product.Info? editingUnit;
  bool refreshList = false;
  bool _activeStatus = true;
  bool _loading = false;
  String? _message;
  bool _getAllLoading = true;
  int? _highlightedIndex; // null = nothing highlighted
  final FocusNode _subTableFocus = FocusNode(); // focus for keyboard
  ///sales rate calculation
  double _totalSalesRate = 0.0;
  int? selectedPaymentType;
  int? selectedEntryType;
  int? selectedEntryMode;
  int? selectedTaxType;
  int? selectedGstType;
  serialno.GetSerialNoModel? serialNo;
  bool _isAltColor = false;
    final FocusNode _focusNode = FocusNode();
  void _handleKey(RawKeyEvent event) {
    // Detect "Ctrl + 1" press (works for both Web & Desktop)
    if (event.isControlPressed &&
        event.logicalKey == LogicalKeyboardKey.digit1) {
      setState(() {
        _isAltColor = !_isAltColor; // toggle background color
      });
    }
  }

  void _calculateTotalSalesRate() {
    double total = 0.0;
    for (var item in items) {
      total += (item.salesRate ?? 0).toDouble();
    }
    setState(() {
      _totalSalesRate = total;
      print("_totalSalesRate");
      print(_totalSalesRate);
// Suppose GST = 18% and Sales Rate = 1000
      _setGSTValues("18%", _totalSalesRate);
      _calculateInvoiceFromTotalSalesRate(_totalSalesRate);
    });
  }

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

  void _calculateInvoiceFromTotalSalesRate(double totalSalesRate) {
    // Example: define percentages for discount, GST, etc.
    const double discountPercent = 10; // 10% discount
    const double gstPercent = 18; // 18% GST
    const double freightPercent = 2; // 2% freight
    // Round off will be calculated automatically to nearest integer

    // Calculate values based on totalSalesRate
    final double subTotal = totalSalesRate;
    final double discount = subTotal * (discountPercent / 100);
    final double gstValue = (subTotal - discount) * (gstPercent / 100);
    final double freight = subTotal * (freightPercent / 100);

    // Net amount before rounding
    double netAmount = subTotal - discount + gstValue + freight;

    // Round off to nearest integer
    final double roundOff = (netAmount - netAmount.floor()) >= 0.5
        ? (netAmount.ceil() - netAmount)
        : (netAmount.floor() - netAmount);
    netAmount += roundOff;

    // ✅ Update controllers
    _subTotalValueController.text = subTotal.toStringAsFixed(2);
    _discountController.text = discount.toStringAsFixed(2);
    _gstValueController.text = gstValue.toStringAsFixed(2);
    _roundOffController.text = roundOff.toStringAsFixed(2);
    _frightChargesController.text = freight.toStringAsFixed(2);
    _netAmountController.text = netAmount.toStringAsFixed(2);
  }

  String? error;
  bool _isBottomBarExpanded = false;

  ///model

  master.GetAllMasterListModel? getAllMasterListModel;
  product.ProductMasterListModel? productMasterListModel;
  AddPurchaseMasterModel? addPurchaseMasterModel;
  List<product.Info> _searchResults = [];
  bool _showSubTable = false;
  int? _activeRowIndex; // to know which row we are editing

  late TextEditingController _supplierNameController;
  late TextEditingController _supplierInvoicNoController;
  late TextEditingController _invoiceDateController;
  late TextEditingController _gstTypeController;
  late TextEditingController _invoiceAmtController;
  late TextEditingController _purchaseNoController;
  late TextEditingController _salesDateController;
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
  late TextEditingController _customerIdController;
  late TextEditingController _addressController;

  // final TextEditingController itemCodeController = TextEditingController();
  // final TextEditingController itemNameController = TextEditingController();

  final TextEditingController batchNoController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController hsnController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController salesRateController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController salesNoController = TextEditingController();
  final TextEditingController salesPersonController = TextEditingController();
  final TextEditingController orderNoController = TextEditingController();

  late TextEditingController _supCodeController;
  late TextEditingController _purchaseTaxableAmountController;
  late TextEditingController _purchaseNetAmountController;
  late TextEditingController _subTotalBeforeDiscountController;
  late TextEditingController _supDueDaysController;
  late TextEditingController _paidAmountController;
  late TextEditingController _purchaseNotesController;
  late TextEditingController _purchaseAccCodeController;
  late TextEditingController _purchaseDiscoutPercentageController;
  late TextEditingController _purchaseDiscountValueController;
  late TextEditingController _cashDiscountPercentageController;
  late TextEditingController _cashDiscountValueController;
  late TextEditingController _frieghtChargesAddWithTotalController;
  late TextEditingController _frieghtChargesAddWithoutTotalController;
  late TextEditingController _createUserCodeController;
  late TextEditingController _computerNameController;
  late TextEditingController _vehicleNoController;
  late TextEditingController _finYearCodeController;
  late TextEditingController _coCodeController;
  late TextEditingController _purchaseEntryTypeController;
  late TextEditingController _purchaseEntryModeController;
  late TextEditingController _taxTypeController;
  late TextEditingController _supGstTypeController;
  late TextEditingController _createDateTimeController;

  // 🔹 FocusNodes
  final FocusNode _supNameFocus = FocusNode();
  final FocusNode _spurchaseNoFocus = FocusNode();
  final FocusNode _itemNameFocus = FocusNode();
  final FocusNode _invoiceNoFocus = FocusNode();
  final FocusNode _invoiceDateFocus = FocusNode();
  final FocusNode _gstTypeFocus = FocusNode();
  final FocusNode _invoiceAmtFocus = FocusNode();
  final FocusNode _purchaseNoFocus = FocusNode();
  final FocusNode _salesDateFocus = FocusNode();
  final FocusNode _paymentModeFocus = FocusNode();
  final FocusNode _basedOnFocus = FocusNode();
  final FocusNode _accountNameFocus = FocusNode();
  final FocusNode _gstValueFocus = FocusNode();
  final FocusNode _subTotalFocus = FocusNode();
  final FocusNode _discountFocus = FocusNode();
  final FocusNode _roundOFfFocus = FocusNode();
  final FocusNode _frightFocus = FocusNode();
  final FocusNode _netAmountFocus = FocusNode();
  final FocusNode _customerNameFocus = FocusNode();
  final FocusNode _customerIdFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _salesNoFocus = FocusNode();
  final FocusNode _salesPersonFocus = FocusNode();
  final FocusNode _orderNoFocus = FocusNode();
  late FocusNode _sgstpreFocus;
  late FocusNode _cgstpreFocus;
  late FocusNode _igstpreFocus;
  late FocusNode _sgstAmtFocus;
  late FocusNode _cgstAmtFocus;
  late FocusNode _igstAmtFocus;
  late FocusNode _totalGstAmtFocus;
  late FocusNode _qtyTotalFocus;

  String? _customerName;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_spurchaseNoFocus);
    });
     WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    _loadList();
    //_itemIdController = TextEditingController(text: widget.unitInfo?.purchaseAccCode.toString() ?? "");

    _supplierNameController =
        TextEditingController(text: widget.unitInfo?.supName ?? "");
    _supplierInvoicNoController =
        TextEditingController(text: widget.unitInfo?.invoiceNo ?? "");
    _invoiceDateController = TextEditingController(
        text: widget.unitInfo?.invoiceDate ?? DateTime.now().toIso8601String());
    _gstTypeController =
        TextEditingController(text: widget.unitInfo?.taxType.toString() ?? "");
    _invoiceAmtController = TextEditingController(
        text: widget.unitInfo?.iGSTAmount?.toString() ?? "");
    _purchaseNoController =
        TextEditingController(text: widget.unitInfo?.purchaseNo ?? "");
    _salesDateController = TextEditingController(
      text: widget.unitInfo?.purchaseDate?.isNotEmpty == true
          ? widget.unitInfo!.purchaseDate
          : DateTime.now().toString().split(' ')[0], // YYYY-MM-DD format
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
    _customerIdController = TextEditingController(text: "");
    _addressController = TextEditingController(text: "");

    _sgstpreController = TextEditingController(text: '');
    _cgstpreController = TextEditingController(text: '');
    _igstpreController = TextEditingController(text: '');
    _sgstAmtController = TextEditingController(text: '');
    _cgstAmtController = TextEditingController(text: '');
    _igstAmtController = TextEditingController(text: '');
    _totalGstAmtController = TextEditingController(text: '');
    _qtyTotalController = TextEditingController(text: '');
    _supCodeController = TextEditingController();
    _purchaseTaxableAmountController = TextEditingController();
    _purchaseNetAmountController = TextEditingController();
    _subTotalBeforeDiscountController = TextEditingController();
    _supDueDaysController = TextEditingController();
    _paidAmountController = TextEditingController();
    _purchaseNotesController = TextEditingController();
    _purchaseAccCodeController = TextEditingController();
    _purchaseDiscoutPercentageController = TextEditingController();
    _purchaseDiscountValueController = TextEditingController();
    _cashDiscountPercentageController = TextEditingController();
    _cashDiscountValueController = TextEditingController();
    _frieghtChargesAddWithTotalController = TextEditingController();
    _frieghtChargesAddWithoutTotalController = TextEditingController();
    _createUserCodeController = TextEditingController();
    _computerNameController = TextEditingController();
    _vehicleNoController = TextEditingController();
    _finYearCodeController = TextEditingController();
    _coCodeController = TextEditingController();
    _purchaseEntryTypeController = TextEditingController();
    _purchaseEntryModeController = TextEditingController();
    _taxTypeController = TextEditingController();
    _supGstTypeController = TextEditingController();
    _createDateTimeController = TextEditingController();
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

  Future<void> _loadList() async {
    final response = await _getAllMasterService.getAllMasterService();
    if (response.isSuccess) {
      setState(() {
        getAllMasterListModel = response.data!;
        _getAllLoading = false;
        error = null;
        print("error");
print(error);
      });
    } else {
      setState(() {
        error = response.error;
        _getAllLoading = false;
      });
    }
    final productResponse = await _productService.getSProductService();
    if (productResponse.isSuccess) {
      setState(() {
        productMasterListModel = productResponse.data!;
        items = productMasterListModel!.info!;
        _getAllLoading = false;
        error = null;
        print("error");
print(error);
      });
    } else {
      setState(() {
        error = response.error;
        _getAllLoading = false;
        print("error");
print(error);
      });
    }
    final serialNoResponse = await _getSerialservice.getSerialNo();
    if (serialNoResponse.isSuccess) {
      setState(() {
        serialNo = serialNoResponse.data!; // ✅ assign full model, not .info
        salesNoController.text = serialNo!.info!.salesNextId!;
        _getAllLoading = false;
        error = null;
        print("error");
print(error);
      });
    } else {
      setState(() {
        error = serialNoResponse.error;
        _getAllLoading = false;
        print("error");
print(error);
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
    _salesDateController.dispose();
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
    _salesDateFocus.dispose();
    _paymentModeFocus.dispose();
    _basedOnFocus.dispose();
    _accountNameFocus.dispose();

    super.dispose();
  }

  List<product.Info> items = [
    product.Info(
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
      // gstPercentage: 0,           // GST Value
      // supName: '',           // Supplier Name
      //purchaseAccCode: null, // Purchase Account Code
      // add other fields in your model as needed
    ),
  ];

  List<ItemRowControllers> controllers = [ItemRowControllers()];
  List<Items> itemsList = []; // Empty list
  // will fill from API
  void loadItemsFromApi() async {
    final response = await _productService.getProductServiceSearch("");
    if (response.isSuccess) {
      items = (response.data?.info ?? [])
          .map((e) => product.Info(
                itemCode: e.itemCode!,
                itemName: e.itemName ?? '',
                // barcode: e.barcode ?? '',
                // uom: 'PCS',
                // rate: e.rate?.toDouble() ?? 0,
                // qty: 0,
                // grossAmt: 0,
                // vatAmt: 0,
                // netAmt: 0,
              ))
          .toList();
      setState(() {});
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
      //       String? userId;
      // String? userName;
      // String? userPassword;
      // int? userType;
      // int? activeStatus;
      final req=AddSalesReqModel(
        
      );
      final request = AddPurchaseMasterModel(
// Basic info
        // purchaseDate: _salesDateController.text.trim(),
        // invoiceNo: _invoiceNoController.text.trim(),
        // invoiceDate: _invoiceDateController.text.trim(),
        // purchaseOrderNo: _purchaseOrderNoController.text.trim(),
        // purchaseOrderDate: _purchaseOrderDateController.text.trim(),
        // supName: _supplierNameController.text.trim(),
        supCode: int.tryParse(_supplierNameController.text) ?? 0,

        // Payment & purchase types
        paymentType: selectedPaymentType, // from dropdown (0,1,2)
        purchaseEntryType: selectedEntryType, // from dropdown (0,1,2)
        purchaseEntryMode: selectedEntryMode, // from dropdown (1,2)
        taxType: selectedTaxType, // from dropdown (0,1)
        supGstType: selectedGstType, // from dropdown (0,1,2)

        // Amounts
        purchaseTaxableAmount: int.tryParse(_gstValueController.text) ?? 0,
        purchaseGstAmount: int.tryParse(_gstValueController.text) ?? 0,
        purchaseNetAmount: int.tryParse(_netAmountController.text) ?? 0,
        subTotalBeforeDiscount:
            int.tryParse(_subTotalValueController.text) ?? 0,
        sGSTAmount: int.tryParse(_sgstAmtController.text) ?? 0,
        cGSTAmount: int.tryParse(_cgstAmtController.text) ?? 0,
        iGSTAmount: int.tryParse(_igstAmtController.text) ?? 0,
        roundOffAmount: double.tryParse(_roundOffController.text) ?? 0.0,
        frieghtChargesAddWithTotal:
            int.tryParse(_frightChargesController.text) ?? 0,

        // Discounts
        purchaseDiscoutPercentage: int.tryParse(_discountController.text) ?? 0,
        purchaseDiscountValue: int.tryParse(_discountController.text) ?? 0,
        cashDiscountPercentage: int.tryParse(_discountController.text) ?? 0,
        cashDiscountValue: int.tryParse(_cashDiscountValueController.text) ?? 0,

        // Other details
        paidAmount: int.tryParse(_paidAmountController.text) ?? 0,
        supDueDays: int.tryParse(_supDueDaysController.text) ?? 0,
        createUserCode: int.tryParse(userId.value!),
        createDateTime: DateTime.now().toIso8601String(),
        computerName: "computerName",
        vehicleNo: _vehicleNoController.text.trim(),
        finYearCode: _finYearCodeController.text.trim(),
        coCode: 0,
        purchaseNotes: "",
        purchaseAccCode: 0,

        // Items list
        items: itemsList, // List<Items> you've populated earlier
      );
// Print the full request as JSON
      print("AddPurchaseMasterModel request:");
      print(request.toJson());
      final response = await _service.addPurchaseMaster(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
      final updated = AddPurchaseMasterModel(
        // Basic info
        // purchaseDate: _salesDateController.text.trim(),
        // invoiceNo: _invoiceNoController.text.trim(),
        // invoiceDate: _invoiceDateController.text.trim(),
        // purchaseOrderNo: _purchaseOrderNoController.text.trim(),
        // purchaseOrderDate: _purchaseOrderDateController.text.trim(),
        // supName: _supplierNameController.text.trim(),
        supCode: int.tryParse(_supplierNameController.text) ?? 0,

        // Payment & purchase types
        paymentType: selectedPaymentType, // from dropdown (0,1,2)
        purchaseEntryType: selectedEntryType, // from dropdown (0,1,2)
        purchaseEntryMode: selectedEntryMode, // from dropdown (1,2)
        taxType: selectedTaxType, // from dropdown (0,1)
        supGstType: selectedGstType, // from dropdown (0,1,2)

        // Amounts
        purchaseTaxableAmount: int.tryParse(_gstValueController.text) ?? 0,
        purchaseGstAmount: int.tryParse(_gstValueController.text) ?? 0,
        purchaseNetAmount: int.tryParse(_netAmountController.text) ?? 0,
        subTotalBeforeDiscount:
            int.tryParse(_subTotalValueController.text) ?? 0,
        sGSTAmount: int.tryParse(_sgstAmtController.text) ?? 0,
        cGSTAmount: int.tryParse(_cgstAmtController.text) ?? 0,
        iGSTAmount: int.tryParse(_igstAmtController.text) ?? 0,
        roundOffAmount: double.tryParse(_roundOffController.text) ?? 0.0,
        frieghtChargesAddWithTotal:
            int.tryParse(_frightChargesController.text) ?? 0,

        // Discounts
        purchaseDiscoutPercentage: int.tryParse(_discountController.text) ?? 0,
        purchaseDiscountValue: int.tryParse(_discountController.text) ?? 0,
        cashDiscountPercentage: int.tryParse(_discountController.text) ?? 0,
        cashDiscountValue: int.tryParse(_cashDiscountValueController.text) ?? 0,

        // Other details
        paidAmount: int.tryParse(_paidAmountController.text) ?? 0,
        supDueDays: int.tryParse(_supDueDaysController.text) ?? 0,
        createUserCode: int.tryParse(userId.value!),
        createDateTime: DateTime.now().toIso8601String(),
        computerName: "computerName",
        vehicleNo: _vehicleNoController.text.trim(),
        finYearCode: _finYearCodeController.text.trim(),
        coCode: 0,
        purchaseNotes: "",
        purchaseAccCode: 0,

        // Items list
        items: itemsList, // List<Items> you've populated earlier
      );
      print("updated");
      print(updated);
      final response = await _service.updatePurchaseMaster(
        widget.unitInfo!.purchaseAccCode!,
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
  void didUpdateWidget(covariant AddSalesEntryMasterPage oldWidget) {
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

  @override
  Widget build(BuildContext context) {
    if (_getAllLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text("Error: $error"));
print("error");
print(error);
    final isEdit = widget.unitInfo != null;

    return RawKeyboardListener(
       onKey: _handleKey,
      focusNode: _focusNode,
      child: Scaffold(
          backgroundColor: _isAltColor ? gray : white,
         // backgroundColor: white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: LayoutBuilder(builder: (context, constraints) {
                  int columns = 1; // default mobile
                  if (constraints.maxWidth > 1200) {
                    columns = 4;
                  } else if (constraints.maxWidth > 800) {
                    columns = 3;
                  }
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth / columns - 20,
                        child: SearchableDropdown<master.Customers>(
                          hintText: "Customer Name",
      
                          items: getAllMasterListModel!.info!.customers!,
                          itemLabel: (group) => group.custName ?? "",
                          onChanged: (group) {
                            if (group != null) {
                              _customerName = group.custName;
                              _customerIdController.text =
                                  group.custCode.toString();
                              print("Selected Code: ${group.custCode}");
                              print("Selected Name: ${group.custName}");
                            }
                          },
                          focusNode: _customerNameFocus,
                          onEditingComplete: () => _fieldFocusChange(
                            context,
                            _customerNameFocus,
                            _customerIdFocus,
                          ),
                          // Add page popup
                          addPage: AddCustomerMasterPage(
                            onSaved: (success) {
                              if (success) {
                                Navigator.pop(context, true);
                              }
                            },
                          ),
                          addTooltip: "Add Customer",
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth / columns - 20,
                        child: CustomTextField(
                          title: "Customer Id",
                          hintText: "Customer Id",
                          controller: _customerIdController,
                          // prefixIcon: Icons.person,
                          isEdit: true,
                          focusNode: _customerIdFocus,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => _fieldFocusChange(
                              context, _customerIdFocus, _addressFocus),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth / columns - 20,
                        child: CustomTextField(
                          title: "Address",
                          hintText: "Address",
                          controller: _addressController,
                          // prefixIcon: Icons.person,
                          isEdit: false,
                          focusNode: _addressFocus,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => _fieldFocusChange(
                              context, _addressFocus, _salesNoFocus),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth / columns - 20,
                        child: CustomTextField(
                          title: "Sales No",
                          hintText: "Sales No",
                          controller: salesNoController,
                          // prefixIcon: Icons.person,
                          isEdit: true,
                          focusNode: _salesNoFocus,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => _fieldFocusChange(
                            context,
                            _salesNoFocus,
                            _salesDateFocus,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth / columns - 20,
                        child: CustomTextField(
                          title: "Sales Date",
                          controller: _salesDateController,
                          prefixIcon: Icons.calendar_month,
                          isEdit: true,
                          focusNode: _salesDateFocus,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => _fieldFocusChange(
                              context, _salesDateFocus, _salesPersonFocus),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth / columns - 20,
                        child: CustomTextField(
                          title: "Sales Person",
                          hintText: "Sales Person",
                          controller: salesPersonController,
                          prefixIcon: Icons.person,
                          isEdit: false,
                          focusNode: _salesPersonFocus,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => _fieldFocusChange(
                            context,
                            _salesPersonFocus,
                            _orderNoFocus,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth / columns - 20,
                        child: CustomTextField(
                          title: "Order No",
                          hintText: "Order No",
                          controller: orderNoController,
                          prefixIcon: Icons.person,
                          isEdit: false,
                          focusNode: _orderNoFocus,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _submit,
                        ),
                      ),
      
                      // const SizedBox(height: 26),
      
                      const SizedBox(
                        height: 20,
                      ),
      
                      SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          showCheckboxColumn: false,
                          border: TableBorder.all(color: primary),
                          columnSpacing: 30,
                          headingRowColor: MaterialStateProperty.all(primary),
                          columns: [
                            const DataColumn(
                                label: Text(
                              "SL No",
                              style: TextStyle(color: white),
                            )),
                            const DataColumn(
                                label: Text(
                              "Item Id",
                              style: TextStyle(color: white),
                            )),
                            DataColumn(
                              label: Row(
                                children: [
                                  const Text("Item Name",
                                      style: TextStyle(color: white)),
                                  const SizedBox(width: 4),
                                  IconButton(
                                    icon: Icon(Icons.add_circle_outline_rounded,
                                        color: white, size: 20),
                                    onPressed: () {
                                      _showAddEditBottomSheet(editingUnit);
      
                                      //_showAddProductPopup(context);
                                    },
                                  ), // NON-INTERACTIVE
                                ],
                              ),
                            ),
      
                            const DataColumn(
                                label: Text(
                              "Batch No",
                              style: TextStyle(color: white),
                            )),
                            const DataColumn(
                                label: Text(
                              "Expiry",
                              style: TextStyle(color: white),
                            )),
                            const DataColumn(
                                label: Text(
                              "UOM",
                              style: TextStyle(color: white),
                            )),
                            const DataColumn(
                                label: Text(
                              "HSN Code",
                              style: TextStyle(color: white),
                            )),
                            const DataColumn(
                                label: Text(
                              "FreeQty",
                              style: TextStyle(color: white),
                            )),
                            const DataColumn(
                                label: Text(
                              "MRP/Rate",
                              style: TextStyle(color: white),
                            )),
                            // DataColumn(label: Text("Net Rate")),
                            // DataColumn(label: Text("Net Value")),
                            const DataColumn(
                                label: Text(
                              "Purchase Rate",
                              style: TextStyle(color: white),
                            )),
                            const DataColumn(
                                label: Text(
                              "Sales Rate",
                              style: TextStyle(color: white),
                            )),
                            //DataColumn(label: Text("GST Value")),
                            const DataColumn(
                                label: Text(
                              "Action",
                              style: TextStyle(color: white),
                            )),
                          ],
                          rows: List.generate(items.length, (index) {
                            final item = items[index];
                            final controller = controllers[index];
                            return DataRow(cells: [
                              DataCell(Text(
                                "${index + 1}",
                                style: const TextStyle(
                                    fontSize: 12.0, height: 1.0, color: black),
                              )),
      
                              // Item Code
                              DataCell(TextFormField(
                                controller: controller.itemCodeController,
                                focusNode: controller.itemCodeFocus,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    fontSize: 12.0, height: 1.0, color: black),
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onChanged: (val) => item.itemID = val,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(controller.itemNameFocus),
                              )),
                              DataCell(
                                TextFormField(
                                  style: const TextStyle(
                                      fontSize: 12.0, height: 1.0, color: black),
                                  focusNode: controller.itemNameFocus,
                                  controller: controller.itemNameController,
                                  decoration: const InputDecoration(
                                    hintText: "Item Name",
                                    border: InputBorder.none,
                                  ),
                                  textInputAction: TextInputAction
                                      .next, // ✅ show "Next" on keyboard
                                  onEditingComplete: () => FocusScope.of(context)
                                      .requestFocus(controller
                                          .batchNoFocus), // ✅ jump to batch
                                  onChanged: (val) async {
                                    if (val.isNotEmpty) {
                                      final response = await _productService
                                          .getProductServiceSearch(val);
                                      if (response.isSuccess) {
                                        setState(() {
                                          _searchResults =
                                              response.data?.info ?? [];
                                          _showSubTable =
                                              _searchResults.isNotEmpty;
                                          _activeRowIndex =
                                              index; // track which row user is editing
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        _searchResults.clear();
                                        _activeRowIndex = null;
                                      });
                                    }
                                  },
                                ),
                              ),
                              // DataCell(TextFormField(
                              //  // onTap: () => _showItemSelection(context),
                              //   initialValue: item.itemName?.toString() ?? '',
                              //   keyboardType: TextInputType.number,
                              //   onChanged: (val) => item.itemCode = int.tryParse(val),
                              // )),
      
                              // Batch No
                              DataCell(TextFormField(
                                style: const TextStyle(
                                    fontSize: 12.0, height: 1.0, color: black),
                                controller: controller.batchNoController,
                                focusNode: controller.batchNoFocus,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onChanged: (val) =>
                                    item.batchNoRequired = int.tryParse(val) ?? 0,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(controller.expiryFocus),
                              )),
      
                              // Expiry
                              DataCell(TextFormField(
                                style: const TextStyle(
                                    fontSize: 12.0, height: 1.0, color: black),
                                controller: controller.expiryController,
                                focusNode: controller.expiryFocus,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onChanged: (val) => item.expiryDateFormat = val,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(controller.hsnFocus),
                              )),
      
                              // HSN Code
                              DataCell(TextFormField(
                                style: const TextStyle(
                                    fontSize: 12.0, height: 1.0, color: black),
                                controller: controller.hsnController,
                                focusNode: controller.hsnFocus,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onChanged: (val) => item.hSNCode = val,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(controller.qtyFocus),
                              )),
      
                              // Qty
                              DataCell(TextFormField(
                                style: const TextStyle(
                                    fontSize: 12.0, height: 1.0, color: black),
                                controller: controller.qtyController,
                                focusNode: controller.qtyFocus,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onChanged: (val) =>
                                    item.maximumStockQty = int.tryParse(val) ?? 0,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(controller.mrpFocus),
                              )),
      
                              // MRP/Rate
                              DataCell(TextFormField(
                                style: const TextStyle(
                                    fontSize: 12.0, height: 1.0, color: black),
                                controller: controller.mrpController,
                                focusNode: controller.mrpFocus,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onChanged: (val) =>
                                    item.mRPRate = int.tryParse(val) ?? 0,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(controller.salesRateFocus),
                              )),
      
                              // Sales Rate
                              DataCell(TextFormField(
                                style: const TextStyle(
                                    fontSize: 12.0, height: 1.0, color: black),
                                controller: controller.salesRateController,
                                focusNode: controller.salesRateFocus,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onChanged: (val) {
                                  item.salesRate = int.tryParse(val) ?? 0;
                                  _calculateTotalSalesRate();
                                },
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(controller.gstFocus),
                              )),
      
                              // GST %
                              DataCell(TextFormField(
                                style: const TextStyle(
                                    fontSize: 12.0, height: 1.0, color: black),
                                controller: controller.gstController,
                                focusNode: controller.gstFocus,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onChanged: (val) =>
                                    item.gstPercentage = int.tryParse(val) ?? 0,
                                textInputAction: TextInputAction.done,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(controller.salesRateFocus),
                              )),
                              // GST Value
                              DataCell(TextFormField(
                                style: const TextStyle(
                                    fontSize: 12.0, height: 1.0, color: black),
                                focusNode: controller.salesRateFocus,
                                controller: controller.salesRateController,
                                decoration: const InputDecoration(
                                  hintText: "",
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (val) =>
                                    item.gstPercentage = int.tryParse(val) ?? 0,
      
                                // 🔹 Jump to next row's itemCode when Enter pressed
                                onEditingComplete: () {
                                  final currentIndex =
                                      index; // ✅ use index from List.generate
                                  if (currentIndex < controllers.length - 1) {
                                    // go to next row's itemCode
                                    FocusScope.of(context).requestFocus(
                                      controllers[currentIndex + 1].itemCodeFocus,
                                    );
                                  } else {
                                    // last row → just unfocus
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              )),
      
                              // Delete
                              DataCell(
                                controller.itemNameController.text.isNotEmpty
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // ✅ Edit icon
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: primary),
                                            onPressed: () {
                                              _showEditPopup(context, index);
                                              // 👉 Your edit logic here
                                              print("Edit row $index");
                                            },
                                          ),
      
                                          // ✅ Delete icon
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: red),
                                            onPressed: () {
                                              setState(() {
                                                if (items.length > 1) {
                                                  // ✅ Delete row at the same index for both lists
                                                  items.removeAt(index);
                                                  controllers.removeAt(index);
                                                } else {
                                                  // ✅ If it's the last row, just reset it instead of deleting
                                                  items[0] = product.Info();
                                                  controllers[0] =
                                                      ItemRowControllers();
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(), // nothing if empty
                              ),
                            ]);
                          }),
                        ),
                      ),
      
                      const SizedBox(
                        height: 0,
                      ),
                      if (!_showSubTable)
                        SizedBox(
                          height: 200,
                        ),
                      if (_showSubTable)
                        SizedBox(
                          height: 800,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: _searchResults.isNotEmpty
                                  ? DataTable(
                                      showCheckboxColumn: false,
                                      border: TableBorder.all(color: lightgray),
                                      headingRowColor:
                                          MaterialStateProperty.all(primary),
                                      columns: const [
                                        DataColumn(
                                            label: Text(
                                          "SL No",
                                          style: TextStyle(color: white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Item Id",
                                          style: TextStyle(color: white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Item Name",
                                          style: TextStyle(color: white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Batch No",
                                          style: TextStyle(color: white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Expiry",
                                          style: TextStyle(color: white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "VOM",
                                          style: TextStyle(color: white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "HSN Code",
                                          style: TextStyle(color: white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "FreeQty",
                                          style: TextStyle(color: white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "MRP/Rate",
                                          style: TextStyle(color: white),
                                        )),
                                        // DataColumn(label: Text("Net Rate")),
                                        // DataColumn(label: Text("Net Value")),
                                        DataColumn(
                                            label: Text(
                                          "Purchase Rate",
                                          style: TextStyle(color: white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          "Sales Rate",
                                          style: TextStyle(color: white),
                                        )),
                                      ],
                                      rows: _searchResults
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index =
                                            entry.key; // <-- gives you the index
                                        final p = entry
                                            .value; // <-- this is your Info object
      
                                        return DataRow(
                                          onSelectChanged: (_) {
                                            setState(() {
                                              if (_activeRowIndex != null) {
                                                // final p = _searchResults[_activeRowIndex!];
                                                final item =
                                                    items[_activeRowIndex!];
                                                final controller =
                                                    controllers[_activeRowIndex!];
                                                item.itemID = p.itemID;
                                                item.itemName = p.itemName ?? '';
                                                item.batchNoRequired =
                                                    p.batchNoRequired ?? 0;
                                                item.expiryDateFormat =
                                                    p.expiryDateFormat ?? '';
                                                item.hSNCode = p.hSNCode ?? '';
                                                item.maximumStockQty =
                                                    p.maximumStockQty ?? 0;
                                                item.mRPRate = p.mRPRate ?? 0;
                                                item.salesRate = p.salesRate ?? 0;
                                                item.gstPercentage =
                                                    p.gstPercentage ?? 0;
      
                                                // Update controllers
                                                controller
                                                        .itemCodeController.text =
                                                    item.itemID?.toString() ?? '';
                                                controller.itemNameController
                                                    .text = item.itemName ?? '';
                                                controller
                                                        .batchNoController.text =
                                                    item.batchNoRequired
                                                        .toString();
                                                controller.expiryController.text =
                                                    item.expiryDateFormat ?? '';
                                                controller.hsnController.text =
                                                    item.hSNCode ?? '';
                                                controller.qtyController.text =
                                                    item.maximumStockQty
                                                        .toString();
                                                controller.mrpController.text =
                                                    item.mRPRate.toString();
                                                controller.salesRateController
                                                        .text =
                                                    item.salesRate.toString();
                                                controller.gstController.text =
                                                    item.gstPercentage.toString();
                                                controller
                                                        .gstValueController.text =
                                                    item.gstPercentage.toString();
                                                _calculateTotalSalesRate();
                                                // Convert Info to Items
                                                final newItem = Items(
                                                  itemCode: p.itemCode,
                                                  itemID: p.itemID ?? '',
                                                  itemName: p.itemName ?? '',
                                                  itemGroupCode:
                                                      p.itemGroupCode ?? 0,
                                                  itemMakeCode:
                                                      p.itemMakeCode ?? 0,
                                                  itemGenericCode:
                                                      p.itemGenericCode ?? 0,
                                                  barCodeId: '',
                                                  batchNo: p.batchNoRequired
                                                          ?.toString() ??
                                                      '',
                                                  mFGDate: '',
                                                  expiryDate:
                                                      p.expiryDateFormat ?? '',
                                                  hsnCode: int.tryParse(
                                                          p.hSNCode ?? '0') ??
                                                      0,
                                                  gstPercentage:
                                                      p.gstPercentage ?? 0,
                                                  itemQuantity:
                                                      p.maximumStockQty ?? 0,
                                                  freeQuantity: 0,
                                                  itemUnitCode:
                                                      p.itemUnitCode ?? 0,
                                                  subQuantity: 0,
                                                  subQtyUnitCode: 0,
                                                  subQtyPurchaseRate: 0,
                                                  itemPurchaseRate:
                                                      p.purchaseRate ?? 0,
                                                  purchaseRateBeforeTax: 0.0,
                                                  itemDiscountPercentage: 0,
                                                  itemDiscountValue: 0,
                                                  itemGstValue: 0,
                                                  itemValue: 0,
                                                  actualPurchaseRate: 0.0,
                                                  itemSaleRate: p.salesRate ?? 0,
                                                  itemMRPRate: p.mRPRate ?? 0,
                                                  itemSGSTPercentage: 0,
                                                  itemCGSTPercentage: 0,
                                                  itemIGSTPercentage: 0,
                                                  itemSGSTAmount: 0,
                                                  itemCGSTAmount: 0,
                                                  itemIGSTAmount: 0,
                                                  purchaseEntryMode: 0,
                                                  purchaseEntryType: 0,
                                                  createdUserCode:
                                                      p.createdUserCode ?? 0,
                                                  createdDate: p.createdDate ??
                                                      DateTime.now()
                                                          .toIso8601String(),
                                                  updatedUserCode: null,
                                                  updatedDate: null,
                                                  coCode: 0,
                                                  computerName: '',
                                                  finYearCode: '',
                                                  stockRequiredEffect: 0,
                                                );
      
                                                // Add to itemsList
                                                itemsList.add(newItem);
                                                if (_activeRowIndex ==
                                                    items.length - 1) {
                                                  items.add(product.Info());
                                                  controllers
                                                      .add(ItemRowControllers());
                                                }
      
                                                // Hide sub-table & clear selection
                                                _showSubTable = false;
                                                _searchResults.clear();
                                                _activeRowIndex = null;
                                                // Print current count
                                                print(
                                                    "Current itemsList count: ${itemsList.length}");
                                              }
                                            });
                                          },
                                          cells: [
                                            DataCell(Text(
                                              "${index + 1}",
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                            DataCell(Text(
                                              p.itemID?.toString() ?? "",
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                            DataCell(Text(
                                              p.itemName ?? "",
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                            DataCell(Text(
                                              p.batchNoRequired.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                            DataCell(Text(
                                              p.expiryDateFormat ?? "",
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                            DataCell(Text(
                                              p.hSNCode.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                            DataCell(Text(
                                              p.maximumStockQty.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                            DataCell(Text(
                                              p.maximumStockQty.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                            DataCell(Text(
                                              p.mRPRate.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                            DataCell(Text(
                                              p.purchaseRate.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                            DataCell(Text(
                                              p.salesRate.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  height: 1.0,
                                                  color: black),
                                            )),
                                          ],
                                        );
                                      }).toList(),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.all(12),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "No item found",
                                        style: TextStyle(
                                          color: red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        )
                    ],
                  );
                }),
              ),
            ),
          ),
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
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      if (_isBottomBarExpanded) ...[
                        // 👉 Content when expanded
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  controller: _sgstpreController,
                                ),
                                LabeledTextField(
                                  focusNode: _cgstpreFocus,
                                  label: "CGST %",
                                  controller: _cgstpreController,
                                  readOnly: true,
                                ),
                                LabeledTextField(
                                  focusNode: _igstpreFocus,
                                  label: "IGST %",
                                  controller: _igstpreController,
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
                                  controller: _sgstAmtController,
                                  readOnly: true,
                                ),
                                LabeledTextField(
                                  focusNode: _cgstAmtFocus,
                                  label: "CGST Amount",
                                  controller: _cgstAmtController,
                                  readOnly: true,
                                ),
                                LabeledTextField(
                                  focusNode: _igstAmtFocus,
                                  label: "IGST Amount",
                                  controller: _igstAmtController,
                                  readOnly: true,
                                ),
                                LabeledTextField(
                                  focusNode: _totalGstAmtFocus,
                                  label: "Total GST Amount",
                                  controller: _totalGstAmtController,
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
                                  focusNode: _subTotalFocus,
                                  label: "Sub Total Value",
                                  controller: _subTotalValueController,
                                  readOnly: true,
                                ),
                                LabeledTextField(
                                  focusNode: _gstValueFocus,
                                  label: "GST Value",
                                  controller: _gstValueController,
                                  readOnly: true,
                                ),
                                LabeledTextField(
                                  focusNode: _discountFocus,
                                  label: "Discount",
                                  controller: _discountController,
                                  readOnly: true,
                                ),
                                LabeledTextField(
                                  focusNode: _roundOFfFocus,
                                  label: "Round Off",
                                  controller: _roundOffController,
                                  readOnly: true,
                                ),
                                LabeledTextField(
                                  focusNode: _frightFocus,
                                  label: "Freight Charges",
                                  controller: _frightChargesController,
                                  readOnly: true,
                                ),
                                LabeledTextField(
                                  focusNode: _roundOFfFocus,
                                  label: "Net Amount",
                                  controller: _netAmountController,
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
      
              // Toggle Button
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
          )),
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
                            _buildTextField(
                                "GST %", controller.gstPercentageController,
                                keyboardType: TextInputType.number),
                            _buildTextField(
                                "GST Value", controller.gstValueController,
                                keyboardType: TextInputType.number),
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
                  _calculateTotalSalesRate();
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

  void _showAddEditBottomSheet(product.Info? unit) {
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
