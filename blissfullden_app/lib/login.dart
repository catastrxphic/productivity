import 'package:blissfullden_app/components/button.dart';
import 'package:blissfullden_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future <void> login(BuildContext context) async{
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/login/"),
      body:{
        'username':usernameController.text,
        'password':passwordController.text,
      },
    );

    if (response.statusCode == 200){
      Navigator.pushNamed(context, '/tasks/');
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:  Text('Login failed.')
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 200, 230),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              //logo
              const Icon(
                Icons.lock, size: 100,
              ),

              const SizedBox(height: 50),
              const Text(
                "Welcome Back",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                ),
              ),

          
              const SizedBox(height: 25),
              my_textfield(
                controller: usernameController, 
                hintText: 'username', 
                obscureText: false
              ),

              const SizedBox(height: 25),
              my_textfield(
                controller: passwordController,
                hintText: 'password' ,
                obscureText: true,
              ),

              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color.fromARGB(255, 131, 198, 237)),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),
              Button(onTap:()=> login(context)),

              const SizedBox(height: 50),
              GestureDetector(
                onTap:(){
                  Navigator.pushNamed(context, '/signup');
                } ,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?',
                    style: TextStyle(color:Colors.grey)
                    ,),
                    SizedBox(width: 4),
                    Text(
                      "Register now",
                      style: TextStyle(
                      color:Colors.blue, fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              )
              
            ],
          ),
        )
        )
    );
  }
}