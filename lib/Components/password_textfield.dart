import 'package:flutter/material.dart';
import 'package:login_sql/Components/colors.dart';

class PasswordTextfield extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordTextfield({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.validator,
  });

  @override
  _PasswordTextfieldState createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: size.width * .9,
      height: 55,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextFormField(
          obscureText: !isVisible,
          controller: widget.controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
            icon: Icon(widget.icon),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
