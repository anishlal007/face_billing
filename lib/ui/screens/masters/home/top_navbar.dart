import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final user = await SharedPreferenceHelper.getUser();
    setState(() {
      _username = user?.userName ?? "Guest";
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.white,
      title: Row(
        children: [
           Text(_username!, style: TextStyle(color: Colors.black)),
          const SizedBox(width: 30),
          if (!isMobile)
            IconButton(
              icon: Icon(
                widget.isMenuCollapsed ? Icons.menu_open : Icons.menu,
                color: Colors.black,
              ),
              onPressed: widget.onToggleMenu,
            ),
          const SizedBox(width: 100),
          Text(widget.title, style: const TextStyle(color: Colors.black)),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.black),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: Colors.black),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: Colors.black),
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
          icon: const Icon(Icons.logout, color: Colors.black),
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