import 'package:flutter/material.dart';
import 'package:facebilling/core/const.dart';
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

  bool _isEditMode = false; // <-- Tracks button text dynamically

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_countryNameFocus);
    });
    _countryIdController =
        TextEditingController(text: widget.countryInfo?.countryId ?? "");
    _countryNameController =
        TextEditingController(text: widget.countryInfo?.countryName ?? "");
    _createdUserController = TextEditingController(
        text: widget.countryInfo?.createdUserCode?.toString() ?? userId.value!);
    _activeStatus = (widget.countryInfo?.activeStatus ?? 1) == 1;

    // Set edit mode if editing existing country
    _isEditMode = widget.countryInfo != null;
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
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

    final request = AddCountryRequest(
      countryId: _countryIdController.text.trim(),
      countryName: _countryNameController.text.trim(),
      createdUserCode: int.parse(_createdUserController.text.trim()),
      activeStatus: _activeStatus ? 1 : 0,
    );

    if (_isEditMode && widget.countryInfo != null) {
      // EDIT mode
      final response = await _service.updateCountry(
        widget.countryInfo!.countryCode!,
        request,
      );
      _handleResponse(response.isSuccess, response.error);
    } else {
      // ADD mode
      final response = await _service.addCountry(request);
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
        widget.countryInfo?.createdUserCode?.toString() ?? userId.value!;
    _activeStatus = (widget.countryInfo?.activeStatus ?? 1) == 1;
    _isEditMode = widget.countryInfo != null; // update button too
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 26),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomSwitch(
                  value: _activeStatus,
                  title: "Is Discount Required",
                  onChanged: (val) {
                    setState(() {
                      _activeStatus = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            SearchDropdownField<CountryInfo>(
              controller: _countryNameController,
              hintText: "Country Name",
              prefixIcon: Icons.search,
              fetchItems: (q) async {
                final response = await _service.getCountriesSearch(q);
                if (response.isSuccess) {
                  final list = (response.data?.info ?? [])
                      .whereType<CountryInfo>()
                      .toList();
                  return list;
                }
                return [];
              },
              displayString: (country) => country.countryName ?? "",
              onSelected: (country) {
                if (country != null) {
                  setState(() {
                    _countryIdController.text = country.countryId ?? "";
                    _countryNameController.text = country.countryName ?? "";
                    _createdUserController.text =
                        country.createdUserCode?.toString() ?? userId.value!;
                    _activeStatus = (country.activeStatus ?? 1) == 1;
                    _isEditMode = true; // <-- update button text
                  });
                  widget.onSaved(false);
                }
              },
              onSubmitted: (typedValue) {
                setState(() {
                  _countryIdController.clear();
                  _countryNameController.text = typedValue;
                  _createdUserController.text = userId.value!;
                  _activeStatus = true;
                  _isEditMode = false; // <-- back to Add mode
                });
                widget.onSaved(false);
              },
            ),
            const SizedBox(height: 16),
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
              onEditingComplete: _submit,
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
            if (_loading)
              const CircularProgressIndicator()
            else
              GradientButton(
                  text: _isEditMode ? "Update Country" : "Add Country",
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