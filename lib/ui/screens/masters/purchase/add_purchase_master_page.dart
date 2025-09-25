import 'package:facebilling/core/const.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/get_all_master_list_model.dart' as master;
//import '../../../../data/models/tax_master/tax_master_list_model.dart'  as tax;
import '../../../../data/models/product/add_product_request.dart';
import '../../../../data/models/product/product_master_list_model.dart'as product;
import '../../../../data/models/purchase_model/add_purchase_master_model.dart';
import '../../../../data/models/purchase_model/purchase_list_model.dart';
import '../../../../data/services/get_all_master_service.dart';
import '../../../../data/services/product_service.dart';
import '../../../../data/services/purchase_master_service.dart';
import '../../../../data/services/tax_master_service.dart' show TaxMasterService;
import '../../../widgets/custom_dropdown_text_field.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/gst_calc_table.dart';
import '../../../widgets/label_textfield.dart';
import '../../../widgets/product_drop_down_field.dart';
import '../../../widgets/product_search_field.dart';
import '../../../widgets/search_dropdown_field.dart';
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
  ///services
  final PurchaseMasterService _service = PurchaseMasterService();
  final GetAllMasterService _getAllMasterService = GetAllMasterService();
  final ProductService _productService = ProductService();

  bool _activeStatus = true;
  bool _loading = false;
  String? _message;
    bool _getAllLoading = true;

  String? error;
///model

master. GetAllMasterListModel?getAllMasterListModel;
product. ProductMasterListModel?productMasterListModel;
List<product.Info> _searchResults = [];
bool _showSubTable = false;
int? _activeRowIndex; // to know which row we are editing
 
  late TextEditingController _supplierNameController;
  late TextEditingController _supplierInvoicNoController;
  late TextEditingController _invoiceDateController;
  late TextEditingController _gstTypeController;
  late TextEditingController _invoiceAmtController;
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



