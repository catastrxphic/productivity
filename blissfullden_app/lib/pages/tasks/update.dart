import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdatePage extends StatefulWidget {
  final int id;
  final String task;
  final Client client;

  const UpdatePage({
    super.key,
    required this.client,
    required this.id,
    required this.task,
  });

  @override
  UpdatePageState createState() => UpdatePageState();
}

class UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Center"),
      ),
      body: Stack(
        children: [
          const SizedBox(height: 100), 
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/sakuravending.jpeg"), // Background image
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
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
                    var updateUrl = Uri.parse('http://127.0.0.1:8000/tasks/${widget.id}/update/');
                    widget.client.put(updateUrl, body: {'body': controller.text});
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 138, 53, 166), // Button text color
                    elevation: 5, // Button elevation
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Button border radius
                    ),
                  ),
                  child: const Text("Update Task"),
                ),
              const SizedBox(height: 200), // Adjust as needed
            ],
          ),
        ],
      ),
    );
  }
}
