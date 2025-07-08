import 'package:flutter/material.dart';
import 'package:listify/login.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final SupabaseClient supabase = Supabase.instance.client;
  List inform = [];
  @override
  void initState() {
    super.initState();
    fetchinform();
  }
  bool darkmode = false;
final username_Controller =TextEditingController();
  Future<void> fetchinform() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        print("User not logged in");
        return;
      }

      final response = await supabase
          .from('users2')
          .select()
          .eq('id', user.id)
          .maybeSingle(); // جلب صف واحد فقط أو null

      if (mounted) {
        setState(() {
          inform = response != null ? [response] : [];
        });
      }
    } catch (e) {
      print("Error getting the data: $e");
    }
  }
  Future<void> updateUsername() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User not logged in'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final response = await supabase
        .from('users2')
        .update({'username': username_Controller.text})
        .eq('id', user.id);

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${response.error!.message}'),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Username updated successfully'),
        backgroundColor: Colors.green,
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(margin: EdgeInsets.fromLTRB(15, 0
                , 15, 0) ,
              padding: EdgeInsets.all(10),
              child: Card(color: Color(0xffa4d3c9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(1),
                    bottomRight: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                    topRight: Radius.circular(1)
                  ),
                ),elevation: toDouble(20),
                child: Row(
                  children: [
                    Container(padding: EdgeInsets.all(17),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Color(0xff076777),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [Text("Hi ",style: TextStyle(fontWeight: FontWeight.w400 ,fontSize: 40),),
                            Text(
                              inform.isNotEmpty ? inform[0]['username'] ?? 'No Name' : 'Fetching...',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
                            ),
                            SizedBox(width: 20,),
                            IconButton(onPressed: (){showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(30),
                                  title: Text(' new Username'),
                                  content: TextField(
                                    controller: username_Controller,
                                    decoration: InputDecoration(hintText: 'username'),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        updateUsername();
                                        Navigator.pop(context);

                                      },
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );}, icon:Icon(Icons.edit,size: 17,) )
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          inform.isNotEmpty ? inform[0]['email'] ?? 'No Email' : '',
                          style: TextStyle(fontSize: 16, color: Colors.black45,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4,)
                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.dark_mode, color: Color(0xffa4d3c9)),
              title: Text("Dark mode", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              subtitle: Text("Automatic", style: TextStyle(color: Colors.black54)),
              trailing: Switch(
                value: darkmode,
                onChanged: (value) {
                  setState(() {
                    darkmode = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.info, color: Color(0xffa4d3c9)),
              title: Text("About", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              subtitle: Text("Learn more about ListiFy'App", style: TextStyle(color: Colors.black54)),
              trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xff076777)),
              onTap: () {
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

              },
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xffa4d3c9)),
              title: Text("Sign Out", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xff076777)),
              onTap: () {
                PanaraConfirmDialog.showAnimatedGrow(

                  context,
                  title: "Logout",color: Color(0xffa4d3c9),
                  message: "Are you sure that you want to logout?",
                  confirmButtonText: "Confirm",
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
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Color(0xffa4d3c9)),
              title: Text("Edit Username", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              trailing: Icon(Icons.arrow_forward_ios, size: 18, color:Color(0xff076777)),
              onTap: () { showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(30),
                    title: Text(' new Username'),
                    content: TextField(
                      controller: username_Controller,
                      decoration: InputDecoration(hintText: 'username'),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          updateUsername();
                          Navigator.pop(context);

                        },
                        child: Text('Confirm'),
                      ),
                    ],
                  );
                },
              );},
            ),
          ],
        ),
      ),
    );
  }
}
