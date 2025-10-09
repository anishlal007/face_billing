import 'package:facebilling/data/models/item_group/add_group_request.dart';
import 'package:facebilling/data/models/item_group/item_group_response.dart';
import 'package:flutter/material.dart';
import 'package:facebilling/core/const.dart';
import '../../../../data/services/item_group_service.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class Addgroupscreen extends StatefulWidget {
  final ItemGroupInfo? groupInfo;
  final Function(bool success) onSaved;
  const Addgroupscreen({
    super.key,
    this.groupInfo,
    required this.onSaved,
  });

  @override
  State<Addgroupscreen> createState() => _AddgroupscreenState();
}

class _AddgroupscreenState extends State<Addgroupscreen> {
  final _formKey = GlobalKey<FormState>();
  final ItemGroupService _service = ItemGroupService();

  bool _activeStatus = true;
  bool _loading = false;
  String? _message;
bool _isEditMode = false;
  late TextEditingController _itemGroupNameController;
  // late TextEditingController _countryNameController;
  late TextEditingController _createdUserController;

  // final FocusNode _countryIdFocus = FocusNode();
  final FocusNode _itemGroupNameFocus = FocusNode();
  final FocusNode _createdUserFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _itemGroupNameController =
        TextEditingController(text: widget.groupInfo?.itemGroupName ?? "");
    _createdUserController = TextEditingController(
        text: widget.groupInfo?.cratedUserCode?.toString() ?? userId.value!);
    _activeStatus = (widget.groupInfo?.activeStatus ?? 1) == 1;
    _isEditMode = widget.groupInfo != null;
  }

  @override
  void dispose() {
    _itemGroupNameController.dispose();
    _createdUserController.dispose();
    _itemGroupNameFocus.dispose();
    _createdUserFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _message = null;
    });
  final request = AddGroupRequest(
        itemGroupName: _itemGroupNameController.text.trim(),
        createdUserCode:  _createdUserController.text.trim(),
        createdDate:
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
        updatedUserCode: _createdUserController.text.trim(),
        activeStatus: _activeStatus ? 1 : 0,
      );
print(request.createdUserCode);
    if (_isEditMode && widget.groupInfo != null) {  
      // EDIT mode
      final response = await _service.updateItemGroup(
        widget.groupInfo!.itemGroupCode!,
        request,
      );
      _handleResponse(response.isSuccess, response.error);
    } else {
      // ADD mode
      final response = await _service.addItemGroup(request);
      _handleResponse(response.isSuccess, response.error);
    }
  
  }

  void _handleResponse(bool success, String? error) {
    setState(() {
      _loading = false;
      _message = success ? "Saved successfully!" : error;
    });
    if (success) widget.onSaved(true);
  }

  @override
  void didUpdateWidget(covariant Addgroupscreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.groupInfo != oldWidget.groupInfo) {
      _itemGroupNameController.text = widget.groupInfo?.itemGroupName ?? "";
      // _countryNameController.text = widget.countryInfo?.countryName ?? "";
      _createdUserController.text =
          widget.groupInfo?.cratedUserCode?.toString() ?? userId.value!;
      _activeStatus = (widget.groupInfo?.activeStatus ?? 1) == 1;
       _isEditMode = widget.groupInfo != null; // update button too
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.groupInfo != null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomSwitch(
              value: _activeStatus,
              title: "Active Status",
              onChanged: (val) {
                setState(() {
                  _activeStatus = val;
                });
              },
            ),
            const SizedBox(height: 26),
             SearchDropdownField<ItemGroupInfo>(
              hintText: "Group Name",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getItemGroupSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<ItemGroupInfo>()
                      .toList();
                }
                return [];
              },
              displayString: (unit) => unit.itemGroupName ?? "",
              onSelected: (country) {
                if(country != null){
                  setState(() {
                 _itemGroupNameController.text =
                      country.itemGroupName.toString();
                  _createdUserController.text =
                      country.cratedUserCode?.toString() ?? userId.value!;
                  _activeStatus = (country.activeStatus ?? 1) == 1;
                   _isEditMode = true;
                });

                // ✅ Switch form into "Update mode"
                widget.onSaved(false);
                }
             
              },
                 onSubmitted: (typedValue) {
                setState(() {
                    _itemGroupNameController.clear(); // no id since not from API
      _itemGroupNameController.text = typedValue; 
      print("_itemGroupNameController.text");// use typed text
      print(_itemGroupNameController.text);// use typed text
      _createdUserController.text = userId.value!;
      _activeStatus = true;
       _isEditMode = false;
                }); 
                widget.onSaved(false);
              },
            ),
  //           SearchDropdownField<ItemGroupInfo>(
  //             hintText: "Group Name",
  //             controller: _itemGroupNameController,
  //             prefixIcon: Icons.search,
  //             fetchItems: (q) async {
  //               final response = await _service.getItemGroupSearch(q);
  //               if (response.isSuccess) {
  //                 return (response.data?.info ?? [])
  //                     .whereType<ItemGroupInfo>()
  //                     .toList();
  //               }
  //               return [];
  //             },
  //             displayString: (country) => country.itemGroupName ?? "",
  //             onSelected: (country) {
  //               if(country !=null){
  //                 setState(() {
  //                 _itemGroupNameController.text =
  //                     country.itemGroupName.toString();
  //                 _createdUserController.text =
  //                     country.cratedUserCode?.toString() ?? userId.value!;
  //                 _activeStatus = (country.activeStatus ?? 1) == 1;
  //                  _isEditMode = true;
  //               });

  //               // ✅ Switch form into "Update mode"
  //               widget.onSaved(false); 
  //               }
               
  //             },
  //               onSubmitted: (typedValue) {
  //   // ✅ User pressed enter or confirmed text without selecting
  //   setState(() {
  //     _itemGroupNameController.clear(); // no id since not from API
  //     _itemGroupNameController.text = typedValue; 
  //     print("_itemGroupNameController.text");// use typed text
  //     print(_itemGroupNameController.text);// use typed text
  //     _createdUserController.text = userId.value!;
  //     _activeStatus = true;
  //      _isEditMode = false;
  //   });
  //   widget.onSaved(false);
  // },
  //           ),
 
            
             
            const SizedBox(height: 16),
            if (_loading)
              const CircularProgressIndicator()
            else
              Row(
                children: [
                  Expanded(
                    child: GradientButton(
                        text: _isEditMode ? "Update Group" : "Add Group",
                        onPressed: _submit),
                  ),
                ],
              ),
            if (_message != null) ...[
              const SizedBox(height: 16),
              Text(
                _message!,
                style: TextStyle(
                  color: _message!.contains("successfully")
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
