import 'package:flutter/material.dart';
import 'package:lab_assign_2/searchtab.dart';
import 'package:lab_assign_2/profiletab.dart';
import 'package:lab_assign_2/sellertab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late List<Widget> tabchildren;
  int _currIndex = 0;
  String maintitle = "Search";

  @override
  void initState(){
    super.initState();
    tabchildren = const [
      SearchTab(),
      SellerTab(),
      ProfileTab(),
    ];
  }

  @override
  void dispose(){
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(maintitle),),
      body: tabchildren[_currIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.search, ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.store_mall_directory, ),
              label: "Seller"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, ), label: "Profile")
        ],
      ),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currIndex = value;
      if(_currIndex == 0){
        maintitle = "Search";
      }
      if(_currIndex == 1){
        maintitle = "Seller";
      }
      if(_currIndex == 2){
        maintitle = "Profile";
      }
    });
  }
}