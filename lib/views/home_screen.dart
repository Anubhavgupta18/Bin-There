import 'package:bin_there/views/pickup_service.dart';
import 'package:bin_there/views/recyclable_screen.dart';
import 'package:bin_there/views/report_pickup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:bin_there/views/manage_account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var views = [
      const PickupService(),
      const RecyclableScreen(),
      const ReportPickup(),
      const ManageAccount()
    ];
    return Scaffold(
      bottomNavigationBar: GNav(
        tabs: const [
          GButton(icon: Icons.delete, text: 'Waste Pickup'),
          GButton(icon: FontAwesomeIcons.recycle, text: 'Recycle'),
          GButton(icon: Icons.report, text: 'Report Waste'),
          GButton(icon: FontAwesomeIcons.person, text: 'Profile'),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
      ),
      body: views[_selectedIndex],
    );
  }
}
