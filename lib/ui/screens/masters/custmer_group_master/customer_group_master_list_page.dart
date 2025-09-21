import 'package:flutter/material.dart';


import '../../../../data/models/customer_group_master/customer_group_master_list_model.dart';
import '../../../../data/services/customer_group_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class CustomerGroupMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const CustomerGroupMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<CustomerGroupMasterListPage> createState() => _CustomerGroupMasterListPageState();
}

class _CustomerGroupMasterListPageState extends State<CustomerGroupMasterListPage> {
  final CustomerGroupMasterService _service = CustomerGroupMasterService();
  CustomerGroupMasterModel? customerGroupMasterModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  CustomerGroupMasterModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(CustomerGroupMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getSCCustomerGroupMaster();
    if (response.isSuccess) {
      setState(() {
        customerGroupMasterModel = response.data!;
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

    final infos = customerGroupMasterModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.custGroupName ?? "",
          subtitle: "Code: ${info.custGroupCode.toString() ?? ""}",
          initials:  "NA",
          //initials: info.unitId?.substring(0, 2).toUpperCase() ?? "NA",
          onEdit: () {
            widget.onEdit(info);
          },
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete Customer Group"),
                content:
                    Text("Are you sure you want to delete ${info.custGroupName}?"),
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
              final response = await _service.deleteCCustomerGroupMaster(info.custGroupCode!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.custGroupCode}")),
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
