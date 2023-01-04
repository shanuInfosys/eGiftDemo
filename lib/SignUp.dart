import 'package:e_gift_shoppe/Database/Database.dart';
import 'package:e_gift_shoppe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'DataBaseClasses/userCredentials.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameConrtoller = TextEditingController();
  TextEditingController emailConrtoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              child: const Text(
                "E-Gift-Shopee",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w500),
              )),
          Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: userNameConrtoller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter User Name'),
              )),
          Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailConrtoller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Email Id'),
              )),
          Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Password'),
              )),
          SizedBox(height: 20, width: 20),
          Container(
            height: 50,
            width: 150,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text('Register'),
              onPressed: () {
                saveUserCredentialsIntoDataBase();
              },
            ),
          ),
        ],
      ),
    );
  }

  saveUserCredentialsIntoDataBase() async {
    Future<int?> result;
    var userCredentials = UserCredentials(
        username: userNameConrtoller.text,
        password: passwordController.text,
        type: "user",
        name: userNameConrtoller.text);
    result = DBProvider.db.addUserCredentials(userCredentials);
    if (result != 0) {
      print("Data Saved Successfully"); // Success
      navigateToLogin();
    } else {
      print("Error In Saving Data"); // Failure
    }
  }

  navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainApp()),
    );
  }
}
