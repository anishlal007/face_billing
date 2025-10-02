import 'package:facebilling/data/models/get_all_master_list_model.dart' as master;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart'; 
import '../../../../core/colors.dart';
import '../../../../data/models/get_report_master_model.dart';
import '../../../../data/services/get_all_master_service.dart';
import '../../../../data/services/report_master_services.dart';
import '../../../widgets/search_dropdown.dart';

class ReportMasterPage extends StatefulWidget {
  @override
  State<ReportMasterPage> createState() => _ReportMasterPageState();
}

class _ReportMasterPageState extends State<ReportMasterPage> {

///services
    final ReportMasterServices _service = ReportMasterServices();
    final GetAllMasterService _getAllMasterService = GetAllMasterService();
    List<Info>?items;
//controller
 final TextEditingController purchaseNoController = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();
  final TextEditingController supplierInvoiceNoController = TextEditingController();
  final TextEditingController purchaseValueController = TextEditingController();
  final TextEditingController supNameValueController = TextEditingController();
  final TextEditingController supIdValueController = TextEditingController();

 void _applyFilters() async {
    final result = await _service.getReportService(
      purchaseNo: purchaseNoController.text,
      purchaseDate: purchaseDateController.text,
      supplierInvoiceNo: supplierInvoiceNoController.text,
      supplierId: supIdValueController.text,
      supplierName: "lal",
     // supplierName: supNameValueController.text,
      purchaseValue: purchaseValueController.text,
    );
  setState(() {
      items = result.data?.info; // assign Info object
    });
    print("API Result: ${result.data}");
  }
 
