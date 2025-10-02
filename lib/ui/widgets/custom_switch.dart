import 'package:flutter/material.dart';

// class CustomSwitch extends StatefulWidget {
//   final bool value;
//   final String title;
//   final ValueChanged<bool> onChanged;

//   const CustomSwitch({
//     super.key,
//     required this.value,
//     required this.title,
//     required this.onChanged,
//   });

//   @override
//   State<CustomSwitch> createState() => _CustomSwitchState();
// }

import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final String? title;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    this.title,
    required this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.value;
  }

  void _toggleSwitch() {
    setState(() {
      _isOn = !_isOn;
    });
    widget.onChanged(_isOn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 180,
        height: 30,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: _isOn ? Colors.green : Colors.red,
        ),
        child: Stack(
          children: [
            // Active label
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _isOn ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            ),

            // Inactive label
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Inactive",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: !_isOn ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            ),

            // Sliding thumb
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: _isOn ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 90,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  _isOn ? "Active" : "Inactive",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _isOn ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class _CustomSwitchState extends State<CustomSwitch>
//     with SingleTickerProviderStateMixin {
//   late bool _isOn;

//   @override
//   void initState() {
//     super.initState();
//     _isOn = widget.value;
//   }

//   void _toggleSwitch() {
//     setState(() {
//       _isOn = !_isOn;
//     });
//     widget.onChanged(_isOn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _toggleSwitch,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         width: 40,
//         height: 20,
//         padding: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           gradient: _isOn
//               ? const LinearGradient(
//                   colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 )
//               : LinearGradient(
//                   colors: [Colors.purple.shade100, Colors.purple.shade50],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//         ),
//         child: AnimatedAlign(
//           duration: const Duration(milliseconds: 300),
//           alignment: _isOn ? Alignment.centerRight : Alignment.centerLeft,
//           child: Container(
//             width: 22,
//             height: 22,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: _isOn ? Colors.white : Colors.purple.shade300,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
