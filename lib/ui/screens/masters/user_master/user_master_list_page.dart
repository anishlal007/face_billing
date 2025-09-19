import 'package:facebilling/data/models/unit/unit_response.dart';
import 'package:facebilling/data/services/unit_service.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/user_master/user_master_list_model.dart';
import '../../../../data/services/location_master_service.dart';
import '../../../../data/services/user_master_service.dart';
import '../../../widgets/list_card_widget.dart';

class UserMasterListPage extends StatefulWidget {
  final bool refreshList;
  final Function(Info) onEdit;
  const UserMasterListPage({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<UserMasterListPage> createState() => _UserMasterListPageState();
}

class _UserMasterListPageState extends State<UserMasterListPage> {
  final UserMasterService _service = UserMasterService();
  UserMasterListModel? userMasterListModel;
  bool loading = true;
  String? error;
  bool showForm = false;
  UserMasterListModel? editingCountry;

  @override
  void initState() {
    super.initState();
    _loadLocationMaster();
  }

  @override
  void didUpdateWidget(UserMasterListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList) {
      _loadLocationMaster();
    }
  }

  Future<void> _loadLocationMaster() async {
    final response = await _service.getSUserMaster();
    if (response.isSuccess) {
      setState(() {
        userMasterListModel = response.data!;
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

    final infos = userMasterListModel?.info ?? [];

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;
        return ListCardWidget(
          title: info.userName ?? "",
          subtitle: "Code: ${info.userCode.toString() ?? ""}",
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
                    Text("Are you sure you want to delete ${info.userName}?"),
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
              final response = await _service.deleteUserMaster(info.userId!);
              if (response.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Deleted ${info.userId}")),
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
