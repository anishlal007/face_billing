import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';

import '../../../data/models/get_dashboard_detail_model.dart';
import '../../../data/services/dashboard_service.dart';

class DashboardPage extends StatefulWidget {
  final String title;

  const DashboardPage({super.key, required this.title});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardService _service = DashboardService();
  GetDashboardDetailModel? data;

  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _getDetails();
  }

  Future<void> _getDetails() async {
    final response = await _service.getDashboardDeatisl();
    if (response.isSuccess) {
      setState(() {
        data = response.data!;
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    if (loading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text("Error: $error"));

    // Prepare items dynamically from API response
    final List<Map<String, dynamic>> items = [
      {
        "name": "Purchase",
        "length": data?.info?.purchase?.length ?? 0,
      },
      {
        "name": "Customers",
        "length": data?.info?.customers != null ? 1 : 0,
      },
      {
        "name": "Suppliers",
        "length": data?.info?.suppliers != null ? 1 : 0,
      },
      {
        "name": "Products",
        "length": data?.info?.products != null ? 1 : 0,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isMobile
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildCard(item),
                  );
                },
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _buildCard(item);
                },
              ),
      ),
    );
  }

Widget _buildCard(Map<String, dynamic> item) {
  return Container(
    height: 150, // Adjust as needed
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: gray,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Stack(
      children: [
        // Top border with name
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 50, // Top border height
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              item['name'],
              style: const TextStyle(
                color: white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Length in the center
        Center(
          child: Text(
            "Length: ${item['length']}",
            style: const TextStyle(
              color:black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
}