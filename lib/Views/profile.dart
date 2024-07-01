import 'package:flutter/material.dart';
import 'package:login_sql/Components/button.dart';
import 'package:login_sql/Components/colors.dart';
import 'package:login_sql/JSON/users.dart';
import 'package:login_sql/Views/auth.dart';

class Profile extends StatelessWidget {
  final Users? profile;
  const Profile({super.key, this.profile});

  void signOut(BuildContext context) {
    // Navigate back to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                signOut(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: primaryColor,
                radius: 77,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/no_user.jpg"),
                  radius: 75,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                profile!.fullName ?? "",
                style: const TextStyle(fontSize: 28, color: primaryColor),
              ),
              Text(
                profile!.email ?? "",
                style: const TextStyle(fontSize: 17, color: Colors.grey),
              ),
              Button(
                  label: "SIGN OUT",
                  press: () {
                    signOut(context);
                  }),
              ListTile(
                leading: const Icon(Icons.person, size: 30),
                subtitle: const Text("Full name"),
                title: Text(profile!.fullName ?? ""),
              ),
              ListTile(
                leading: const Icon(Icons.email, size: 30),
                subtitle: const Text("Email"),
                title: Text(profile!.email ?? ""),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle, size: 30),
                subtitle: Text(profile!.usrName),
                title: const Text("admin"),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