final TextEditingController itemCodeController = TextEditingController();
final TextEditingController itemNameController = TextEditingController();

  final TextEditingController batchNoController= TextEditingController();
  final TextEditingController expiryController= TextEditingController();
  final TextEditingController hsnController= TextEditingController();
  final TextEditingController qtyController= TextEditingController();
  final TextEditingController mrpController= TextEditingController();
  final TextEditingController salesRateController= TextEditingController();
  final TextEditingController gstController= TextEditingController();

  // 🔹 FocusNodes
 final FocusNode _supNameFocus = FocusNode();
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
  final FocusNode _gstValueFocus = FocusNode();
  final FocusNode _subTotalFocus = FocusNode();
  final FocusNode _discountFocus = FocusNode();
  final FocusNode _roundOFfFocus = FocusNode();
  final FocusNode _frightFocus = FocusNode();
  final FocusNode _netAmountFocus = FocusNode();
    late FocusNode _sgstpreFocus;
  late FocusNode _cgstpreFocus;
  late FocusNode _igstpreFocus;
  late FocusNode _sgstAmtFocus;
  late FocusNode _cgstAmtFocus;
  late FocusNode _igstAmtFocus;
  late FocusNode _totalGstAmtFocus;
  late FocusNode _qtyTotalFocus;
  @override
  void initState() {
    super.initState();
    _loadList();
    //_itemIdController = TextEditingController(text: widget.unitInfo?.purchaseAccCode.toString() ?? "");
  _supplierNameController = TextEditingController(text: widget.unitInfo?.supName ?? "");
    _supplierInvoicNoController = TextEditingController(text: widget.unitInfo?.invoiceNo ?? "");
    _invoiceDateController = TextEditingController(text: widget.unitInfo?.invoiceDate ??  DateTime.now().toIso8601String());
    _gstTypeController = TextEditingController(text: widget.unitInfo?.taxType.toString() ?? "");
    _invoiceAmtController = TextEditingController(text: widget.unitInfo?.iGSTAmount?.toString() ?? "");
    _purchaseNoController = TextEditingController(text: widget.unitInfo?.purchaseNo ?? "");
    _purchaseDateController = TextEditingController(text: widget.unitInfo?.purchaseDate ?? "");
    _paymentModeController = TextEditingController(text: widget.unitInfo?.paymentType.toString() ?? "");
    _basedOnController = TextEditingController(text:  "");
    _accountNameController = TextEditingController(text:  "");
    _subTotalValueController = TextEditingController(text:  "");
    _gstValueController = TextEditingController(text:  "");
    _discountController = TextEditingController(text:  "");
    _roundOffController = TextEditingController(text:  "");
    _frightChargesController = TextEditingController(text:  "");
    _netAmountController = TextEditingController(text:  "");

    _sgstpreController = TextEditingController(text: '');
    _cgstpreController = TextEditingController(text: '');
    _igstpreController = TextEditingController(text: '');
    _sgstAmtController = TextEditingController(text: '');
    _cgstAmtController = TextEditingController(text: '');
    _igstAmtController = TextEditingController(text: '');
    _totalGstAmtController = TextEditingController(text: '');
    _qtyTotalController = TextEditingController(text: '');

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
      items=productMasterListModel!.info!;
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
    // 🔹 Dispose controllers
    _supplierNameController.dispose();
    _supplierInvoicNoController.dispose();
    _invoiceDateController.dispose();
    _gstTypeController.dispose();
    _invoiceAmtController.dispose();
    _purchaseNoController.dispose();
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

List<product.Info> items = [
  product.Info(
    itemCode: null,       // Item Code
    itemName: '',          // Item Name
    batchNoRequired: 0,           // Batch Number
    expiryDateFormat: '',            // Expiry Date
    hSNCode: '',           // HSN Code
    maximumStockQty: 0,                // Quantity
    mRPRate: 0,            // MRP / Rate
    // netRate: 0,            // Net Rate
    // netValue: 0,           // Net Value
    salesRate: 0,           // Sale Rate
    gstPercentage: 0,         // GST %
  // gstPercentage: 0,           // GST Value
   // supName: '',           // Supplier Name
    //purchaseAccCode: null, // Purchase Account Code
    // add other fields in your model as needed
  ),
];

List<ItemRowControllers> controllers = [
  ItemRowControllers()
];
 // will fill from API
void loadItemsFromApi() async {
  final response = await _productService.getProductServiceSearch("");
  if (response.isSuccess) {
    items = (response.data?.info ?? []).map((e) => product.Info(
      itemCode: e.itemCode!,
      itemName: e.itemName ?? '',
      // barcode: e.barcode ?? '',
      // uom: 'PCS',
      // rate: e.rate?.toDouble() ?? 0,
      // qty: 0,
      // grossAmt: 0,
      // vatAmt: 0,
      // netAmt: 0,
    )).toList();
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
 final request = AddPurchaseMasterModel(
  purchaseOrderNo: _supplierNameController.text.trim(),
    // current timestamp
 // custActiveStatus: _activeStatus ? 1 : 0,
);
print("request");
print(request);
      final response = await _service.addPurchaseMaster(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
 final updated = AddPurchaseMasterModel(
  purchaseOrderNo: _supplierNameController.text.trim(),
    // current timestamp
 // custActiveStatus: _activeStatus ? 1 : 0,
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
  void didUpdateWidget(covariant AddPurchaseMasterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitInfo != oldWidget.unitInfo) {
    //  _itemIdController.text = widget.unitInfo?.purchaseAccCode.toString() ?? "";
      _supplierNameController.text = widget.unitInfo?.purchaseNo ?? "";
      // _createdUserController.text =
      //     widget.countryInfo?.createdUserCode?.toString() ?? "1001";
     // _activeStatus = (widget.unitInfo?.custActiveStatus ?? 1) == 1;
    }
  }

  @override
  Widget build(BuildContext context) {
        if (_getAllLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text("Error: $error"));

    final isEdit = widget.unitInfo != null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: 
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            //  crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                
               SearchDropdownField<product.Info>(
        fetchItems: (q) async {
      final response = await _productService.getProductServiceSearch(q);
      if (response.isSuccess) {
        return (response.data?.info ?? []).whereType<product.Info>().toList();
      }
      return [];
        },
        displayString: (unit) => unit.itemName ?? "",
        onSelected: (country) {
      setState(() {
        //_supplierNameController.text = country.supName ?? "";
      });
      widget.onSaved(false);
        },
      ),
                // const SizedBox(height: 26),
          Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    CustomDropdownField<int>(
        title: "Supplier Name",
        hintText: "Choose a Supplier Name",
        items: getAllMasterListModel!.info!.suppliers!
        .map((e) => DropdownMenuItem<int>(
              value: e.supCode!,
              child: Text("${e.supName}"),
            ))
        .toList(),
       // initialValue: _taxCode, // ✅ use int value here
        onChanged: (value) {
      setState(() {
        //_taxCode = value;  // uhttps://dart.dev/diagnostics/cast_to_non_typepdate dropdown selection
        _supplierNameController.text = value.toString(); // update text controller if needed
      });
      
      final selected = getAllMasterListModel!.info!.suppliers!
          ?.firstWhere((c) => c.supCode == value, orElse: () => master.Suppliers());
      
      print("Selected: ${selected?.supCode}");
      print("TAX Code: ${selected?.supName}");
        },
        isValidate: true,
        validator: (value) => value == null ? "Please select a GST" : null,
      ),
       
                   
                   CustomTextField(
                  title: "Supplier Invoice No",
                  controller: _supplierInvoicNoController,
                  prefixIcon: Icons.person,
                  isEdit: false,
                  focusNode: _supNameFocus,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                  
                   CustomTextField(
                  title: "Invoice Date",
                  controller: _invoiceDateController,
                  prefixIcon: Icons.person,
                  isEdit: true,
                  focusNode: _invoiceDateFocus,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                   CustomTextField(
                  title: "GST Type",
                  controller: _gstTypeController,
                  prefixIcon: Icons.person,
                  isEdit: false,
                  focusNode: _gstTypeFocus,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                   CustomTextField(
                  title: "Invoice Amount",
                  controller: _invoiceAmtController,
                  prefixIcon: Icons.person,
                  isEdit: false,
                  focusNode: _invoiceAmtFocus,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                   CustomTextField(
                  title: "Purchase No",
                  controller: _purchaseNoController,
                  prefixIcon: Icons.person,
                  isEdit: false,
                  focusNode: _purchaseNoFocus,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                   CustomTextField(
                  title: "Purchase Date",
                  controller: _purchaseDateController,
                  prefixIcon: Icons.person,
                  isEdit: true,
                  focusNode: _purchaseDateFocus,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                   CustomTextField(
                  title: "Payment Mode",
                  controller: _paymentModeController,
                  prefixIcon: Icons.person,
                  isEdit: false,
                  focusNode: _paymentModeFocus,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                   CustomTextField(
                  title: "Based On",
                  controller: _basedOnController,
                  prefixIcon: Icons.person,
                  isEdit: false,
                  focusNode: _basedOnFocus,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                   CustomTextField(
                  title: "Amount Name",
                  controller: _accountNameController,
                  prefixIcon: Icons.person,
                  isEdit: false,
                  focusNode: _accountNameFocus,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submit,
                ),
                  
                  ],
                ),
                const SizedBox(height: 20,),
        //  SingleChildScrollView(
          
        //         scrollDirection: Axis.horizontal,
        //         child: DataTable(
        //           border: TableBorder.all(color: Colors.grey.shade300),
        //           headingRowColor:
        //               MaterialStateProperty.all(Colors.blue.shade50),
        //           columns: const [
        //             DataColumn(label: Text("SL No")),
        //             DataColumn(label: Text("Item Code")),
        //             DataColumn(label: Text("Barcode No")),
        //             DataColumn(label: Text("Item Name")),
        //             DataColumn(label: Text("UOM")),
        //             DataColumn(label: Text("QTY")),
        //             DataColumn(label: Text("Rate")),
        //             DataColumn(label: Text("Gross Amt")),
        //             DataColumn(label: Text("VAT Amt")),
        //             DataColumn(label: Text("Net Amt")),
        //             DataColumn(label: Text("Action")),
        //           ],
        //           rows: [
        //             DataRow(cells: [
        //               const DataCell(Text("1")),
        //               DataCell(TextFormField()),
        //               DataCell(TextFormField()),
        //               DataCell(TextFormField()),
        //               DataCell(DropdownButton<String>(
        //                 value: "PCS",
        //                 items: const [
        //                   DropdownMenuItem(value: "PCS", child: Text("PCS")),
        //                   DropdownMenuItem(value: "KG", child: Text("KG")),
        //                 ],
        //                 onChanged: (_) {},
        //               )),
        //               DataCell(TextFormField()),
        //               DataCell(TextFormField()),
        //               DataCell(TextFormField()),
        //               DataCell(TextFormField()),
        //               DataCell(TextFormField()),
        //               DataCell(IconButton(
        //                 icon: const Icon(Icons.delete, color: Colors.red),
        //                 onPressed: () {},
        //               )),
        //             ]),
        //           ],
        //         ),
        //       ),
//          Sl.No
// Item Id
// Item Name
// Back.No
// Exp.Date
// HSN Code
// VOM
// Qty
// FreeQty
// Purchase Rate
// MRP Rate
         SingleChildScrollView(
          scrollDirection: Axis.horizontal,
           child: SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child: 
             DataTable(
              showCheckboxColumn: false,
            border: TableBorder.all(color: Colors.grey.shade300),
            headingRowColor: MaterialStateProperty.all(Colors.blue),
            columns: const [
              DataColumn(label: Text("SL No")),
              DataColumn(label: Text("Item Id")),
              DataColumn(label: Text("Item Name")),
              DataColumn(label: Text("Back No")),
              DataColumn(label: Text("Expiry")),
              DataColumn(label: Text("VOM")),
              DataColumn(label: Text("HSN Code")),
              DataColumn(label: Text("FreeQty")),
              DataColumn(label: Text("MRP/Rate")),
              // DataColumn(label: Text("Net Rate")),
              // DataColumn(label: Text("Net Value")),
              DataColumn(label: Text("Purchase Rate")),
              DataColumn(label: Text("Sales Rate")),
              //DataColumn(label: Text("GST Value")),
              DataColumn(label: Text("Action")),
            ],
            rows: List.generate(items.length, (index) {
              final item = items[index];
               final controller = controllers[index];
              return DataRow(cells: [
                DataCell(Text("${index + 1}")),
           
                // Item Code
                DataCell(TextFormField(
                 // onTap: () => _showItemSelection(context),
                  initialValue: item.itemCode?.toString() ?? '',
                  keyboardType: TextInputType.number,
                  onChanged: (val) => item.itemCode = int.tryParse(val),
                )),
                DataCell(
           TextFormField(
             controller: controller.itemNameController,
             decoration: InputDecoration(
               hintText: "",
             ),
             onChanged: (val) async {
               if (val.isNotEmpty) {
          final response = await _productService.getProductServiceSearch(val);
          if (response.isSuccess) {
            setState(() {
              _searchResults = response.data?.info ?? [];
              _showSubTable = _searchResults.isNotEmpty;
              _activeRowIndex = index; // track which row user is editing
            });
          }
               } else {
          setState(() {
            _searchResults.clear();
            _showSubTable = false;
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
                  controller:controller.batchNoController ,
                 // initialValue: item.batchNoRequired.toString(),
                  onChanged: (val) => item.batchNoRequired = int.parse(val),
                )),
           
                // Expiry
                DataCell(TextFormField(
                  controller:controller.expiryController ,
                  ///initialValue: item.expiryDateFormat,
                  onChanged: (val) => item.expiryDateFormat = val,
                )),
           
                // HSN Code
                DataCell(TextFormField(
                 controller:controller.hsnController ,
                  onChanged: (val) => item.hSNCode = val,
                )),
           
                // Qty
                DataCell(TextFormField(
                 controller:controller.qtyController ,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => item.maximumStockQty = int.tryParse(val) ?? 0,
                )),
           
                // MRP/Rate
                DataCell(TextFormField(
               controller:controller.mrpController ,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => item.mRPRate = int.tryParse(val) ?? 0,
                )),
           
                // Net Rate
                // DataCell(TextFormField(
                //   keyboardType: TextInputType.number,
                //   onChanged: (val) => item.netRate = double.tryParse(val) ?? 0,
                // )),
           
                // // Net Value
                // DataCell(Text(item.netValue.toStringAsFixed(2))),
           
                // Sale Rate
                DataCell(TextFormField(
                  controller:controller.salesRateController ,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => item.salesRate = int.tryParse(val) ?? 0,
                )),
           
                // GST %
                DataCell(TextFormField(
                 controller:controller.gstController ,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => item.gstPercentage = int.tryParse(val) ?? 0,
                )),
           
                // GST Value
                DataCell(TextFormField(
                 controller:controller.gstController ,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => item.gstPercentage = int.tryParse(val) ?? 0,
                )),
           
                // Delete
                DataCell(IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      items.removeAt(index);
                      if (items.isEmpty) items.add(product.Info());
                    });
                  },
                )),
              ]);
            }),
             ),
           ),
         ),
      
      const SizedBox(height: 20,),
       if (!_showSubTable)
       SizedBox(height: 200,),
      if (_showSubTable)
  SizedBox(
    height: 800,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          showCheckboxColumn: false,
          border: TableBorder.all(color: Colors.grey.shade300),
          headingRowColor: MaterialStateProperty.all(Colors.blue),
          columns: const [
           DataColumn(label: Text("SL No")),
              DataColumn(label: Text("Item Id")),
              DataColumn(label: Text("Item Name")),
              DataColumn(label: Text("Back No")),
              DataColumn(label: Text("Expiry")),
              DataColumn(label: Text("VOM")),
              DataColumn(label: Text("HSN Code")),
              DataColumn(label: Text("FreeQty")),
              DataColumn(label: Text("MRP/Rate")),
              // DataColumn(label: Text("Net Rate")),
              // DataColumn(label: Text("Net Value")),
              DataColumn(label: Text("Purchase Rate")),
              DataColumn(label: Text("Sales Rate")),
          ],
        rows: _searchResults.asMap().entries.map((entry) {
  final index = entry.key;   // <-- gives you the index
  final p = entry.value;     // <-- this is your Info object

  return DataRow(
    onSelectChanged: (_) {
      setState(() {
        if (_activeRowIndex != null) {
          final item = items[_activeRowIndex!];
          final controller = controllers[_activeRowIndex!];

          // update model
          item.itemCode        = p.itemCode;
          item.itemName        = p.itemName ?? '';
          item.batchNoRequired = p.batchNoRequired ?? 0;
          item.expiryDateFormat= p.expiryDateFormat ?? '';
          item.hSNCode         = p.hSNCode ?? '';
          item.maximumStockQty = p.maximumStockQty ?? 0;
          item.mRPRate         = p.mRPRate ?? 0;
          item.salesRate       = p.salesRate ?? 0;
          item.gstPercentage   = p.gstPercentage ?? 0;

          // update controllers
          controller.itemCodeController.text   = item.itemCode?.toString() ?? '';
          controller.itemNameController.text   = item.itemName ?? '';
          controller.batchNoController.text    = item.batchNoRequired.toString();
          controller.expiryController.text     = item.expiryDateFormat ?? '';
          controller.hsnController.text        = item.hSNCode ?? '';
          controller.qtyController.text        = item.maximumStockQty.toString();
          controller.mrpController.text        = item.mRPRate.toString();
          controller.salesRateController.text  = item.salesRate.toString();
          controller.gstController.text        = item.gstPercentage.toString();

          // ✅ Add new empty row if last row was just filled
          if (_activeRowIndex == items.length - 1) {
            items.add(product.Info());
            controllers.add(ItemRowControllers());
          }

          // hide sub-table
          _showSubTable = false;
          _searchResults.clear();
          _activeRowIndex = null;
        }
      });
    },
    cells: [
      DataCell(Text("${index + 1}")), // ✅ now index works
      DataCell(Text(p.itemCode?.toString() ?? "")),
      DataCell(Text(p.itemName ?? "")),
      DataCell(Text(p.batchNoRequired.toString())),
      DataCell(Text(p.expiryDateFormat ?? "")),
      DataCell(Text(p.hSNCode.toString())),
      DataCell(Text(p.maximumStockQty.toString())),
      DataCell(Text(p.maximumStockQty.toString())),
      DataCell(Text(p.mRPRate.toString())),
      DataCell(Text(p.purchaseRate.toString())),
      DataCell(Text(p.salesRate.toString())),
    ],
  );
}).toList(),
        ),
      ),
    ),
  ),
      
              ],
            ),
        
          ),
        ),
      ),
  bottomNavigationBar: Container(
  color: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal, // allow horizontal scroll
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GstDataTableWidget(),
        const SizedBox(width: 16),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabeledTextField(
              focusNode: _sgstpreFocus,
              label: "SGST %",
              controller: _sgstpreController,
              readOnly: false,
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
  ),
),
   
    );
  
  }
   



