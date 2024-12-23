import 'dart:convert';
import 'dart:ui';

import 'package:blissfullden_app/pages/tasks/create.dart';
import 'package:blissfullden_app/pages/tasks/task.dart';
import 'package:blissfullden_app/pages/tasks/update.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class MyHomePage extends StatefulWidget {
  // ignore: use_super_parameters
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  var url = Uri.parse('http://127.0.0.1:8000/tasks/');

  List<Task> tasks = [];

  @override
  void initState() {
    _retrieveTasks();
    super.initState();
  }

  void _retrieveTasks() async {
    tasks = [];
    var response = await client.get(url);
    debugPrint("response: ${response.body}");

    List responseList = jsonDecode(response.body);

    for (var element in responseList) {
      tasks.add(Task.fromMap(element));
    }

    debugPrint("Tasks: ${tasks.length}");

    setState(() {});
  }

  void _deleteTask(int id) {
    var deleteUrl = Uri.parse('http://127.0.0.1:8000/tasks/$id/delete/');
    client.delete(deleteUrl);
    _retrieveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with blur effect
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "lib/images/Pin by Renée on wallpaper _ Scenery wallpaper, Beautiful art pictures, Aesthetic backgrounds.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          // Content overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: const Color.fromARGB(255, 68, 60, 231).withOpacity(0.1), // Adjust opacity as needed
              child: RefreshIndicator(
                onRefresh: () async {
                  _retrieveTasks();
                },
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        tasks[index].task, style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdatePage(
                              client: client,
                              id: tasks[index].id,
                              task: tasks[index].task,
                            ),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTask(tasks[index].id),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreatePage(
              client: client,
            ),
          ),
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
