// import 'dart:convert';

// import 'package:blissfullden_app/create.dart';
// import 'package:blissfullden_app/task.dart';
// import 'package:blissfullden_app/update.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'BlissfullDen'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Client client = http.Client();
//   var url = Uri.parse('http://127.0.0.1:8000/tasks/');

//   List<Task> tasks = [];

//   @override
//   void initState(){
//     _retrieveTasks();
//     super.initState();
//   }

//   void _retrieveTasks() async {
//     tasks = [];

//     List response = json.decode((await client.get(url)).body);
//     for (var element in response) {
//       tasks.add(Task.fromMap(element));
//     }

//     setState(() {});  
//   }

//   void _deleteTask(int id){
//     var deleteUrl = Uri.parse('http://127.0.0.1:8000/tasks/$id/delete/');
//     client.delete(deleteUrl);
//     _retrieveTasks();
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
    
//       body: RefreshIndicator(
//         onRefresh: () async {
//           _retrieveTasks();
//         },
//         child: ListView.builder(
//           itemCount: tasks.length, 
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               title: Text(tasks[index].task),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context)=> UpdatePage(
//                     client:client,
//                     id:tasks[index].id,
//                     task: tasks[index].task,
//                   ))
//                 );
//               },
//               trailing: IconButton(
//                 icon: Icon(Icons.delete), 
//                 onPressed: () => _deleteTask(tasks[index].id),
//               ),
//             );
//           }, 
//         ),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.of(context).push(
//           MaterialPageRoute(builder: (context)=> CreatePage(
//             client:client,

//           ))
//         ),
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//       );
//   }
// }

import 'package:blissfullden_app/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build ( BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}