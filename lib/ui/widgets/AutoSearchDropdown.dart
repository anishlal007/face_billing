import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// 1. Make the class generic with Type Parameter <T>
class AutoSuggestion<T> extends StatelessWidget {
  final TextEditingController controller;

  // 2. Abstract the suggestion fetching logic
  // This function will be provided by the calling screen (e.g., ProductPage)
  final Future<List<T>> Function(String pattern) suggestionsCallback;

  // 3. Abstract the UI for each suggestion item
  // This function tells the widget how to display a single item of type T
  final Widget Function(BuildContext context, T suggestion) itemBuilder;

  // 4. Abstract the selection action
  // This function tells the widget what to do when an item is selected
  final void Function(T suggestion) onSuggestionSelected;

  // 5. Abstract how to get the text to display in the TextField after selection
  final String Function(T suggestion) getDisplayString;

  // Optional: Hint text and label for the text field
  final String labelText;
  final String hintText;
  final Widget? isbutton;
  final String addTooltip;

  const AutoSuggestion({
    super.key,
    required this.controller,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    required this.getDisplayString,
    required this.labelText,
    required this.hintText,
    this.isbutton,
    this.addTooltip = "Scan barcode",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            labelText,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 30, // Limits the overall height
          child: Row(
            children: [
              // ⭐️ FIX: Wrap TypeAheadField in Expanded to give it bounded width
              Expanded(
                child: TypeAheadField<T>(
                  controller: controller,
                  builder: (context, controller, focusNode) {
                    // ... (TextField setup is fine)
                    // You might need to adjust contentPadding to fit the 30px height perfectly
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(76, 0, 0, 0), width: 1.2),
                        ),
                        suffixIcon: const Icon(Icons.search, size: 18),
                      ),
                    );
                  },
                  suggestionsCallback: suggestionsCallback,
                  itemBuilder: itemBuilder,
                  onSelected: (suggestion) {
                    controller.text = getDisplayString(suggestion);
                    onSuggestionSelected(suggestion);
                  },
                ),
              ),
              if (isbutton != null)
                IconButton(
                    tooltip: addTooltip,
                    icon: const Icon(Icons.barcode_reader,
                        color: Color(0xFF0B2046), size: 20),
                    onPressed: () => {print("Scan barcode")} //_openAddPopup,
                    )
              else
                const SizedBox(width: 35),
            ],
          ),
        ),
      ],
    );
  }
}
