import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signupUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Créer un compte', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.purple)),
            SizedBox(height: 40),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 16),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: signupUser,
              child: Text('Signup'),
              style: ElevatedButton.styleFrom(primary: Colors.purple, minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
