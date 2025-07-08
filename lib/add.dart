import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:listify/time.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:table_calendar/table_calendar.dart';




class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  DateTime today = DateTime.now();

  get userId => null;

  // get formatTimeOfDay => null;


   void ondayselected(DateTime day, DateTime focusedDay){
     setState(() {
       today = day;
       dateController.text = DateFormat('yyyy-MM-dd').format(today);
     });
   }
  @override
  TimeOfDay timeOfDay = TimeOfDay(hour: 9, minute: 11);
    String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return DateFormat.Hms().format(dateTime);
  }
  void initState() {
    super.initState();
    dateController.text = DateFormat('yyyy-MM-dd').format(today);
  }


  final tasknameController =TextEditingController();
   final taskDescController =TextEditingController();
   // get timeController => formatTimeOfDay;
   final dateController =TextEditingController();
   // final statusConroller =TextEditingController(text: "fales");

  insert() async {
    try {

      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        print('User not logged in');
        return;
      }

      final userId = user.id; // معرف المستخدم من Supabase Auth


      final response = await Supabase.instance.client.from('task').insert({
        'taskname': tasknameController.text,
        'taskDesc': taskDescController.text,
        'date': dateController.text,
        'time': formatTimeOfDay(timeOfDay),        // 'status': statusConroller.text == "true" ? true : false,
        'userid': userId,
      });

      if (response.error != null) {
        print('Error: ${response.error!.message}');
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task added successfully')),
        );
        print('Task added successfully');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(height: 5,width: 100,decoration: BoxDecoration( borderRadius: BorderRadius.circular(20),color: Colors.blueGrey),),
              SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(onPressed: (){Navigator.of(context).pop();}, icon:Icon(Icons.arrow_back_ios_outlined),color: Color(0xff076777)),
                  Text(
                    'Add New Task',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(style:ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xff076777),
                      padding:  EdgeInsets.symmetric(horizontal: 13,),
                    minimumSize: Size(30, 40)
                  ),
                    onPressed: () {

                      insert();
                      Navigator.of(context).pop();
                    },
                    child: Text('Add',style: TextStyle(color: Color(0xffffffff),fontSize: 12)),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Card(
                elevation:RenderListWheelViewport.defaultDiameterRatio ,
                child: TextField(
                    controller: tasknameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff076777)),borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Color(0xffa4d3c9),width: 2)),
                    labelText: 'Task name',labelStyle: TextStyle(color: Color(0xff076777)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(color: Colors.white,
                elevation:RenderListWheelViewport.defaultDiameterRatio ,
                child: TextField(
                  controller: taskDescController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff076777)),borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Color(0xffa4d3c9),width: 2)),
                    labelText: 'Notes',labelStyle: TextStyle(color: Color(0xff076777)),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Set Time  ',
                      style: TextStyle(fontSize: 16, ),
                    ),
                  ),
                  Icon(Icons.alarm_sharp,color: Color(0xff076777),),
                ],
              ),
              SizedBox(height: 16,),
              Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      // height: 70,
                      // width: 120,
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Color(0xff076777)),
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                      child: TextButton(
                        onPressed: () async{
                          TimeOfDay? clock = await showTimePicker(context: context, initialTime: timeOfDay);
                          if (clock==null)return;
                          setState(() {
                            timeOfDay=clock;
                          });
                        },
                        child: Text(
                          "${timeOfDay.hour}:${timeOfDay.minute}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color(0xffa4d3c9), // لون النص
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Set due date  ',
                      style: TextStyle(fontSize: 16, ),
                    ),
                  ),
                   Icon(Icons.calendar_month_sharp,color: Color(0xff076777),),

                ],
              ),
              SizedBox(height: 16),
              Container(
                height: 30,
                width: 105,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff076777)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${DateFormat('yyyy-MM-dd').format(today)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color(0xffa4d3c9)),
                ),
              ),
              SizedBox(height: 16),
              Card(color: Colors.white,
                 elevation:RenderListWheelViewport.defaultDiameterRatio ,
                // decoration: BoxDecoration( border:Border(bottom:BorderSide(width: 1) ,left: BorderSide(width: 1),right: BorderSide(width: 1)) ,),
                child: TableCalendar(calendarFormat: CalendarFormat.week,
                headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay:today,
                  onDaySelected: ondayselected,
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) => isSameDay(day,today),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle:TextStyle(color: Color(0xffa4d3c9)),
                    weekNumberTextStyle:TextStyle(color: Color(0xffa4d3c9)),
                    weekendTextStyle:TextStyle(color: Color(0xff076777)),
                    markerDecoration: BoxDecoration(color: Colors.red)
                  ),
              ),),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),);
  }
}

extension on AuthResponse {
  get error => null;
}
get uid => null;