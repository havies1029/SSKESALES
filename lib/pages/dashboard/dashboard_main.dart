import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/menu_all.dart';

class DashboardMain extends StatelessWidget {
  const DashboardMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: MenuAllWidget(),
    );
  }
}
