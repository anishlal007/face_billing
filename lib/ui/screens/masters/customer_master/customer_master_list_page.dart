import 'package:flutter/material.dart';

import '../../../../data/models/customer_master/customer_master_list_model.dart';
import '../../../../data/services/customer_master_service.dart';
import '../../../../data/services/user_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class CustomerMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const CustomerMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<CustomerMasterListPage> createState() => _CustomerMasterListPageState();
}

class _CustomerMasterListPageState extends State<CustomerMasterListPage> {
  final CustomerMasterService _service = CustomerMasterService();
  CustomerMasterListModel? customerMasterListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  CustomerMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(CustomerMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getSCustomerMaster();
    if (response.isSuccess) {
      setState(() {
        customerMasterListModel = response.data!;
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

    final infos = customerMasterListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.custName ?? "",
          subtitle: "Code: ${info.custCode.toString() ?? ""}",
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
                    Text("Are you sure you want to delete ${info.custName}?"),
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
              final response = await _service.deleteCustomerMaster(info.custId!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.custId}")),
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
