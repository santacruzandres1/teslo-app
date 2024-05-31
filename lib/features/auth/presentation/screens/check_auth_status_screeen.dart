import 'package:flutter/material.dart';


class CheckAuthStatusScreeen extends StatelessWidget {
  const CheckAuthStatusScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
