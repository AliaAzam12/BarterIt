import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String maintitle = "Search";
  int _currIndex = 0;

  @override
  void initState(){
    super.initState();
    print("Search");
  }

  @override
  void dispose(){
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(maintitle),
    );
  }
}