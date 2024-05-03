import 'package:flutter/material.dart';

class my_textfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const my_textfield({
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
                      borderSide: BorderSide(color: Color.fromARGB(255, 8, 0, 10))
                    ),
                    fillColor: Color.fromARGB(255, 202, 132, 230), 
                    filled: true,
                    hintText: hintText,
                  ),
                ),
              );
  }
}