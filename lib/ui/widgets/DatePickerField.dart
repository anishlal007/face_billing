import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final DateTime? initialDate;
  final void Function(DateTime)? onDateSelected;

  const DatePickerField({
    super.key,
    required this.label,
    required this.controller,
    this.initialDate,
    this.onDateSelected,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isCalendarVisible = false;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isCalendarVisible = false;
  }

  void _toggleCalendar() {
    if (_isCalendarVisible) {
      _removeOverlay();
      return;
    }

    final overlay = Overlay.of(context);
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy + size.height + 4,
        width: size.width,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: CalendarDatePicker(
            initialDate: widget.initialDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            onDateChanged: (date) {
              final formatted = DateFormat('dd-MM-yyyy').format(date);
              widget.controller.text = formatted;
              widget.onDateSelected?.call(date);
              _removeOverlay();
            },
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    _isCalendarVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 30,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 12.0, height: 1.0, color: Colors.black),
                    controller: widget.controller,
                    readOnly: true,
                    onTap: _toggleCalendar,
                    decoration: InputDecoration(
                      hintText: widget.label,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today, size: 18),
                    ),
                  ),
                ),
                SizedBox(
                  width: 37,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
