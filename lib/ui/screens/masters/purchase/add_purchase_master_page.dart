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

    return SingleChildScrollView(
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
   
   SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: DataTable(
    border: TableBorder.all(color: Colors.grey.shade300),
    headingRowColor: MaterialStateProperty.all(Colors.blue.shade50),
    columns: const [
      DataColumn(label: Text("SL No")),
      DataColumn(label: Text("Item Code")),
      DataColumn(label: Text("Item Name")),
      DataColumn(label: Text("Batch No")),
      DataColumn(label: Text("Expiry")),
      DataColumn(label: Text("HSN Code")),
      DataColumn(label: Text("Qty")),
      DataColumn(label: Text("MRP/Rate")),
      // DataColumn(label: Text("Net Rate")),
      // DataColumn(label: Text("Net Value")),
      DataColumn(label: Text("Sale Rate")),
      DataColumn(label: Text("GST %")),
      DataColumn(label: Text("GST Value")),
      DataColumn(label: Text("Action")),
    ],
    rows: List.generate(items.length, (index) {
      final item = items[index];
       final controller = controllers[index];
      return DataRow(cells: [
        DataCell(Text("${index + 1}")),

        // Item Code
        DataCell(TextFormField(
          initialValue: item.itemCode?.toString() ?? '',
          keyboardType: TextInputType.number,
          onChanged: (val) => item.itemCode = int.tryParse(val),
        )),

        // Item Name with API search
        DataCell(SearchDropdownField<product.Info>(
      hintText: "Search Item",
      fetchItems: (q) async {
        final response = await _productService.getProductServiceSearch(q);
        if (response.isSuccess) return response.data?.info ?? [];
        return [];
      },
      displayString: (unit) => unit.itemName ?? "",
      onSelected: (selected) {
        setState(() {
          // Update the item
          item.itemCode = selected.itemCode;
          item.itemName = selected.itemName ?? '';
          item.batchNoRequired = selected.batchNoRequired ?? 0;
          item.expiryDateFormat = selected.expiryDateFormat ?? '';
          item.hSNCode = selected.hSNCode ?? '';
          item.maximumStockQty = selected.maximumStockQty ?? 0;
          item.mRPRate = selected.mRPRate ?? 0;
          item.salesRate = selected.salesRate ?? 0;
          item.gstPercentage = selected.gstPercentage ?? 0;

          // Update controllers for this row only
          controller.itemCodeController.text = item.itemCode?.toString() ?? '';
          controller.itemNameController.text = item.itemName!;
          controller.batchNoController.text = item.batchNoRequired.toString();
          controller.expiryController.text = item.expiryDateFormat!;
          controller.hsnController.text = item.hSNCode!;
          controller.qtyController.text = item.maximumStockQty.toString();
          controller.mrpController.text = item.mRPRate.toString();
          controller.salesRateController.text = item.salesRate.toString();
          controller.gstController.text = item.gstPercentage.toString();

          // Add new empty row if last row is filled
          if (index == items.length - 1) {
            items.add(product.Info());
            controllers.add(ItemRowControllers());
          }
        });
      },
    )),

//         DataCell(SearchDropdownField<product.Info>(
//           hintText: "Search Item",
//           fetchItems: (q) async {
//             final response = await _productService.getProductServiceSearch(q);
//             if (response.isSuccess) {
//               return response.data?.info ?? [];
//             }
//             return [];
//           },
//           displayString: (unit) => unit.itemName ?? "",
//           onSelected: (selected) {
//             setState(() {
//   // Assign all values from the selected item to the current row
//   item.itemCode     = selected.itemCode;
//   item.itemName     = selected.itemName ?? '';
//   item.batchNoRequired      = selected.batchNoRequired ??0;
//   item.expiryDateFormat       = selected.expiryDateFormat ?? '';
//   item.hSNCode      = selected.hSNCode ?? '';
//   item.maximumStockQty          = selected.maximumStockQty ?? 0;
//   item.mRPRate      = selected.mRPRate ?? 0;

//   item.salesRate     = selected.salesRate ?? 0;
//   item.gstPercentage   = selected.gstPercentage ?? 0;

//   itemCodeController.text = item.itemCode?.toString() ?? '';
//     itemNameController.text = item.itemName!;
//   batchNoController.text = item.batchNoRequired.toString();
//     expiryController.text = item.expiryDateFormat!;
//  hsnController.text = item.hSNCode!;
//     qtyController.text = item.maximumStockQty.toString();
//    mrpController.text = item.mRPRate.toString();
//    salesRateController.text = item.salesRate.toString();
//    gstController.text = item.gstPercentage.toString();
//   // Add a new empty row if last row is filled
//   if (index == items.length - 1) {
//     items.add(product.Info(
//       itemCode: null,
//       itemName: '',
//       batchNoRequired: 0,
//       expiryDateFormat: '',
//       hSNCode: '',
//       maximumStockQty: 0,
//       mRPRate: 0,
     
//       salesRate: 0,
//       gstPercentage: 0,
  
//     ));
//   }
// });
//             // setState(() {
//             //   item.itemCode = selected.itemCode;
//             //   item.itemName = selected.itemName ?? "";

//             //   // Add a new empty row if last row filled
//             //   if (index == items.length - 1) items.add(product.Info());
//             // });
//           },
//         )),

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

const SizedBox(height: 100,)
            ],
          ),
      
        ),
      ),
    );
  }
   


}


