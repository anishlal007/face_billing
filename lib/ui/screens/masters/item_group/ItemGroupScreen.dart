import 'package:facebilling/data/models/item_group/item_group_response.dart';
import 'package:flutter/material.dart';

import '../../../../data/services/item_group_service.dart';
import '../../../widgets/list_card_widget.dart';

class Itemgroupscreen extends StatefulWidget {
  final bool refreshList;
  final Function(ItemGroupInfo) onEdit;
  const Itemgroupscreen({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<Itemgroupscreen> createState() => _ItemgroupscreenState();
}

class _ItemgroupscreenState extends State<Itemgroupscreen> {
  final ItemGroupService _service = ItemGroupService();
  ItemGroupResponse? itemGroup;
  bool loading = true;
  String? error;
  bool showForm = false;
  ItemGroupInfo? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadgroups();
  }

  @override
  void didUpdateWidget(Itemgroupscreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadgroups();
    }
  }

  Future<void> _loadgroups() async {
    final response = await _service.getItemGroup();
    if (response.isSuccess) {
      setState(() {
        itemGroup = response.data!;
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

    final infos = itemGroup?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.itemGroupName ?? "",
          subtitle: "Codes: ${info.itemGroupCode ?? ""}",
          initials: info.itemGroupName?.substring(0, 2).toUpperCase() ?? "NA",
          onEdit: () {
            // Notify parent (CountryMasterScreen) to open AddCountryScreen with this country
            widget.onEdit(info);
          },
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete Country"),
                content: Text(
                    "Are you sure you want to delete ${info.itemGroupName}?"),
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
              final response =
                  await _service.deleteItemGroup(info.itemGroupCode!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.itemGroupName}")),
                );
                _loadgroups();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${response.error}")),
                );
              }
            }
          },
          isviewcircleavathar: false,
        );
      },
    );
  }
}
