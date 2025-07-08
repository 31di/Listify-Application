import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listify/add.dart';
import 'package:listify/home2.dart';
import 'package:listify/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int currentindex=0;
  List listwidget=[
    home2(),
    add(),
    profile()
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context) . size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffa4d3c9),
        title: Text("Listify",style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(icon: Icon(Icons.info_outline), onPressed: () {
          PanaraInfoDialog.show(
          context,
          imagePath: "icons/icon3.png",
          title: "ListiFy",
          message: "An online to-do list app for easy task management, real-time sync, and improved productivity across devices",
          buttonText: "Exit",color: Color(0xffa4d3c9),
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.custom,
          barrierDismissible: false, // optional parameter (default is true)
        );
        },),
          actions: [
            IconButton(onPressed: (){
              PanaraConfirmDialog.showAnimatedGrow(
                context,
                title: "Logout",
                message: "Are you sure that you want to logout?",
                confirmButtonText: "Confirm",color: Color(0xffa4d3c9),
                cancelButtonText: "Cancel",
                onTapCancel: (){
                  Navigator.pop(context);
                },
                onTapConfirm: () async{
                  await Supabase.instance.client.auth.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout')),);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context)=>Login()),
                        (route) => false);
                },
                panaraDialogType: PanaraDialogType.custom,
              );
            }, icon: Icon(Icons.exit_to_app))
          ],
        ),
      backgroundColor: Color(0xffeaddd4),
      body: Column(
        children: 
        <Widget>[
          Container(
            height: size.height * 0.04,
            color: Colors.white,
            child: Stack(children: <Widget>[
              Container(
                height: size.height * 0.04,

                decoration: BoxDecoration(
                    color: Color(0xffa4d3c9),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28)
                  )
                ),
              ),
            ],),
          ),
          Expanded(
            child: Container(
              child: listwidget.elementAt(currentindex),
            ),
          ),
        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(height: 55,animationCurve: Curves.bounceInOut,
        backgroundColor: Colors.white,
        color: Color(0xffa4d3c9),
        buttonBackgroundColor: Color(0xffa4d3c9),
        animationDuration: Duration(milliseconds: 200),
        items: [
          Icon(Icons.home,size: 28,color: Color(0xffffffff),),
          Icon(Icons.add_circle,size: 28,color: Color(0xffffffff)),
          Icon(Icons.settings_suggest,size: 28,color: Color(0xffffffff))
        ],
        onTap: (value) {
          setState(() {
            if (value == 1) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    child: FractionallySizedBox(
                      heightFactor: 0.85, // تحديد ارتفاع النافذة إلى ثلاثة أرباع الشاشة
                      child: add(),
                    ),
                  ),
                ),
              );
            } else {
              currentindex = value;
            }
          });
        },
      ),
    );
  }
}


