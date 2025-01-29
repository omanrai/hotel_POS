  // Widget _buildHomeScreen() {
  //   return SingleChildScrollView(
  //     padding: EdgeInsets.all(16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           width: double.infinity,
  //           padding: EdgeInsets.all(20),
  //           decoration: BoxDecoration(
  //             color: Colors.blue[100],
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Icon(Icons.restaurant, color: Colors.blue[700], size: 30),
  //                   SizedBox(width: 15),
  //                   Text(
  //                     companyName,
  //                     style:
  //                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 20),
  //               Text(
  //                 "Total Ordered Items",
  //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(height: 5),
  //               Text(
  //                 "150 Items Order Today",
  //                 style: TextStyle(fontSize: 16, color: Colors.blue[900]),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.05,
  //         ),
  //         Text("Restaurant Features",
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //         SizedBox(height: 10),
  //         Column(
  //           children: [
  //             _buildFeatureTile(Icons.delivery_dining, "Online Food Delivery"),
  //             _buildFeatureTile(Icons.payment, "Online Payment"),
  //             _buildFeatureTile(Icons.event_seat, "Table Reservation"),
  //             _buildFeatureTile(Icons.local_offer, "Discount Offers"),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildFeatureTile(IconData icon, String title) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 10),
  //     padding: EdgeInsets.all(15),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.3),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: Offset(0, 3),
  //         )
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Icon(icon, color: Colors.blue[700], size: 30),
  //         SizedBox(width: 15),
  //         Text(title, style: TextStyle(fontSize: 16)),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildSettingsScreen() {
  //   return Column(
  //     children: [
  //       Container(
  //         color: primaryColor,
  //         width: double.infinity,
  //         child: Column(
  //           children: [
  //             SizedBox(height: 20),
  //             CircleAvatar(
  //               radius: 50,
  //               backgroundImage: AssetImage("assets/logo/cr7.jpg"),
  //             ),
  //             SizedBox(height: 10),
  //             Text(
  //               "Cristiano Ronaldo",
  //               style: TextStyle(fontSize: 20, color: Colors.white),
  //             ),
  //             SizedBox(height: 20),
  //           ],
  //         ),
  //       ),
  //       SizedBox(
  //         height: MediaQuery.of(context).size.height * 0.1,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(12.0),
  //         child: Container(
  //           padding: EdgeInsets.all(6),
  //           decoration: BoxDecoration(
  //             color: Colors.white60,
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(10),
  //             ),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.3),
  //                 spreadRadius: 2,
  //                 blurRadius: 5,
  //                 offset: Offset(2, 2),
  //               )
  //             ],
  //           ),
  //           child: Column(
  //             children: [
  //               _buildSettingItem(Icons.lock, "Forget Password"),
  //               Divider(),
  //               _buildSettingItem(Icons.notifications, "Notifications",
  //                   hasToggle: true),
  //               Divider(),
  //               _buildSettingItem(Icons.logout, "Logout"),
  //               Divider(),
  //               _buildSettingItem(Icons.info, "Company Info"),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildSettingItem(IconData icon, String title,
  //     {bool hasToggle = false}) {
  //   return ListTile(
  //     leading: Icon(icon, color: primaryColor),
  //     title: Text(title, style: TextStyle(fontSize: 16)),
  //     trailing: hasToggle
  //         ? Switch(
  //             activeColor: primaryColor,
  //             value: _isNotificationEnabled, // ✅ Toggle state
  //             onChanged: (value) {
  //               setState(() {
  //                 _isNotificationEnabled = value;
  //                 hasToggle = value;
  //                 if (hasToggle) {
  //                   showSuccessSnackBar(
  //                       context, "You will get Notification", Colors.green);
  //                 } else {
  //                   showSuccessSnackBar(
  //                       context, "You Won't get Notification", Colors.red);
  //                 }
  //               });
  //             },
  //           )
  //         : null,
  //     onTap: () {
  //       if (title == "Logout") {
  //         _showLogoutDialog();
  //       }
  //       if (title == "Company Info") {
  //         urlLauncher(aboutUsUrl);
  //       }
  //       if (title == "Forget Password") {
  //         showSuccessSnackBar(context,
  //             "You will get new password at Register Mobile No.", Colors.green);
  //       }
  //     },
  //   );
  // }

  // void _showLogoutDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Center(child: Text("Logout")),
  //         content: Text("Are you sure you want to logout?"),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text("Cancel", 
  //               style: TextStyle(color: primaryColor),
  
  // ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               Navigator.of(context)
  //                   .pushReplacement(slideTransition(LoginScreen()));

  //               showSuccessSnackBar(context, "Logout Successful", Colors.green);
  //             },
  //             child: Text("Confirm",  style: TextStyle(color: Colors.red),
  
  // ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Widget _buildNotificationScreen() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: Column(
  //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Jan 05, 2025",
  //           style: TextStyle(fontWeight: FontWeight.w500),
  //         ),
  //         SizedBox(height: 10),
  //         NotificationItemWidget(
  //           iconName: Icons.notifications_active_outlined,
  //           containerColor: secondaryColor,
  //           iconColor: neutralMutedGrey,
  //           notificationTitle: "Table No. 1 Food is ready. Pick up Now",
  //         ),
  //         SizedBox(height: 14),
  //         NotificationItemWidget(
  //           iconName: Icons.notifications_active_outlined,
  //           containerColor: secondaryColor,
  //           iconColor: neutralMutedGrey,
  //           notificationTitle:
  //               "Table No. 7 is Reserved. No order can be placed now",
  //         ),
  //         SizedBox(height: 14),
  //         NotificationItemWidget(
  //           iconName: Icons.notifications_outlined,
  //           containerColor: Colors.white60,
  //           iconColor: primaryColor,
  //           notificationTitle: "Table No. 2 food is ready. Pick up Now",
  //         ),
  //         SizedBox(height: 24),
  //         Text(
  //           "Jan 01, 2025",
  //           style: TextStyle(fontWeight: FontWeight.w500),
  //         ),
  //         SizedBox(height: 10),
  //         NotificationItemWidget(
  //           iconName: Icons.notifications_outlined,
  //           containerColor: Colors.white60,
  //           iconColor: primaryColor,
  //           notificationTitle: "Today Shop will be closed",
  //         ),
  //         SizedBox(height: 24),
  //         Text(
  //           "Dec 28, 2024",
  //           style: TextStyle(fontWeight: FontWeight.w500),
  //         ),
  //         SizedBox(height: 10),
  //         NotificationItemWidget(
  //           iconName: Icons.notifications_outlined,
  //           containerColor: Colors.white60,
  //           iconColor: primaryColor,
  //           notificationTitle:
  //               "Table No. 7 is Occupied. No Order can be placed now",
  //         ),
  //       ],
  //     ),
  //   );
  // }



  // labelColor: Colors.black,
  //           labelStyle: TextStyle(
  //               fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.6),
  //           indicatorColor: Colors.blue,
  //           indicatorSize: TabBarIndicatorSize.tab,
  //           indicatorWeight: 3,




  // else if ((table["status"] == "Reserved")) {
  //               showSuccessSnackBar(
  //                   context,
  //                   "This is reserved, right Now. Please wait !",
  //                   Colors.yellow);
  //             } else {
  //               showSuccessSnackBar(context,
  //                   "This is Occupied, right Now, Please wait !", Colors.red);
  //             }