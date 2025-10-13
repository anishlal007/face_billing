// import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';

// import 'package:facebilling/core/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../../core/preference_helper.dart';
// import '../../pages/login_page.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/colors.dart';
import '../../../../core/preference_helper.dart';
import '../../pages/login_page.dart';
class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isMenuCollapsed;
  final VoidCallback onToggleMenu;

  const TopNavBar({
    super.key,
    required this.title,
    required this.isMenuCollapsed,
    required this.onToggleMenu,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  String? _username;
  String _dateTime = ""; 
  bool get isMobile => false; // Example flag

  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _loadUsername();
     _updateTime(); // initial value
    // ⏰ Update every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateTime());
  }

  Future<void> _loadUsername() async {
    final user = await SharedPreferenceHelper.getUser();
    setState(() {
      _username = user?.userName ?? "Guest";
    });
  }


 

  void _updateTime() {
    final now = DateTime.now();
    final formatted = DateFormat('dd-MM-yyyy  hh:mm a').format(now); // 12-hour format with AM/PM
    setState(() {
      _dateTime = formatted;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();  
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: white,
      title: Row(
        children: [
           Text(_username ?? "", style: TextStyle(color: black)),
          const SizedBox(width: 30),
          if (!isMobile)
            IconButton(
              icon: Icon(
                widget.isMenuCollapsed ? Icons.menu_open : Icons.menu,
                color: black,
              ),
              onPressed: widget.onToggleMenu,
            ),
          const SizedBox(width: 100),
          Text(widget.title, style: const TextStyle(color: black)),
        ],
      ),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Manoj Eye Hospital", style: TextStyle(
                  color:black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                // current Date and Time
         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              _dateTime,
              style: const TextStyle(color: black, fontSize: 13),
            ),
          ),
          ],
        ),
        
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: black),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: black),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: black),
        ),
        // 👇 Logout button
        IconButton(
          onPressed: () async {
            await SharedPreferenceHelper.clearAll();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const WebmailLoginScreen()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.logout, color: black),
        ),

        // 👇 Display Username
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: const AssetImage("assets/profile.jpg"),
                radius: 18,
              ),
              // const SizedBox(width: 8),
              // Text(
              //   _username ?? "",
              //   style: const TextStyle(color: Colors.black, fontSize: 14),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}