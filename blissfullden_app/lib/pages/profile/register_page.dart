import 'package:blissfullden_app/pages/tasks/task_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:blissfullden_app/components/button.dart'; 
import 'package:blissfullden_app/components/my_textfield.dart';
import 'package:blissfullden_app/pages/profile/login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/signup/"),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign Up failed.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Set background color to transparent
      body: Stack( // Use Stack to place elements on top of each other
        children: [
          // Bottom layer: Background image
          Image.asset(
            "lib/images/codingstudy.jpeg", // Path to your image
            fit: BoxFit.cover, // Adjusts the size of the image to cover the entire screen
            width: MediaQuery.of(context).size.width, // Set width to screen width
            height: MediaQuery.of(context).size.height, // Set height to screen height
          ),

          // Top layer: Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Icon(
                      Icons.lock, size: 100,
                      color: Color.fromARGB(255, 183, 186, 191),
                    ),

                    const SizedBox(height: 50),
                    const Text(
                      "Welcome to your Study Den",
                      style: TextStyle(
                        color: Colors.white, // Change text color to white for better visibility on the background image
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 25),
                    MyTextfield(
                      controller: usernameController, 
                      hintText: 'Username', 
                      obscureText: false
                    ),

                    const SizedBox(height: 25),
                    MyTextfield(
                      controller: passwordController,
                      hintText: 'Password' ,
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
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),
                    RegisterButton(onTap: () => signUp(context)),

                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already registered?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
