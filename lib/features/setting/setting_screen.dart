//   import 'package:flutter/material.dart';
// import 'package:hotel_pos/core/app_colors.dart';
// class SettingScreen extends StatelessWidget {
//   const SettingScreen({super.key});
  

//   @override
//   Widget build(BuildContext context) {
//       return 

// Widget _buildSettingsScreen(BuildContext context) {
 

//     return Column(
//       children: [
//         Container(
//           color: primaryColor,
//           width: double.infinity,
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: AssetImage("assets/logo/logo.png"),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "John Doe",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.1,
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Container(
//             padding: EdgeInsets.all(6),
//             decoration: BoxDecoration(
//               color: Colors.white60,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(2, 2),
//                 )
//               ],
//             ),
//             child: Column(
//               children: [
//                 _buildSettingItem(Icons.lock, "Forget Password"),
//                 Divider(),
//                 _buildSettingItem(Icons.notifications, "Notifications",
//                     hasToggle: true),
//                 Divider(),
//                 _buildSettingItem(Icons.logout, "Logout"),
//                 Divider(),
//                 _buildSettingItem(Icons.info, "Company Info"),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

  

//   Widget _buildSettingItem(IconData icon, String title,
//       {bool hasToggle = false}) {
//     return ListTile(
//       leading: Icon(icon, color: primaryColor),
//       title: Text(title, style: TextStyle(fontSize: 16)),
//       trailing: hasToggle
//           ? Switch(
//               activeColor: primaryColor,
//               value: _isNotificationEnabled, // ✅ Toggle state
//               onChanged: (value) {
//                 setState(() {
//                   _isNotificationEnabled = value; // ✅ Update state when pressed
//                 });
//               },
//             )
//           : null,
//       onTap: () {
//         if (title == "Logout") {
//           _showLogoutDialog();
//         }
//         if (title == "Notifications") {
//           setState(() {
//             hasToggle = true;
//           });
//         }
//       },
//     );
//   }
