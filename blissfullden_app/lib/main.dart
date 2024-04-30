import 'dart:convert';

import 'package:blissfullden_app/task.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  var url = Uri.parse('http://127.0.0.1:8000/tasks/');
  List<Task> tasks = [];

  @override
  void initState(){
    _retrieveTasks();
    super.initState();
  }

  void _retrieveTasks() async {
    tasks = [];

    List response = json.decode((await client.get(url)).body);
    response.forEach((element) { 
      tasks.add(Task.fromMap(element));
    });

    setState(() {});
  }
  void _addTask(){}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    
      body: ListView.builder(
        itemCount: tasks.length, 
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(tasks[index].task),
          );
        }, 
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      );
  }
}
