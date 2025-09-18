import 'package:flutter/material.dart';

import '../../../../core/colors.dart';

class HomeBody extends StatelessWidget {
  final Widget page;

  const HomeBody({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightgray,
      child: page,
    );
  }
}
