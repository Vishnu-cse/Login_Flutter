import 'package:flutter/material.dart';
import 'package:login_sql/Components/button.dart';
import 'package:login_sql/Components/colors.dart';
import 'package:login_sql/Components/password_textfield.dart';
import 'package:login_sql/Components/textfield.dart';
import 'package:login_sql/JSON/users.dart';
import 'package:login_sql/Views/login.dart';
import 'package:sqflite/sqflite.dart';

import '../SQLite/database_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controllers
  final fullName = TextEditingController();
  final email = TextEditingController();
  final usrName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final db = DatabaseHelper();

  // Form key
  final _formKey = GlobalKey<FormState>();

  signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        var res = await db.createUser(Users(
            fullName: fullName.text,
            email: email.text,
            usrName: usrName.text,
            password: password.text));
        if (res > 0) {
          if (!mounted) return;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      } on DatabaseException catch (e) {
        if (e.isUniqueConstraintError()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Username already exists. Please choose another one.'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to sign up: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        print("Error occurred: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign up: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Register New Account",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 55,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InputField(
                    hint: "Full name",
                    icon: Icons.person,
                    controller: fullName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  InputField(
                    hint: "Email",
                    icon: Icons.email,
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  InputField(
                    hint: "Username",
                    icon: Icons.account_circle,
                    controller: usrName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  PasswordTextfield(
                    hint: "Password",
                    icon: Icons.lock,
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  PasswordTextfield(
                    hint: "Re-enter password",
                    icon: Icons.lock,
                    controller: confirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please re-enter your password';
                      } else if (value != password.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Button(
                    label: "SIGN UP",
                    press: () {
                      signUp();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: Text("LOGIN"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
