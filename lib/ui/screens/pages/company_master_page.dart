import 'package:facebilling/data/services/customer_master_service.dart';
import 'package:facebilling/ui/screens/masters/item_make_master/item_make_master_list.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../../data/models/get_all_master_list_model.dart' as master;

import '../../../data/models/company_master/company_master_list_model.dart';
import '../../../data/services/get_all_master_service.dart';
import '../masters/company_master/add_company_master_page.dart';
import '../masters/company_master/company_master__list_page.dart';
import '../masters/location_master/add_location_master.dart';
import '../masters/location_master/location_master_list.dart';

import '../masters/unit/UnitScreen.dart';

class CompanyMasterPage extends StatefulWidget {
  const CompanyMasterPage({super.key});

  @override
  State<CompanyMasterPage> createState() =>
      _CompanyMasterPageState();
}

class _CompanyMasterPageState extends State<CompanyMasterPage> {
  final _formKey = GlobalKey<FormState>();
  final CustomerMasterService _service = CustomerMasterService();
  final GetAllMasterService _getAllMasterService = GetAllMasterService();
   Info? editingUnit;
  bool refreshList = false;
  int? _taxCode, _itemGroup, _itemUnit, _itemMake, _itemGeneric;
  bool _activeStatus = true;
  bool _loading = false;
  bool _nonScheduledItem = true,
      _scheduledItem = true,
      _expiryRequired = true,
      _isNarocotic = true,
      _isBatchNumbeRequired = true,
      _isDiscountReq = true;
  String? _message;
  bool _getAllLoading = true;

  String? error;

  ///model

  master.GetAllMasterListModel? getAllMasterListModel;

  late TextEditingController _itemIdController;
  late TextEditingController _itemNameController;
  late TextEditingController _itemTypeController;
  late TextEditingController _itemGroupCodeController;
  late TextEditingController _itemUnitCodeController;
  late TextEditingController _itemMakeCodeController;
  late TextEditingController _itemGenericCodeController;
  late TextEditingController _nonScheduleItemController;
  late TextEditingController _scheduledH1ItemController;
  late TextEditingController _narcoticItemController;
  late TextEditingController _expiryDateFormatController;
  late TextEditingController _expiryDateRequiredController;
  late TextEditingController _subUnitCodeController;
  late TextEditingController _subQtyController;
  late TextEditingController _batchNoRequiredController;
  late TextEditingController _minimumStockQtyController;
  late TextEditingController _maximumStockQtyController;
  late TextEditingController _reOrderLevelController;
  late TextEditingController _reOrderQtyController;
  late TextEditingController _priceTakenFromController;
  late TextEditingController _itemDiscountPercentageController;
  late TextEditingController _itemDiscountRequiredController;
  late TextEditingController _itemDiscountValueController;
  late TextEditingController _purchaseRateWTaxController;
  late TextEditingController _purchaseRateController;
  late TextEditingController _salesRateController;
  late TextEditingController _mRPRateController;
  late TextEditingController _gstPercentageController;
  late TextEditingController _createdUserController;

  // 🔹 FocusNodes
  final FocusNode _itemIdFocus = FocusNode();
  final FocusNode _itemNameFocus = FocusNode();
  final FocusNode _itemTypeFocus = FocusNode();
  final FocusNode _itemGroupFocus = FocusNode();
  final FocusNode _itemGroupCodeFocus = FocusNode();
  final FocusNode _itemUnitCodeFocus = FocusNode();
  final FocusNode _itemMakeCodeFocus = FocusNode();
  final FocusNode _itemGenericCodeFocus = FocusNode();
  final FocusNode _nonScheduleItemFocus = FocusNode();
  final FocusNode _scheduledH1ItemFocus = FocusNode();
  final FocusNode _narcoticItemFocus = FocusNode();
  final FocusNode _expiryDateFormatFocus = FocusNode();
  final FocusNode _expiryDateRequiredFocus = FocusNode();
  final FocusNode _subUnitCodeFocus = FocusNode();
  final FocusNode _subQtyFocus = FocusNode();
  final FocusNode _batchNoRequiredFocus = FocusNode();
  final FocusNode _minimumStockQtyFocus = FocusNode();
  final FocusNode _maximumStockQtyFocus = FocusNode();
  final FocusNode _reOrderLevelFocus = FocusNode();
  final FocusNode _reOrderQtyFocus = FocusNode();
  final FocusNode _priceTakenFromFocus = FocusNode();
  final FocusNode _itemDiscountPercentageFocus = FocusNode();
  final FocusNode _itemDiscountRequiredFocus = FocusNode();
  final FocusNode _itemDiscountValueFocus = FocusNode();
  final FocusNode _purchaseRateWTaxFocus = FocusNode();
  final FocusNode _purchaseRateFocus = FocusNode();
  final FocusNode _salesRateFocus = FocusNode();
  final FocusNode _mRPRateFocus = FocusNode();
  final FocusNode _gstPercentageFocus = FocusNode();
  final FocusNode _createUserFocus = FocusNode();

  void _onSaved(bool success) {
    if (success) {
      setState(() {
        editingUnit = null; // reset after save
        refreshList = true; // trigger reload
      });
    }
  }

  void _showAddEditBottomSheet(Info? unit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ensures full-screen height
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // handle keyboard
        ),
        child: SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.85, // almost full screen
          child: AddCompanyMasterPage(
            unitInfo: unit,
            onSaved: (success) {
              Navigator.pop(context); // close sheet
              _onSaved(success);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: lightgray,
      body: isMobile
          ? Padding(
              padding: const EdgeInsets.all(18.0),
              child: CompanyMasterListPage(
                refreshList: refreshList,
                onEdit: (country) {
                  _showAddEditBottomSheet(
                      country as Info?); // ✅ open bottom sheet for edit
                },
              ),
            )
          : Row(
              children: [
                // Left side: Country list
          /*      Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CompanyMasterListPage(
                      refreshList: refreshList,
                      onEdit: (country) {
                        setState(() {
                          editingUnit = country;
                          refreshList = false;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(color: gray, width: 1),
                const SizedBox(width: 20),*/
                // Right side: Add/Edit form
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: AddCompanyMasterPage(
                      unitInfo: editingUnit,
                      onSaved: _onSaved,
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: isMobile
          ? FloatingActionButton.extended(
              backgroundColor: primary,
              foregroundColor: white,
              onPressed: () => _showAddEditBottomSheet(null), // ✅ Add Country
              label: const Text("Add Country"),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }
}
