// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// class time extends StatefulWidget {
//   const time({super.key});
//
//   @override
//   State<time> createState() => _timeState();
//
//   static formatTimeOfDay(timeOfDay ) {}
// }
//
// class _timeState extends State<time> {
//   TimeOfDay timeOfDay = TimeOfDay(hour: 9, minute: 11);
//   String formatTimeOfDay(TimeOfDay tod) {
//     final now = DateTime.now();
//     final dateTime = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
//     return DateFormat.Hms().format(dateTime);
//   }
//   @override
//
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 70,
//             width: 120,
//             decoration: BoxDecoration(
//               border: Border.all(color: Color(0xff076777)),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: TextButton(
//               onPressed: () async{
//                 TimeOfDay? clock = await showTimePicker(context: context, initialTime: timeOfDay);
//                 if (clock==null)return;
//                 setState(() {
//                   timeOfDay=clock;
//                 });
//               },
//               child: Text(
//                 "${timeOfDay.hour}:${timeOfDay.minute}",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 40,
//                   color: Color(0xffa4d3c9), // لون النص
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
