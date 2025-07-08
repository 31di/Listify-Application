import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listify/SignUp.dart';
import 'package:listify/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  signIn() async {
    try {
      final email = emailController.text;
      final password = passwordController.text;
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 5),
            content: Text('Please fill in all fields')));
        return;
      }
      final response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      if (response.session == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login: Invalid credentials')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Successfully!')),
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => home()), (route) => false);
      }

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Listify',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'welcome',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(height: 55,
                child: TextField(
                controller: emailController,
                  enabled: true,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffa4d3c9),width: 2)),
                      labelText: 'Email',labelStyle: TextStyle(color: Color(0xff076777)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff076777)),borderRadius: BorderRadius.circular(9))
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(height:55 ,
                child: TextField(
                controller: passwordController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Color(0xffa4d3c9) ,width: 2)),
                    labelText: 'Password',labelStyle: TextStyle(color: Color(0xff076777)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff076777)),borderRadius: BorderRadius.circular(9)),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  signIn();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffa4d3c9),
                  // padding:  EdgeInsets.symmetric(vertical: 10.0,),
                  minimumSize: const Size(200,50 ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 15,color: Color(0xff076777)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot password ?',
                  style: TextStyle(color: Color(0xff076777)),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  SignUp(),),);
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Color(0xff076777),
                        fontWeight: FontWeight.bold,
                      ),
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
extension on AuthResponse{
  get error=>null;
}

