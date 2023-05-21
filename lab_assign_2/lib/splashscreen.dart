import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_assign_2/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (content) => const MainScreen()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/barter.jpg'),
                fit: BoxFit.cover
                )
            )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                  Text(
                    "BARTERIT",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  CircularProgressIndicator(),
                  Text(
                    "Version 3.0",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )

        ],
      ),
    );
  }
}