import 'package:flutter/material.dart';


import '../../../../data/models/finance_master/finance_year_master_model.dart';
import '../../../../data/services/finance_year_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class FinanceYearMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const FinanceYearMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<FinanceYearMasterListPage> createState() => _FinanceYearMasterListPageState();
}

class _FinanceYearMasterListPageState extends State<FinanceYearMasterListPage> {
  final FinanceYearMasterService _service = FinanceYearMasterService();
  FinanceYearMasterListModel? financeYearMasterListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  FinanceYearMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(FinanceYearMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getSFinanceYearMaster();
    if (response.isSuccess) {
      setState(() {
        financeYearMasterListModel = response.data!;
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

    final infos = financeYearMasterListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.finYearStartDate ?? "",
          subtitle: "Code: ${info.finYearCode.toString() ?? ""}",
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
                    Text("Are you sure you want to delete ${info.finYearStartDate}?"),
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
              final response = await _service.deleteFinanceYearMaster(info.finYearCode!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.finYearCode}")),
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
