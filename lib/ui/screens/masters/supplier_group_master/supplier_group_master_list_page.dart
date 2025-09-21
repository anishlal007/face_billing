import 'package:flutter/material.dart';


import '../../../../data/models/supplier_group_master/supplier_group_master_list_model.dart';
import '../../../../data/services/state_master_service.dart';
import '../../../../data/services/supplier_group_master_service.dart';
import '../../../../data/services/supplier_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class SupplierGroupMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const SupplierGroupMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<SupplierGroupMasterListPage> createState() => _SupplierGroupMasterListPageState();
}

class _SupplierGroupMasterListPageState extends State<SupplierGroupMasterListPage> {
  final SupplierGroupMasterService _service = SupplierGroupMasterService();
  SupplierGroupMasterListModel? supplierGroupMasterListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  SupplierGroupMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(SupplierGroupMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getSupplierGroupMaster();
    if (response.isSuccess) {
      setState(() {
        supplierGroupMasterListModel = response.data!;
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

    final infos = supplierGroupMasterListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.supGroupName ?? "",
          subtitle: "Code: ${info.supGroupCode.toString() ?? ""}",
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
                    Text("Are you sure you want to delete ${info.supGroupName}?"),
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
              final response = await _service.deleteSupplierGroupMaster(info.supGroupCode!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.supGroupCode}")),
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
