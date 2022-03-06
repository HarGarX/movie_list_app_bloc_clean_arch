import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffEFEFEF),
      body: Center(
        child: Text(
          'This is DashBoard view',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
