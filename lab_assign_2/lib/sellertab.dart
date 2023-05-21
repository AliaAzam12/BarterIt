import 'package:flutter/material.dart';

class SellerTab extends StatefulWidget {
  const SellerTab({super.key});

  @override
  State<SellerTab> createState() => _SellerTabState();
}

class _SellerTabState extends State<SellerTab> {
  String maintitle = "Seller";
  int _currIndex = 1;

  @override
  void initState(){
    super.initState();
    print("Seller");
  }

  @override
  void dispose(){
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(maintitle),
    );
  }
}