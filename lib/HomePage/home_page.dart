// ignore_for_file: library_private_types_in_public_api, avoid_print, deprecated_member_use
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doodhwala/Add_Data/Add_User_Name_data/add_user_name_data.dart';
import 'package:doodhwala/HomePage/user_name_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  static final List<Widget> _pages = <Widget>[
          Dudhwale(),
    const AddDataForm(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Build Home Page");
    return Scaffold(

      body: _pages[_selectedIndex],

      backgroundColor: Colors.deepPurple.shade400,

        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
            color: Colors.deepPurple.shade100,
            // buttonBackgroundColor: Colors.red,
            backgroundColor: Colors.deepPurple.shade400,
            animationCurve: Curves.easeInOut,
            animationDuration:const Duration(milliseconds: 600),
            index: 0,
            height: 70.0,

            items:  [
              SvgPicture.asset('assets/icons/homesv.svg', height: 25, width:25,
                 color: Colors.deepPurple,),
              const Icon(Icons.add_box_rounded, size: 30, color: Colors.deepPurple,),
              // Add PNG Image

            ],
          onTap: _onItemTapped,
          letIndexChange: (index) => true,
       ),

    );
  }
}

// Setting Class
class Setting extends StatelessWidget
{
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      body: const  Center(
          child: Text("Setting Page")),
    );
  }
}