 bool _getAllLoading = true;
  String? error;

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
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 300), () {
    //   FocusScope.of(context).requestFocus(_itemNameFocus);
    // });
    _loadList();
   
  }
  master.GetAllMasterListModel? getAllMasterListModel;
 

 Future<void> _generatePdf(List<Info> items) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      build: (context) {
        return pw.Column(
          children: [
            pw.Text("Invoice Report", style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: [
                'Sl.', 'Pur. No', 'Pur. Date', 'Supp Inv.No.', 'Supp Inv.Dt.',
                'Supplier ID', 'Supplier', 'Product', 'Qty', 'Rate',
                'Pur.Value', 'Sale Rate', 'Sal.Value'
              ],
              data: items.asMap().entries.map((entry) {
                int index = entry.key;
                Info item = entry.value;

                String productNames = item.details != null
                    ? item.details!.map((d) => d.itemName ?? '').join(', ')
                    : '';

                return [
                  (index + 1).toString(),
                  item.purchaseNo ?? '',
                  item.purchaseDate ?? '',
                  item.invoiceNo ?? '',
                  item.invoiceDate ?? '',
                  item.supCode ?? '',
                  item.supName ?? '',
                  productNames,
                  item.purchaseTaxableAmount?.toString() ?? '',
                  item.roundOffAmount?.toString() ?? '',
                  item.purchaseDiscountValue?.toString() ?? '',
                  item.paidAmount?.toString() ?? '',
                  item.paidAmount?.toString() ?? '',
                ];
              }).toList(),
            ),
          ],
        );
      },
    ),
  );

  // Save or print
  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}
  @override
  Widget build(BuildContext context) {
      if (_getAllLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text("Error: $error"));

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        scrolledUnderElevation: 0,
    automaticallyImplyLeading: true, // keeps back button if needed
    title: null, // remove text
    actions: [
      IconButton(
        icon: Icon(Icons.print),
        tooltip: "Print",
        onPressed: () {
          // TODO: Add print functionality
          print("Print clicked");
        },
      ),
     IconButton(
  icon: Icon(Icons.download),
  tooltip: "Download PDF",
  onPressed: () {
    if (items != null && items!.isNotEmpty) {
      _generatePdf(items!);
    } else {
      print("No data to export");
    }
  },
),
    ],
  ),
      body: SingleChildScrollView(
       // scrollDirection: Axis.horizontal,
        child: Column(
          children: [
         LayoutBuilder(builder: (context, constraints) {
                int columns = 1; // default mobile
                if (constraints.maxWidth > 1200) {
                  columns = 5;
                } else if (constraints.maxWidth > 800) {
                  columns = 5;
                }
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
  width: constraints.maxWidth / columns - 20,
  child: SearchableDropdown<master.Suppliers>(
    hintText:"Select Supplier",
    items: getAllMasterListModel!.info!.suppliers!,
    itemLabel: (supplier) => supplier.supName ?? "",
    onChanged: (supplier) {
      if (supplier != null) {
        supNameValueController.text = supplier.supName.toString();
        print("Selected Code: ${supplier.supCode}");
        print("Selected Name: ${supplier.supName}");
      }
    },
  ),
),
           
                    SizedBox(
  width: constraints.maxWidth / columns - 20,
  child: SearchableDropdown<master.Suppliers>(
    hintText:"Select Supplier Code",
    items: getAllMasterListModel!.info!.suppliers!,
    itemLabel: (supplier) => supplier.supCode.toString() ?? "",
    onChanged: (supplier) {
      if (supplier != null) {
        supIdValueController.text = supplier.supCode.toString();
        print("Selected Code: ${supplier.supCode}");
        print("Selected Name: ${supplier.supName}");
      }
    },
  ),
),
           
                    SizedBox(
  width: constraints.maxWidth / columns - 20,
  child: TextField(
      controller: supplierInvoiceNoController,
      decoration: InputDecoration(
        hintText: "Supplier Invoice No",
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
     
      //  filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
      ),
    )
),
           
                    SizedBox(
  width: constraints.maxWidth / columns - 20,
  child:GestureDetector(
     onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          purchaseDateController.text = formattedDate;
        }
      },
    child: AbsorbPointer(
      child: TextField(
          controller: purchaseDateController,
          decoration: InputDecoration(
            hintText: "Purchase Date",
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
         
          //  filled: true,
            fillColor: white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primary, width: 2),
            ),
          ),
        ),
    ),
  )
),
           
                    SizedBox(
  width: constraints.maxWidth / columns - 20,
  child:  TextField(
      controller: purchaseNoController,
      decoration: InputDecoration(
        hintText: "Purchase No",
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
     
      //  filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
      ),
    )
),
  GestureDetector(
                  onTap: () {
                    _applyFilters();
                    // Call your Apply Filter function here
                   
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primary, // button color
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.search,
                      color: white,
                      size: 28,
                    ),
                  ),
                ),
           
         // DataTable with horizontal scroll
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                child: DataTable(
                   border: TableBorder.all(color: primary),
                        columnSpacing: 30,
                        headingRowColor: MaterialStateProperty.all(primary),
                //  columnSpacing: 16,
                  headingRowHeight: 40,
                  dataRowHeight: 40,
                  columns: const [
                    DataColumn(label: Text("Sl.",style: TextStyle(color: white))),
                    DataColumn(label: Text("Pur. No",style: TextStyle(color: white))),
                    DataColumn(label: Text("Pur. Date",style: TextStyle(color: white))),
                    DataColumn(label: Text("Supp Inv.No.",style: TextStyle(color: white))),
                    DataColumn(label: Text("Supp Inv.Dt.",style: TextStyle(color: white))),
                    DataColumn(label: Text("Supplier ID",style: TextStyle(color: white))),
                    DataColumn(label: Text("Supplier",style: TextStyle(color: white))),
                    DataColumn(label: Text("Product",style: TextStyle(color: white))),
                    DataColumn(label: Text("Qty",style: TextStyle(color: white))),
                    DataColumn(label: Text("Rate",style: TextStyle(color: white))),
                    DataColumn(label: Text("Pur.Value",style: TextStyle(color: white))),
                    DataColumn(label: Text("Sale Rate",style: TextStyle(color: white))),
                    DataColumn(label: Text("Sal.Value",style: TextStyle(color: white))),
                  ],
                  // Show rows only if items is not null
              rows:
              items == null || items!.isEmpty
            ? [
                DataRow(cells: List.generate(
                  13,
                  (index) => DataCell(
                    Center(
                      child: index == 0
                          ? Text("No report found", style: TextStyle(color: primary))
                          : SizedBox.shrink(),
                    ),
                  ),
                )),
              ]
            : items?.asMap().entries.map((entry) {
  int index = entry.key;
  Info item = entry.value;
   String productNames = item.details != null
      ? item.details!.map((d) => d.itemName ?? '').join(', ')
      : '';
  return DataRow(cells: [
    DataCell(Text("${index + 1}")), // 🔹 Serial number
    DataCell(Text("${item.purchaseNo ?? ''}")),
    DataCell(Text("${item.purchaseDate ?? ''}")),
    DataCell(Text("${item.supName ?? ''}")),
    DataCell(Text("${item.invoiceDate ?? ''}")),
    DataCell(Text("${item.supCode ?? ''}")),
    DataCell(Text("${item.supName ?? ''}")),
    DataCell(Text("${productNames?? ''}")),
    DataCell(Text("${item.purchaseTaxableAmount.toString() ?? ''}")),
    DataCell(Text("${item.roundOffAmount.toString() ?? ''}")),
    DataCell(Text("${item.purchaseDiscountValue ?? ''}")),
    DataCell(Text("${item.paidAmount.toString() ?? ''}")),
    DataCell(Text("${item.paidAmount.toString() ?? ''}")),
  ]);
}).toList() ?? [],
                ),),))
                  ],
                );
              }),
           
          
          ],
        ),
      ),
    );
 
  }
}