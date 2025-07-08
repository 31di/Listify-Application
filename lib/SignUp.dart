import 'package:flutter/material.dart';
import 'package:listify/home.dart';
import 'package:listify/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  signUp() async {
    try {
      final username = usernameController.text;
      final email = emailController.text;
      final password = passwordController.text;

      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill in all fields')),
        );
        return;
      }

      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Sign-up failed. Please try again.');
      }

      final userId = response.user!.id;

      final userInsertResponse = await Supabase.instance.client.from('users2')
          .insert({
        'id': userId,
        'username': username,
        'email': email,
        'password': password, // يمكنك تشفير كلمة المرور إذا كنت ترغب في تحسين الأمان
      });

      // التحقق إذا كانت الاستجابة تحتوي على خطأ
      if (userInsertResponse.error != null) {
        // في حالة وجود خطأ حقيقي
        throw Exception('Failed to insert user into database: ${userInsertResponse.error!.message}');
      }

      // إذا تم الإدخال بنجاح، قم بعرض الرسالة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully! Please check your email for verification')),
      );

      // مسح الحقول بعد الإضافة
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      print('Error: $e'); // سجل الخطأ إذا كان موجودًا
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to SignUp: $e')),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffF5F5F5),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Listify",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 8,),
              Text("Create Account",style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 24,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Sign Up",style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff076777),
                ),),
              ),
              SizedBox(height: 16,),
              SizedBox(height: 55,
              child:TextField(
              controller: usernameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff076777)),borderRadius: BorderRadius.circular(9)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffa4d3c9),width: 1)),
                    labelText: 'User name',labelStyle: TextStyle(color: Color(0xff076777)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  )
                ),
              ) ,),SizedBox(height: 16,),
              SizedBox(height: 55,
              child:TextField(
                controller: emailController,
                decoration: InputDecoration(
                  enabled: true,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff076777)),borderRadius: BorderRadius.circular(9)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffa4d3c9),width: 1)),
                    labelText: 'Email',labelStyle: TextStyle(color: Color(0xff076777)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  )
                ),
              ) ,),SizedBox(height: 16,),
              SizedBox(height: 55,
              child:TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff076777)),borderRadius: BorderRadius.circular(9)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffa4d3c9),width: 1)),
                    labelText: 'Password',labelStyle: TextStyle(color: Color(0xff076777)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  )
                ),
              ) ,),
              SizedBox(height: 24,),
              ElevatedButton(onPressed: (){
                // insert();
                signUp();

              },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffa4d3c9),
                    minimumSize: const Size(200,50),
                    padding:  EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                  ),
                  child: Text("Sign Up",style: TextStyle(fontSize: 15,color: Color(0xff076777)),)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account ? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, MaterialPageRoute(builder: (context) =>  Login(),),);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color:Color(0xff076777),
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
