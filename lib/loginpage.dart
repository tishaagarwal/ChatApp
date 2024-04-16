import 'package:chatapp/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

import 'components/button.dart';
import 'components/my_text_fields.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context,listen:false);
    try{
      await  authService.signInWithEmailandPassword(emailController.text,passwordController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 160),
              Icon(Icons.message,size: 90,color: Colors.grey),
              SizedBox(height: 30),
              Text("WELCOME TO THE WEBSITE.......",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.black),),
              SizedBox(height: 33),
              MyTextField(controller: emailController, hintText: 'Email', obscureText: false),
              SizedBox(height: 26),
              MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
              SizedBox(height: 26),
              MyButton(onTap: signIn, text: "Sign in"),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member??'),
                  SizedBox(height: 12, width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Register Now',style: TextStyle(fontWeight: FontWeight.bold),),
                  )
                  
                ],
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}