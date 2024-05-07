import 'dart:convert';
import 'dart:ui';

import 'package:blissfullden_app/create.dart';
import 'package:blissfullden_app/task.dart';
import 'package:blissfullden_app/update.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BlissfullDen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // ignore: use_super_parameters
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

    List response = json.decode((await client.get(url)).body);
    for (var element in response) {
      tasks.add(Task.fromMap(element));
    }

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
