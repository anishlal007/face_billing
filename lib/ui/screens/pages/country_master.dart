import 'package:facebilling/core/colors.dart';
import 'package:facebilling/ui/screens/masters/country/AddCountryScreen.dart';
import 'package:facebilling/ui/screens/masters/country/CountryScreen.dart';
import 'package:flutter/material.dart';

import '../../../data/models/country/country_response.dart';

class CountryMasterScreen extends StatefulWidget {
  const CountryMasterScreen({super.key});

  @override
  State<CountryMasterScreen> createState() => _CountryMasterScreenState();
}

class _CountryMasterScreenState extends State<CountryMasterScreen> {
  CountryInfo? editingCountry;
  bool refreshList = false;

  void _onSaved(bool success) {
    if (success) {
      setState(() {
        editingCountry = null; // reset after save
        refreshList = true; // trigger reload
      });
    }
  }

  void _showAddEditBottomSheet(CountryInfo? country) {
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
          child: AddCountryScreen(
            countryInfo: country,
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
              child: CountryScreen(
                refreshList: refreshList,
                onEdit: (country) {
                  _showAddEditBottomSheet(
                      country); // ✅ open bottom sheet for edit
                },
              ),
            )
          : Row(
              children: [
                // Left side: Country list
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CountryScreen(
                      refreshList: refreshList,
                      onEdit: (country) {
                        setState(() {
                          editingCountry = country;
                          refreshList = false;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(color: gray, width: 1),
                const SizedBox(width: 20),
                // Right side: Add/Edit form
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: AddCountryScreen(
                      countryInfo: editingCountry,
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
