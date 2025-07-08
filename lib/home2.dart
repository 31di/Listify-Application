import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class home2 extends StatefulWidget {
  @override
  _home2State createState() => _home2State();
}

class _home2State extends State<home2> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        print("user not loged in");
        return;
      }

      final response = await supabase
          .from('task')
          .select()
          .eq('userid', user.id)
          .order('date', ascending: true);

      if (mounted) {
        setState(() {
          tasks = List<Map<String, dynamic>>.from(response);
          isLoading = false;
        });
      }
    } catch (e) {
      print("Erorr geting the data: $e");
    }
  }
  Future<void> deleteTask(dynamic taskId) async {
    if (taskId is! int) {
      print("Erorr: $taskId");
      return;
    }

    try {
      await supabase
          .from('task')
          .delete()
          .eq('taskid', taskId);
      setState(() {
        tasks.removeWhere((task) => task['taskid'] == taskId);
      });

      print("the task deleted");
    } catch (e) {
      print("eroor when  $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // مؤشر تحميل
          : tasks.isEmpty
          ? Center(child: Text("There's NO Tasks Yet"))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Container(
            // decoration: UnderlineTabIndicator(borderSide: BorderSide(color: Color(0xffa4d3c9)),insets: EdgeInsets.all(4)),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xFFF3F3F3),border: Border.all(color: Color(0xffa4d3c9))),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(trailing: IconButton(
              onPressed: () {
                PanaraConfirmDialog.showAnimatedGrow(
                  context,
                  title: "Delete Task",
                  color: Color(0xffa4d3c9),
                  message: "Are you sure that you want to delete this task?",
                  confirmButtonText: "Confirm",
                  cancelButtonText: "Cancel",
                  onTapCancel: (){
                    Navigator.pop(context);
                  },
                  onTapConfirm: () {
                    print(task); //
                    if (task['taskid'] != null) {
                      deleteTask(task['taskid']);
                    } else {
                      print(" Error: Task does not have a valid taskid");
                    }
                    Navigator.pop(context);
                  },
                  panaraDialogType: PanaraDialogType.custom,
                );
              },
              icon: Icon(Icons.delete, color: Color(0xFF91160F)),
            ),

              title: Text(
                task['taskname'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task['taskDesc']),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(" ${task['date']}", style: TextStyle(color: Colors.grey[600])),
                      Text(" ${task['time']}", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),


            ),
          );
        },
      ),
    );
  }
}
