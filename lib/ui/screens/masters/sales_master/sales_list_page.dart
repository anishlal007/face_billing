import 'package:flutter/material.dart';

import '../../../../data/models/sales/get_sales_list_model.dart';
import '../../../../data/services/sales_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class SalesListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const SalesListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<SalesListPage> createState() => _SalesListPageState();
}

class _SalesListPageState extends State<SalesListPage> {
  final SalesMasterService _service = SalesMasterService();
  GetSalesListModel? getSalesListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  GetSalesListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(SalesListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getSalesList();
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
          title: info.salesCode.toString() ?? "",
          subtitle: "Code: ${info.salesNetAmount.toString() ?? ""}",
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
                    Text("Are you sure you want to delete ${info.salesAccCode}?"),
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
