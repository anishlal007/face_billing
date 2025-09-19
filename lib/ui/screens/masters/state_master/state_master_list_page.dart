import 'package:flutter/material.dart';


import '../../../../data/models/state_master/state_master_list_model.dart';
import '../../../../data/services/state_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class StateMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const StateMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<StateMasterListPage> createState() => _StateMasterListPageState();
}

class _StateMasterListPageState extends State<StateMasterListPage> {
  final StateMasterService _service = StateMasterService();
  StateMasterListModel? stateMasterListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  StateMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(StateMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getStateMaster();
    if (response.isSuccess) {
      setState(() {
        stateMasterListModel = response.data!;
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

    final infos = stateMasterListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.stateName ?? "",
          subtitle: "Code: ${info.stateCode.toString() ?? ""}",
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
                    Text("Are you sure you want to delete ${info.stateName}?"),
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
              final response = await _service.deleteStateMaster(info.stateId!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.stateId}")),
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
