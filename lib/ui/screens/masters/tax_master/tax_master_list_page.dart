import 'package:facebilling/data/models/unit/unit_response.dart';
import 'package:facebilling/data/services/unit_service.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/tax_master/tax_master_list_model.dart';
import '../../../../data/services/location_master_service.dart';
import '../../../../data/services/tax_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class TaxMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const TaxMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<TaxMasterListPage> createState() => _TaxMasterListPageState();
}

class _TaxMasterListPageState extends State<TaxMasterListPage> {
  final TaxMasterService _service = TaxMasterService();
  TaxMasterListModel? taxMasterListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  TaxMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(TaxMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getTaxMaster();
    if (response.isSuccess) {
      setState(() {
        taxMasterListModel = response.data!;
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

    final infos = taxMasterListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.taxName ?? "",
          subtitle: "Code: ${info.taxCode.toString() ?? ""}",
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
                    Text("Are you sure you want to delete ${info.taxName}?"),
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
              final response = await _service.deleteTaxMaster(info.taxId!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.taxId}")),
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
