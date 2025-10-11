import 'package:flutter/material.dart';

import '../../../../data/models/product/product_master_list_model.dart';

import '../../../../data/services/product_service.dart';
import '../../../../data/services/sales_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class ProductMasterListScreen extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const ProductMasterListScreen({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<ProductMasterListScreen> createState() => _ProductMasterListScreenState();
}

class _ProductMasterListScreenState extends State<ProductMasterListScreen> {
  final ProductService _service = ProductService();
  ProductMasterListModel? getSalesListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  ProductMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(ProductMasterListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getSProductService();
    if (response.isSuccess) {
      setState(() {
        getSalesListModel = response.data!;
        loading = false;
        error = null;
      });
    } else {
      setState(() {
        error = response.error;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text("Error: $error"));

    final infos = getSalesListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.itemName.toString() ?? "",
          subtitle: "Code: ${info.itemCode.toString() ?? ""}",
          initials:  "NA",
          //initials: info.unitId?.substring(0, 2).toUpperCase() ?? "NA",
          onEdit: () {
            widget.onEdit(info);
          },
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete Unit"),
                content:
                    Text("Are you sure you want to delete ${info.itemName}?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Delete"),
                  ),
                ],
              ),
            );

            // if (confirm == true) {
            //   final response = await _service.deleteLocationMaster(info.itemLocationCode!);
            //   if (response.isSuccess) {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(content: Text("Deleted ${info.itemLocationCode}")),
            //     );
            //     _loadLocationMaster();
            //   } else {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(content: Text("Error: ${response.error}")),
            //     );
            //   }
            // }
          },
          isviewcircleavathar: true,
        );
      },
    );
  }
}
