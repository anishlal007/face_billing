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
  int supplierGSTTypr = 1;

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
  double sgst = 0.00;
  double cgst = 0.00;
  double igst = 0.00;
  double total_gst = 0.00;

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
    sgst = 0.00;
    cgst = 0.00;
    igst = 0.00;
    total_gst = 0.00;
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
    if (supplierGSTTypr == 1) {
      sgst = _gstValue / 2;
      cgst = _gstValue / 2;
    } else {
      igst = _gstValue;
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
                                  supplierGSTTypr =
                                      int.parse(supplier.supGSTType);
                                  print(supplier.supGSTType);
                                  if (supplier.supGSTType == "0") {
                                    _gstTypeController.text = "No Tax";
                                  } else if (supplier.supGSTType == "1") {
                                    _gstTypeController.text = "SGST";
                                  } else {
                                    _gstTypeController.text = "IGST";
                                  }

                                  if (supplier.taxIsIncluded == "1") {
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
                                                              isEditable:
                                                                  _supplierNameController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? true
                                                                      : false,
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
                                                                    isEditable: _supplierNameController
                                                                            .text
                                                                            .isNotEmpty
                                                                        ? true
                                                                        : false,
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
                                                              isEditable:
                                                                  _supplierNameController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? true
                                                                      : false,
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
                                                            isEditable:
                                                                _supplierNameController
                                                                        .text
                                                                        .isNotEmpty
                                                                    ? true
                                                                    : false,
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
                                                              isEditable:
                                                                  _supplierNameController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? true
                                                                      : false,
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
                                                              isEditable:
                                                                  _supplierNameController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? true
                                                                      : false,
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
                                                              isEditable:
                                                                  _supplierNameController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? true
                                                                      : false,
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
                                                              isEditable:
                                                                  _supplierNameController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? true
                                                                      : false,
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
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              isEditable:
                                                                  _supplierNameController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? true
                                                                      : false,
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
                                calculateValue: sgst,
                              ),
                              LabeledTextField(
                                focusNode: _cgstpreFocus,
                                label: "CGST %",
                                calculateValue: cgst,
                                readOnly: true,
                              ),
                              LabeledTextField(
                                focusNode: _igstpreFocus,
                                label: "IGST %",
                                calculateValue: igst,
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
                                calculateValue: sgst,
                                readOnly: true,
                              ),
                              LabeledTextField(
                                focusNode: _cgstAmtFocus,
                                label: "CGST Amount",
                                calculateValue: cgst,
                                readOnly: true,
                              ),
                              LabeledTextField(
                                focusNode: _igstAmtFocus,
                                label: "IGST Amount",
                                calculateValue: igst,
                                readOnly: true,
                              ),
                              // LabeledTextField(
                              //   focusNode: _totalGstAmtFocus,
                              //   label: "Total GST Amount",
                              //   calculateValue: _subTotal,
                              //   readOnly: true,
                              // ),
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
