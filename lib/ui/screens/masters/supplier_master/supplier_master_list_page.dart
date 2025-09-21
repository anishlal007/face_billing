import 'package:flutter/material.dart';

import '../../../../data/models/supplier_master/supplier_master_list_model.dart';
import '../../../../data/services/state_master_service.dart';
import '../../../../data/services/supplier_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class SupplierMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const SupplierMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<SupplierMasterListPage> createState() => _SupplierMasterListPageState();
}

class _SupplierMasterListPageState extends State<SupplierMasterListPage> {
  final SupplierMasterService _service = SupplierMasterService();
  SupplierMasterListModel? supplierMasterListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  SupplierMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(SupplierMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getSupplierMaster();
    if (response.isSuccess) {
      setState(() {
        supplierMasterListModel = response.data!;
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

    final infos = supplierMasterListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.supName ?? "",
          subtitle: "Code: ${info.supCode.toString() ?? ""}",
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
                    Text("Are you sure you want to delete ${info.supName}?"),
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

            if (confirm == true) {
              final response = await _service.deleteSupplierMaster(info.supId!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.supId}")),
                );
                _loadLocationMaster();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${response.error}")),
                );
              }
            }
          },
          isviewcircleavathar: true,
        );
      },
    );
  }
}
