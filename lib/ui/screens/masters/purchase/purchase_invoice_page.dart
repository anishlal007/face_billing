import 'package:flutter/material.dart';

class PurchaseInvoicePage extends StatelessWidget {
  const PurchaseInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchase Invoice"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Top Form Section
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildTextField("Invoice Date", "Select Date"),
                _buildTextField("Invoice Time", "Select Time"),
                _buildTextField("Tax Type", "VAT"),
                _buildTextField("Invoice No", "Enter Invoice No"),
                _buildTextField("User ID & Name", "12 | Firos"),
                _buildTextField("Payment Mode", "CASH"),
                _buildTextField("Till Code", "Till02"),
                _buildTextField("Branch Name", "Najoom Al Maha"),
                _buildTextField("Transaction Type", "CASH"),
                _buildTextField("Remarks", "Enter remark"),
              ],
            ),

            const SizedBox(height: 20),

            // 🔹 Invoice Table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(color: Colors.grey.shade300),
                headingRowColor:
                    MaterialStateProperty.all(Colors.blue.shade50),
                columns: const [
                  DataColumn(label: Text("SL No")),
                  DataColumn(label: Text("Item Code")),
                  DataColumn(label: Text("Barcode No")),
                  DataColumn(label: Text("Item Name")),
                  DataColumn(label: Text("UOM")),
                  DataColumn(label: Text("QTY")),
                  DataColumn(label: Text("Rate")),
                  DataColumn(label: Text("Gross Amt")),
                  DataColumn(label: Text("VAT Amt")),
                  DataColumn(label: Text("Net Amt")),
                  DataColumn(label: Text("Action")),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text("1")),
                    DataCell(TextFormField()),
                    DataCell(TextFormField()),
                    DataCell(TextFormField()),
                    DataCell(DropdownButton<String>(
                      value: "PCS",
                      items: const [
                        DropdownMenuItem(value: "PCS", child: Text("PCS")),
                        DropdownMenuItem(value: "KG", child: Text("KG")),
                      ],
                      onChanged: (_) {},
                    )),
                    DataCell(TextFormField()),
                    DataCell(TextFormField()),
                    DataCell(TextFormField()),
                    DataCell(TextFormField()),
                    DataCell(TextFormField()),
                    DataCell(IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {},
                    )),
                  ]),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Bottom Totals
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildTextField("QTY", "0"),
                _buildTextField("Items", "0"),
                _buildTextField("Gross Total", "0.00 SAR"),
                _buildTextField("VAT Total", "0.00 SAR"),
                _buildTextField("Discount", "0.00"),
                _buildTextField("Net Total", "0.00 SAR"),
              ],
            ),

            const SizedBox(height: 20),

            // 🔹 Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton("Save", Colors.blue),
                const SizedBox(width: 12),
                _buildButton("Import", Colors.orange),
                const SizedBox(width: 12),
                _buildButton("Cancel", Colors.grey),
                const SizedBox(width: 12),
                _buildButton("Close", Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Reusable TextField Widget
  Widget _buildTextField(String label, String hint) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }

  // 🔹 Reusable Button Widget
  Widget _buildButton(String text, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: () {},
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}