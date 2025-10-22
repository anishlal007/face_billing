// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

// // 1. Make the class generic with Type Parameter <T>
// class AutoSuggestion<T> extends StatelessWidget {
//   final TextEditingController controller;

//   // 2. Abstract the suggestion fetching logic
//   // This function will be provided by the calling screen (e.g., ProductPage)
//   final Future<List<T>> Function(String pattern) suggestionsCallback;

//   // 3. Abstract the UI for each suggestion item
//   // This function tells the widget how to display a single item of type T
//   final Widget Function(BuildContext context, T suggestion) itemBuilder;

//   // 4. Abstract the selection action
//   // This function tells the widget what to do when an item is selected
//   final void Function(T suggestion) onSuggestionSelected;

//   // 5. Abstract how to get the text to display in the TextField after selection
//   final String Function(T suggestion) getDisplayString;

//   // Optional: Hint text and label for the text field
//   final String labelText;
//   final String hintText;
//   final Widget? isbutton;
//   final String addTooltip;

//   const AutoSuggestion({
//     super.key,
//     required this.controller,
//     required this.suggestionsCallback,
//     required this.itemBuilder,
//     required this.onSuggestionSelected,
//     required this.getDisplayString,
//     required this.labelText,
//     required this.hintText,
//     this.isbutton,
//     this.addTooltip = "Scan barcode",
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 8.0),
//           child: Text(
//             labelText,
//             style: const TextStyle(fontSize: 12, color: Colors.black),
//           ),
//         ),
//         SizedBox(
//           height: 30, // Limits the overall height
//           child: Row(
//             children: [
//               // ⭐️ FIX: Wrap TypeAheadField in Expanded to give it bounded width
//               Expanded(
//                 child: TypeAheadField<T>(
//                   controller: controller,
//                   builder: (context, controller, focusNode) {
//                     // ... (TextField setup is fine)
//                     // You might need to adjust contentPadding to fit the 30px height perfectly
//                     return TextField(
//                       controller: controller,
//                       focusNode: focusNode,
//                       decoration: InputDecoration(
//                         hintText: hintText,
//                         hintStyle:
//                             const TextStyle(fontSize: 12, color: Colors.grey),
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 0.0, horizontal: 12.0),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(2),
//                           borderSide: const BorderSide(
//                               color: Color.fromARGB(76, 0, 0, 0), width: 1.2),
//                         ),
//                         suffixIcon: const Icon(Icons.search, size: 18),
//                       ),
//                     );
//                   },
//                   suggestionsCallback: suggestionsCallback,
//                   itemBuilder: itemBuilder,
//                   onSelected: (suggestion) {
//                     controller.text = getDisplayString(suggestion);
//                     onSuggestionSelected(suggestion);
//                   },
//                 ),
//               ),
//               if (isbutton != null)
//                 IconButton(
//                     tooltip: addTooltip,
//                     icon: const Icon(Icons.barcode_reader,
//                         color: Color(0xFF0B2046), size: 20),
//                     onPressed: _openAddPopup,
//                     )
//               else
//                 const SizedBox(width: 35),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// Note: You must ensure flutter_typeahead is in your pubspec.yaml

// 1. Convert to StatefulWidget to manage behavior like opening a dialog
class AutoSuggestion<T> extends StatefulWidget {
  final TextEditingController controller;
  final Future<List<T>> Function(String pattern) suggestionsCallback;
  final Widget Function(BuildContext context, T suggestion) itemBuilder;
  final void Function(T suggestion) onSuggestionSelected;
  final String Function(T suggestion) getDisplayString;
  final String labelText;
  final String hintText;
  final List<T>? items;
  final void Function(T)? onChanged;

  // ⭐️ New parameter to hold the content of the popup
  final Widget? addPage;
  final VoidCallback? onEditingComplete;

  // Existing button-related parameters
  final Widget? isbutton;
  final String addTooltip;

  const AutoSuggestion({
    super.key,
    required this.controller,
    this.items,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    required this.getDisplayString,
    required this.labelText,
    required this.hintText,
    this.onEditingComplete,
    this.onChanged,
    this.isbutton,
    this.addPage, // ⭐️ Make sure this is passed in the constructor
    this.addTooltip = "Scan barcode",
  });

  @override
  State<AutoSuggestion<T>> createState() => _AutoSuggestionState<T>();
}

class _AutoSuggestionState<T> extends State<AutoSuggestion<T>> {
  // ⭐️ 1. Define the function to open the popup/dialog

  T? _selectedItem;
  void _openAddPopup() {
    if (widget.addPage != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
            child: widget.addPage!,
          ),
        ),
      ).then((value) {
        if (value is T) {
          setState(() {
            widget.items!.add(value);
            _selectedItem = value;
          });
          widget.onChanged?.call(value);
          widget.onEditingComplete?.call();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Added successfully")),
          );
        }
      });
    }
  }

  // ⭐️ 2. The build method is now in the State class
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Text(
            widget.labelText,
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
                  controller: widget.controller,
                  builder: (context, controller, focusNode) {
                    // ... (TextField setup is fine)
                    // You might need to adjust contentPadding to fit the 30px height perfectly
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
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
                  suggestionsCallback: widget.suggestionsCallback,
                  itemBuilder: widget.itemBuilder,
                  onSelected: (suggestion) {
                    widget.controller.text =
                        widget.getDisplayString(suggestion);
                    widget.onSuggestionSelected(suggestion);
                  },
                ),
              ),
              if (widget.addPage != null)
                IconButton(
                  tooltip: widget.addTooltip,
                  icon: const Icon(Icons.add_circle,
                      color: Color(0xFF0B2046), size: 20),
                  onPressed: _openAddPopup,
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
