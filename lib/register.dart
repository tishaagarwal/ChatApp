import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/button.dart';
import 'components/my_text_fields.dart';
import 'services/auth/auth_services.dart';

class RegisterPage extends StatefulWidget {
    final void Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }
    
    final authService =  Provider.of<AuthService>(context,listen:false);
    try {
      await authService.signUpWithEmailandPassword(emailController.text,passwordController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),
      ));
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
              Icon(Icons.message, size: 90, color: Colors.grey),
              SizedBox(height: 30),
              Text(
                "Create an account for you",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 33),
              MyTextField(controller: emailController, hintText: 'Email', obscureText: false),
              SizedBox(height: 26),
              MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
              SizedBox(height: 26),
              MyTextField(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true),
              SizedBox(height: 26),
              MyButton(onTap: signUp, text: "Sign up"),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a member??'),
                  SizedBox(height: 12, width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                    'Login Now',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}