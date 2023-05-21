import 'package:flutter/material.dart';
import 'package:lab_assign_2/loginscreen.dart';
import 'package:lab_assign_2/registrationscreen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String maintitle = "Profile";
  int _currIndex = 2;

  @override
  void initState(){
    super.initState();
    print("Profile");
  }

  @override
  void dispose(){
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Flexible(
          flex: 4,
          child: Card(
            elevation: 10,
            child: Row(
              children: [
         
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    shrinkWrap: true,
                    children:  [
                      MaterialButton(
                    onPressed: (){
                      Navigator.push(context, 
      MaterialPageRoute(builder: (content) => const RegisterScreen()));
                    },
                    child: const Text("REGISTER",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                   const Divider(
                    height: 2,
                  ),

                   MaterialButton(
                    onPressed: (){
                      Navigator.push(context, 
      MaterialPageRoute(builder: (content) => const LoginScreen()));
                    },
                    child: const Text("LOG IN",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                   const Divider(
                    height: 2,
                  ),
                    ],
                  )
                  ),
              ], 
            ),
          ),
        )
      ]),
      //child: Text(maintitle),
    );
  }

  /*void _register() {
    showDialog(context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register New Account",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: const Text("Are you sure?", style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold),),
            actions: <Widget>[
              TextButton(
                child: const Text("Yes"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("No"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
      );
    }
    );
  }*/
}