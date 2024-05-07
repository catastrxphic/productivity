import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreatePage extends StatefulWidget {
  final Client client;

  const CreatePage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  CreatePageState createState() => CreatePageState();
}

class CreatePageState extends State<CreatePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Creation Center"),
      ),
      body: Stack(
        children: [
          SizedBox(height: 100), 
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/sakuravending.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: controller,
                      maxLines: 10,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        hintText: 'Enter your task here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              ElevatedButton(
                onPressed: () {
                  var createUrl =
                      Uri.parse('http://127.0.0.1:8000/tasks/create/');
                  widget.client
                      .post(createUrl, body: {'body': controller.text});
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 138, 53, 166), 
                  elevation: 5, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Button border radius
                  ),
                ),
                child: const Text("Create New Task"),
              ),
              const SizedBox(height: 200), // Adjust as needed
            ],
          ),
        ],
      ),
    );
  }
}
