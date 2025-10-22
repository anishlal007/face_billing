import 'package:facebilling/data/models/product/product_master_list_model.dart';
import 'package:facebilling/data/services/product_service.dart';
import 'package:flutter/material.dart';

import '../../../widgets/list_card_widget.dart';

// class ProductListPage extends StatefulWidget {
//   const ProductListPage({super.key});

//   @override
//   State<ProductListPage> createState() => _ProductListPageState();
// }

// class _ProductListPageState extends State<ProductListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class ProductListPage extends StatefulWidget {
  final bool refreshList;
  final Function(productListInfo) onEdit;
  const ProductListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductService _service = ProductService();
  ProductMasterListModel? itemList;
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
  void didUpdateWidget(ProductListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getSProductService();
    if (response.isSuccess) {
      setState(() {
        itemList = response.data!;
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

    final infos = itemList?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.itemName ?? "",
          subtitle: "Code: ${info.itemCode.toString() ?? ""}",
          initials: "NA",
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
            //   final response =
            //       await _service.deleteLocationMaster(info.itemLocationCode!);
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
