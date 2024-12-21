import 'package:blissfullden_app/components/button.dart';
import 'package:blissfullden_app/components/my_textfield.dart';
import 'package:blissfullden_app/pages/profile/register_page.dart';
import 'package:blissfullden_app/pages/profile/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



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
      // save state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> const UserInfoPage()),
      );
    }
    else{
      // ignore: use_build_context_synchronously
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
      // backgroundColor: const Color.fromARGB(255, 225, 200, 230),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/codingstudy.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // logo
                  const Icon(
                    Icons.lock, size: 100,
                    color: Color.fromARGB(255, 183, 186, 191),
                  ),

                  const SizedBox(height: 50),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),
                  MyTextfield(
                    controller: usernameController, 
                    hintText: 'username', 
                    obscureText: false
                  ),

                  const SizedBox(height: 25),
                  MyTextfield(
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
                  SignInButton(onTap:()=> login(context)),

                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context)=> RegisterPage()
                        ),
                      );
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
            ),
          ),
        ),
      ),
    );
  }
}