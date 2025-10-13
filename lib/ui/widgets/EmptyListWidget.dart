import 'package:flutter/material.dart';

class EmptyListWidget<T> extends StatelessWidget {
  final List<T>? items;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool loading;
  final String? error;
  final String emptyMessage;
  final String? emptyImage; // path to the image asset

  const EmptyListWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.loading = false,
    this.error,
    this.emptyMessage = "No data available",
    this.emptyImage, // optional watermark image
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text("Error: $error"));
    }

    if (items == null || items!.isEmpty) {
      return _buildEmptyWidget(context);
    }

    return ListView.builder(
      itemCount: items!.length,
      itemBuilder: itemBuilder,
    );
  }

  Widget _buildEmptyWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (emptyImage != null)
            Opacity(
              opacity: 0.3,
              child: Image.asset(
                emptyImage!,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          const SizedBox(height: 16),
          Text(
            emptyMessage,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
