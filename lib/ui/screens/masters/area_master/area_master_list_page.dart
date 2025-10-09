import 'package:facebilling/data/models/area_master/area_master_list_model.dart';
import 'package:facebilling/data/models/unit/unit_response.dart';
import 'package:facebilling/data/services/unit_service.dart';
import 'package:flutter/material.dart';


import '../../../../data/services/area_master_service.dart';
import '../../../../data/services/user_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class AreaMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const AreaMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<AreaMasterListPage> createState() => _AreaMasterListPageState();
}

class _AreaMasterListPageState extends State<AreaMasterListPage> {
  final AreaMasterService _service = AreaMasterService();
  AreaMasterListModel? areaMasterListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  AreaMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(AreaMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getSAreaMaster();
    if (response.isSuccess) {
      setState(() {
        areaMasterListModel = response.data!;
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

    final infos = areaMasterListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.areaName ?? "",
          subtitle: "Code: ${info.areaCode.toString() ?? ""}",
          //initials:  "NA",
          initials: info.areaId?.substring(0, 2).toUpperCase() ?? "NA",
          onEdit: () {
            widget.onEdit(info);
          },
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete Unit"),
                content:
                    Text("Are you sure you want to delete ${info.areaName}?"),
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
              final response = await _service.deleteAreaMaster(info.areaId!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.areaId}")),
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
