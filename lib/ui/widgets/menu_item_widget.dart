import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/menu_item.dart';

class MenuItemWidget extends StatefulWidget {
  final MenuItemData item;
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onExpandChanged;

  const MenuItemWidget({
    super.key,
    required this.item,
    this.isSelected = false,
    this.isExpanded = false,
    this.onTap,
    this.onExpandChanged,
  });

  @override
  State<MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final hasSubItems =
        widget.item.subItems != null && widget.item.subItems!.isNotEmpty;
    final color = widget.isSelected ? white : primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: hasSubItems
              ? () {
                  setState(() => _expanded = !_expanded);
                  widget.onExpandChanged?.call(_expanded);
                }
              : widget.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: widget.isSelected ? primary : transperent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(widget.item.icon, color: color, size: 16),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.item.title,
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                      fontWeight: widget.isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
                widget.isSelected
                    ? Container(
                        color: white,
                        width: 2,
                        height: 20,
                      )
                    : const SizedBox(),
                if (hasSubItems)
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: widget.isSelected ? white : primary,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
        if (hasSubItems && _expanded)
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              children: widget.item.subItems!
                  .map(
                    (subItem) => InkWell(
                      onTap: () {
                        widget.onTap?.call();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(subItem.icon, color: black, size: 16),
                            const SizedBox(width: 12),
                            Text(
                              subItem.title,
                              style:
                                  const TextStyle(color: black, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
      ],
    );
  }
}
