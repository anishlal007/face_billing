import 'package:facebilling/data/models/unit/unit_response.dart';
import 'package:facebilling/data/services/unit_service.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/hns_master/hns_master_list_model.dart';

import '../../../../data/services/hns_master_service.dart';
import '../../../../data/services/location_master_service.dart';
import '../../../../data/services/tax_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class HnsMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const HnsMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<HnsMasterListPage> createState() => _HnsMasterListPageState();
}

class _HnsMasterListPageState extends State<HnsMasterListPage> {
  final HnsMasterService _service = HnsMasterService();
  HnsMasterListModel? hnsMasterListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  HnsMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(HnsMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getHnsMaster();
    if (response.isSuccess) {
      setState(() {
        hnsMasterListModel = response.data!;
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

    final infos = hnsMasterListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.hsnName ?? "",
          subtitle: "Code: ${info.hsnCode.toString() ?? ""}",
          //initials:  "NA",
          initials: info.hsnName?.substring(0, 2).toUpperCase() ?? "NA",
          onEdit: () {
            widget.onEdit(info);
          },
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete Hsn"),
                content:
                    Text("Are you sure you want to delete ${info.hsnName}?"),
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
              final response = await _service.deleteHnsMaster(info.hsnCode!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.hsnCode}")),
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
