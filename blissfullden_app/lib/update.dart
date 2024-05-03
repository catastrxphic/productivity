import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdatePage extends StatefulWidget {
  final int id;
  final String task;
  final Client client;
  const UpdatePage({
    Key? key,
    required this.client,
    required this.id,
    required this.task,
    }) : super(key: key);

  @override
  UpdatePageState createState() => UpdatePageState();

}

class UpdatePageState extends State<UpdatePage>{
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
        title: const Text("Update"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 10,

          ),
          ElevatedButton(
            onPressed: (){
              var updateUrl = Uri.parse('http://127.0.0.1:8000/tasks/${widget.id}/update/');
              widget.client.put(updateUrl,body: {'body':controller.text});
              Navigator.pop(context);
            }, child: const Text("Update Note"))
        ],
      ),
    );
  }
}
