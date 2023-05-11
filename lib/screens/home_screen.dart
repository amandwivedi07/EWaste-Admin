import 'dart:async';

import 'package:admin/screens/listing_screen.dart';
import 'package:admin/screens/order_screen.dart';
import 'package:admin/screens/rider_screen.dart';
import 'package:admin/screens/user_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';

import '../screens/dashboard_screen.dart';
import 'login_screen.dart';

class SideMenu extends StatefulWidget {
  static const String id = 'side-screen';

  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Widget _selectedScreen = const DashBoardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashBoardScreen.id:
        setState(() {
          _selectedScreen = const DashBoardScreen();
        });
        break;

      case CustomerScreen.id:
        setState(() {
          _selectedScreen = const CustomerScreen();
        });
        break;
      case ListingScreen.id:
        setState(() {
          _selectedScreen = const ListingScreen();
        });
        break;

      case RiderScreen.id:
        setState(() {
          _selectedScreen = const RiderScreen();
        });
        break;
    }
  }

  String timeText = "";
  String dateText = "";

  String formatCurrentLiveTime(DateTime time) {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date) {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime() {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if (mounted) {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    //time
    timeText = formatCurrentLiveTime(DateTime.now());

    //date
    dateText = formatCurrentDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLiveTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: Text(
              "Logout".toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(40),
              primary: Colors.blue,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => LoginScreen()));
            },
          ),
        ],
        title: const Text('DeTrash Admin'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashBoardScreen.id,
            icon: Icons.dashboard,
          ),

          AdminMenuItem(
            title: 'Users',
            route: CustomerScreen.id,
            icon: IconlyLight.user2,
          ),
          AdminMenuItem(
            title: 'Listing',
            route: ListingScreen.id,
            icon: Icons.shopping_bag_outlined,
          ),
          AdminMenuItem(
              title: 'Orders',
              route: OrderScreen.id,
              icon: Icons.shopping_bag_outlined),

          // AdminMenuItem(
          //   title: 'Vendor Report ',
          //   route: VendorReport.id,
          //   // icon: IconlyLight.addUser,
          //   icon: Icons.calendar_month,
          // ),
          AdminMenuItem(
            title: 'Rider',
            route: RiderScreen.id,
            icon: Icons.motorcycle,
          ),
          // AdminMenuItem(
          //   title: 'Rider Report',
          //   route: RiderReport.id,
          //   icon: Icons.calendar_month_outlined,
          // ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          screenSelector(item);
          // if (item.route != null) {
          //   Navigator.of(context).pushNamed(item.route!);
          // }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              timeText + dateText,
              style: const TextStyle(
                fontSize: 16,
                letterSpacing: 1,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(child: _selectedScreen),
    );
  }
}
