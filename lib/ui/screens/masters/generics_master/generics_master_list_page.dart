import 'package:facebilling/data/models/unit/unit_response.dart';
import 'package:facebilling/data/services/unit_service.dart';
import 'package:flutter/material.dart';



import '../../../../data/models/generics_master/generics_master_list_model.dart';
import '../../../../data/models/location_master_model/location_master_list_model.dart' hide Info;
import '../../../../data/services/generics_master_services.dart';
import '../../../../data/services/item_make_master_service.dart';
import '../../../../data/services/location_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class GenericsMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const GenericsMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<GenericsMasterListPage> createState() => _GenericsMasterListPageState();
}

class _GenericsMasterListPageState extends State<GenericsMasterListPage> {
  final GenericsMasterServices _service = GenericsMasterServices();
  GenericsMasterListModel? genericsMasterListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  GenericsMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(GenericsMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getGenericsMaster();
    if (response.isSuccess) {
      setState(() {
        genericsMasterListModel = response.data!;
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

    final infos = genericsMasterListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.genericName ?? "",
        subtitle: "Code: ${info.genericCode ?? ""}",
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
                    Text("Are you sure you want to delete ${info.genericName}?"),
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
              final response = await _service.deleteGenericsMaster(info.genericCode!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.genericCode}")),
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
