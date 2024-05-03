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

class CreatePageState extends State<CreatePage>{
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 10,

          ),
          ElevatedButton(
            onPressed: (){
              var createUrl = Uri.parse('http://127.0.0.1:8000/tasks/create/');
              widget.client.post(createUrl,body: {'body':controller.text});
              Navigator.pop(context);
            }, child:const Text("Create Note"))
        ],
      ),
    );
  }
}
