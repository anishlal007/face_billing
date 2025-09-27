import 'package:flutter/material.dart';

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
              : SizedBox()
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
