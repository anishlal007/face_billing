import 'package:flutter/material.dart';

import '../../../../core/colors.dart';

class HomeBody extends StatelessWidget {
  final Widget page;

  const HomeBody({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: black), 
      ),
      color: lightgray,
      child: page,
    );
  }
}
