import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: TextField(
                  controller: controller,
                  obscureText: obscureText ,
                  decoration: InputDecoration(
                    enabledBorder:const OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 227, 167, 76))
                    ),
                    fillColor: Color.fromARGB(255, 183, 186, 191), 
                    filled: true,
                    hintText: hintText,
                  ),
                ),
              );
  }
}