void _showItemSelection(BuildContext context) async {
  final selectedItem = await showModalBottomSheet<product.Info>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Select Item",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("SL No")),
                    DataColumn(label: Text("Item Code")),
                    DataColumn(label: Text("Barcode No")),
                    DataColumn(label: Text("Item Name")),
                    DataColumn(label: Text("UOM")),
                    DataColumn(label: Text("Qty")),
                    DataColumn(label: Text("Sales Rate")),
                  ],
                  rows: List.generate(items.length, (index) {
                    final item = items[index];
                    return DataRow(
                      cells: [
                        DataCell(Text("${index + 1}")),
                        DataCell(Text(item.itemCode.toString())),
                        DataCell(Text(item.batchNoRequired.toString())),
                        DataCell(Text(item.itemName!)),
                        DataCell(Text(item.maximumStockQty.toString())),
                        DataCell(Text("${item.maximumStockQty.toString()}")),
                        DataCell(Text("${item.mRPRate}")),
                      ],
                      onSelectChanged: (_) {
                        Navigator.pop(context, item); // return item
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  if (selectedItem != null) {
    setState(() {
      itemCodeController.text = selectedItem.itemCode.toString();
      batchNoController.text = selectedItem.batchNoRequired.toString();
      itemNameController.text = selectedItem.itemName!;
    //  uomController.text = selectedItem.uom;
      qtyController.text = selectedItem.maximumStockQty.toString();
      mrpController.text = selectedItem.mRPRate.toString();
    });
  }
}


}


