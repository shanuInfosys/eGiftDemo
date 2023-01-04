import 'package:e_gift_shoppe/Database/CredentialDatabase.dart';
import 'package:e_gift_shoppe/Database/Database.dart';
import 'package:e_gift_shoppe/User/user_Home_Page.dart';
import 'package:flutter/material.dart';
import 'Admin/admin_Home_Page.dart';
import 'SignUp.dart';
import 'DataBaseClasses/userCredentials.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyStateFulWidget(),
      ),
    );
  }
}

class MyStateFulWidget extends StatefulWidget {
  const MyStateFulWidget({super.key});

  @override
  State<MyStateFulWidget> createState() => _MyStateFulWidgetState();
}

class _MyStateFulWidgetState extends State<MyStateFulWidget> {
  // Controller for used name and password
  TextEditingController userNameConrtoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<UserCredentials> userCredentialsList = [];

  @override
  initState() {
    super.initState();
    fetchUserCredentialList();
    if (userCredentialsList.length == 0) {
      saveUserCredentialsIntoDataBase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView(
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
          SizedBox(height: 50, width: 40),
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
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Password',
                ),
              )),
          SizedBox(height: 20, width: 20),
          Container(
            height: 50,
            width: 150,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                if (checkIfAdminExist() == true && checkUserType() == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => admin_Home_Page()),
                  );
                } else {
                  navigateToUserHomePage();
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Dont have an account?'),
              TextButton(
                  onPressed: () {
                    // Sign Up Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          )
        ],
      ),
    );
  }

  fetchUserCredentialList() {
    Future<List<UserCredentials>> userCredentialListFuture =
        DBProvider.db.getAllUserCredentials();
    userCredentialListFuture.then((userCredentialsList) {
      setState(() {
        print("Admin User Data is $userCredentialsList");
        this.userCredentialsList = userCredentialsList;
      });
    }, onError: (error) {
      print(error.toString());
    });
  }

  bool checkIfAdminExist() {
    bool adminExists = false;
    for (int index = 0; index < userCredentialsList.length; index++) {
      if (userCredentialsList[index].username == userNameConrtoller.text) {
        adminExists = true;
        break;
      } else {
        adminExists = false;
      }
    }
    return adminExists;
  }

  saveUserCredentialsIntoDataBase() async {
    Future<int?> result;
    var userCredentials = UserCredentials(
        username: "admin1@gmail.com",
        password: "admin1234@",
        type: "admin",
        name: 'Admin');
    result = DBProvider.db.addUserCredentials(userCredentials);
    if (result != 0) {
      print("Data Saved Successfully"); // Success
      fetchUserCredentialList();
    } else {
      print("Error In Saving Data"); // Failure
    }
  }

  void navigateToUserHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => user_Home_Page()),
    );
  }

  bool checkUserType() {
    bool userType = false;
    for (int index = 0; index < userCredentialsList.length; index++) {
      if (userCredentialsList[index].username == userNameConrtoller.text &&
          userCredentialsList[index].type == "admin") {
        userType = true;
        break;
      } else {
        userType = false;
      }
    }
    return userType;
  }
}
