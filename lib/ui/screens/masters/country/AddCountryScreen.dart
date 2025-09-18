import 'package:flutter/material.dart';

import '../../../../data/models/country/add_country_request.dart';
import '../../../../data/models/country/country_response.dart';
import '../../../../data/services/country_service.dart';
import '../../../widgets/custom_switch.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/search_dropdown_field.dart';

class AddCountryScreen extends StatefulWidget {
  final CountryInfo? countryInfo;
  final Function(bool success) onSaved;

  const AddCountryScreen({
    super.key,
    this.countryInfo,
    required this.onSaved,
  });

  @override
  State<AddCountryScreen> createState() => _AddCountryScreenState();
}

class _AddCountryScreenState extends State<AddCountryScreen> {
  final _formKey = GlobalKey<FormState>();
  final CountryService _service = CountryService();

  bool _activeStatus = true;
  bool _loading = false;
  String? _message;

  late TextEditingController _countryIdController;
  late TextEditingController _countryNameController;
  late TextEditingController _createdUserController;

  final FocusNode _countryIdFocus = FocusNode();
  final FocusNode _countryNameFocus = FocusNode();
  final FocusNode _createdUserFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _countryIdController =
        TextEditingController(text: widget.countryInfo?.countryId ?? "");
    _countryNameController =
        TextEditingController(text: widget.countryInfo?.countryName ?? "");
    _createdUserController = TextEditingController(
        text: widget.countryInfo?.createdUserCode?.toString() ?? "1001");
    _activeStatus = (widget.countryInfo?.activeStatus ?? 1) == 1;
  }

  @override
  void dispose() {
    _countryIdController.dispose();
    _countryNameController.dispose();
    _createdUserController.dispose();
    _countryIdFocus.dispose();
    _countryNameFocus.dispose();
    _createdUserFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _message = null;
    });

    if (widget.countryInfo == null) {
      // ADD mode
      final request = AddCountryRequest(
        countryId: _countryIdController.text.trim(),
        countryName: _countryNameController.text.trim(),
        createdUserCode: int.parse(_createdUserController.text.trim()),
        activeStatus: _activeStatus ? 1 : 0,
      );
      final response = await _service.addCountry(request);
      _handleResponse(response.isSuccess, response.error);
    } else {
      // EDIT mode
      final updated = AddCountryRequest(
        countryId: _countryIdController.text.trim(),
        countryName: _countryNameController.text.trim(),
        createdUserCode: int.parse(_createdUserController.text.trim()),
        activeStatus: _activeStatus ? 1 : 0,
      );
      final response = await _service.updateCountry(
        widget.countryInfo!.countryCode!,
        updated,
      );
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
  void didUpdateWidget(covariant AddCountryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.countryInfo != oldWidget.countryInfo) {
      _countryIdController.text = widget.countryInfo?.countryId ?? "";
      _countryNameController.text = widget.countryInfo?.countryName ?? "";
      _createdUserController.text =
          widget.countryInfo?.createdUserCode?.toString() ?? "1001";
      _activeStatus = (widget.countryInfo?.activeStatus ?? 1) == 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.countryInfo != null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SearchDropdownField<CountryInfo>(
              hintText: "Search Country",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getCountriesSearch(q);
                if (response.isSuccess) {
                  return (response.data?.info ?? [])
                      .whereType<CountryInfo>()
                      .toList();
                }
                return [];
              },
              displayString: (country) => country.countryName ?? "",
              onSelected: (country) {
                setState(() {
                  _countryIdController.text = country.countryId ?? "";
                  _countryNameController.text = country.countryName ?? "";
                  _createdUserController.text =
                      country.createdUserCode?.toString() ?? "1001";
                  _activeStatus = (country.activeStatus ?? 1) == 1;
                });

                // ✅ Switch form into "Update mode"
                widget.onSaved(false);
              },
            ),

            const SizedBox(height: 26),
            // SwitchListTile(
            //   value: _activeStatus,
            //   title: const Text("Active Status"),
            //   onChanged: (val) => setState(() => _activeStatus = val),
            // ),
            CustomSwitch(
              value: _activeStatus,
              title: "Active Status",
              onChanged: (val) {
                setState(() {
                  _activeStatus = val;
                });
              },
            ),
            CustomTextField(
              title: "Country Code",
              hintText: "Enter Country Code",
              controller: _countryIdController,
              prefixIcon: Icons.flag_circle,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter country ID" : null,
              focusNode: _countryIdFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_countryNameFocus);
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              title: "Country Name",
              hintText: "Enter Country Name",
              controller: _countryNameController,
              prefixIcon: Icons.flag,
              isValidate: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter country name" : null,
              focusNode: _countryNameFocus,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_createdUserFocus);
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              title: "Create User",
              controller: _createdUserController,
              prefixIcon: Icons.person,
              isEdit: true,
              focusNode: _createdUserFocus,
              textInputAction: TextInputAction.done,
              onEditingComplete: _submit,
            ),
            const SizedBox(height: 16),
            // SwitchListTile(
            //   value: _activeStatus,
            //   title: const Text("Active Status"),
            //   onChanged: (val) => setState(() => _activeStatus = val),
            // ),
            const SizedBox(height: 16),
            if (_loading)
              const CircularProgressIndicator()
            else
              GradientButton(
                  text: isEdit ? "Update Country" : "Add Country",
                  onPressed: _submit),
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
