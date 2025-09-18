import 'package:facebilling/data/models/unit/unit_response.dart';
import 'package:facebilling/data/services/unit_service.dart';
import 'package:flutter/material.dart';

import '../../../widgets/list_card_widget.dart';

class Unitscreen extends StatefulWidget {
  final bool refreshList;
  final Function(UnitInfo) onEdit;
  const Unitscreen({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<Unitscreen> createState() => _UnitscreenState();
}

class _UnitscreenState extends State<Unitscreen> {
  final UnitService _service = UnitService();
  UnitResponse? units;
  bool loading = true;
  String? error;
  bool showForm = false;
  UnitInfo? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadUnits();
  }

  @override
  void didUpdateWidget(Unitscreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadUnits();
    }
  }

  Future<void> _loadUnits() async {
    final response = await _service.getUnit();
    if (response.isSuccess) {
      setState(() {
        units = response.data!;
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

    final infos = units?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.unitName ?? "",
          subtitle: "Code: ${info.unitId ?? ""}",
          initials: info.unitId?.substring(0, 2).toUpperCase() ?? "NA",
          onEdit: () {
            widget.onEdit(info);
          },
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete Unit"),
                content:
                    Text("Are you sure you want to delete ${info.unitName}?"),
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
              final response = await _service.deleteUnit(info.unitCode!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.unitName}")),
                );
                _loadUnits();
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
