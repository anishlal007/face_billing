import 'package:flutter/material.dart';

import '../../../../core/preference_helper.dart';
import '../../pages/login_page.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
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
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Text("FaceBilling", style: const TextStyle(color: Colors.black)),
          const SizedBox(width: 30),
          !isMobile
              ? IconButton(
                  icon: Icon(
                    isMenuCollapsed ? Icons.menu_open : Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: onToggleMenu,
                )
              : SizedBox(),
const SizedBox(width: 100,),
               Text(title, style: const TextStyle(color: Colors.black)),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black)),
       
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black)),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.black)),
            IconButton(
  onPressed: () async {
    // 1. Clear token and user
    await SharedPreferenceHelper.clearToken();
    await SharedPreferenceHelper.clearUser();

    // 2. Update global token if using ValueNotifier
    // globalToken.value = null; // uncomment if you have global token

    // 3. Navigate to LoginPage and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WebmailLoginScreen()),
      (route) => false, // remove all previous routes
    );
  },
  icon: const Icon(Icons.logout, color: Colors.black),
),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
