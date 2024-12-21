import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoPage extends StatelessWidget{
  const UserInfoPage({super.key});

  Future <void> logout(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Info'),
        actions:[
          IconButton(onPressed: () => logout(context), icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome, User!, This is your profile page',
        style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}