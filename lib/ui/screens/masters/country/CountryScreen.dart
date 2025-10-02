import 'package:flutter/material.dart';
import '../../../../data/models/country/country_response.dart';
import '../../../../data/services/country_service.dart';
import '../../../widgets/list_card_widget.dart';

class CountryScreen extends StatefulWidget {
  final bool refreshList;
  final Function(CountryInfo) onEdit; // callback for edit action

  const CountryScreen({
    super.key,
    required this.refreshList,
    required this.onEdit,
  });

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  final CountryService _service = CountryService();
  Country? country;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  @override
  void didUpdateWidget(CountryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshList && !oldWidget.refreshList) {
      _loadCountries();
    }
  }

  Future<void> _loadCountries() async {
    setState(() {
      loading = true;
      error = null;
    });

    final response = await _service.getCountries();
    if (response.isSuccess) {
      setState(() {
        country = response.data!;
        loading = false;
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
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return Center(child: Text("Error: $error"));
    }

    final infos = country?.info ?? [];

    if (infos.isEmpty) {
      return const Center(child: Text("No countries found."));
    }

    return ListView.builder(
      itemCount: infos.length,
      itemBuilder: (context, index) {
        final info = infos[index]!;

        return ListCardWidget(
          title: info.countryName ?? "",
          subtitle: "Code: ${info.countryId ?? ""}",
          initials: info.countryId?.substring(0, 2).toUpperCase() ?? "NA",
          onEdit: () {
            // 👉 Notify parent to open AddCountryScreen in edit mode
            widget.onEdit(info);
          },
          onDelete: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete Country"),
                content: Text(
                  "Are you sure you want to delete ${info.countryName}?",
                ),
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
              final response = await _service.deleteCountry(info.countryCode!);
              if (response.isSuccess) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Deleted ${info.countryName}")),
                  );
                  _loadCountries(); // refresh list
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${response.error}")),
                  );
                }
              }
            }
          },
          isviewcircleavathar: true,
        );
      },
    );
  }
}