import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';

import 'package:badges/badges.dart' as badges;
import 'package:hotel_pos/core/widget/transition_effect.dart';

import '../../core/widget/contstant.dart';
import '../../core/widget/custom_snackbar.dart';
import '../../core/widget/notification_item_widget.dart';
import '../../core/widget/url_launcher.dart';
import '../auth/login_screen.dart';
import 'select_dish_screen.dart';

class WaiterScreen extends StatefulWidget {
  const WaiterScreen({super.key});

  @override
  _WaiterScreenState createState() => _WaiterScreenState();
}

class _WaiterScreenState extends State<WaiterScreen> {
  int _selectedIndex = 1;
  bool _isNotificationEnabled = true;

  bool _showBadge = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        _showBadge = false; // Hide badge when Notification tab is selected
      }
    });
  }

  // 🔹 Titles for each screen
  final List<String> _appBarTitles = [
    "Book your Order",
    "Home",
    "Notifications",
    "Settings"
  ];

  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = [
      _buildOrderScreen(),
      _buildHomeScreen(),
      _buildNotificationScreen(),
      _buildSettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_appBarTitles[_selectedIndex]),
        actions: [],
      ),

      body: _widgetOptions[_selectedIndex], //
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[200],
        unselectedItemColor: primaryColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.kitchen), label: 'Order'),
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: badges.Badge(
              showBadge: _showBadge,
              badgeContent: const Text(
                '2',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              child: const Icon(Icons.notification_add),
            ),
            label: 'Notification',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildOrderScreen() {
    return DefaultTabController(
      length: 3, // Three tabs
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            labelStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.6),
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            tabs: [
              Tab(text: "Table"),
              Tab(text: "Order"),
              Tab(text: "KOT"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTableScreen(), // Table screen with cards
                Center(child: Text("Order Screen Content")),
                Center(child: Text("KOT Screen Content")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableScreen() {
    // Sample data for tables
    final List<Map<String, dynamic>> tables = [
      {"number": 1, "status": "Open", "color": Colors.green},
      {"number": 2, "status": "Occupied", "color": Colors.red[400]},
      {"number": 3, "status": "Reserved", "color": Colors.yellow[400]},
      {
        "number": 4,
        "status": "Open",
        "color": const Color.fromARGB(255, 104, 207, 107)
      },
      {"number": 5, "status": "Occupied", "color": Colors.red},
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 cards in one row
          crossAxisSpacing: 5,
          mainAxisSpacing: 8,
          childAspectRatio: 1, // Adjust height
        ),
        itemCount: tables.length,
        itemBuilder: (context, index) {
          final table = tables[index];
          return GestureDetector(
            onTap: () {
              if (table["status"] == "Open") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectDishScreen(),
                  ),
                );
              } else if ((table["status"] == "Reserved")) {
                showSuccessSnackBar(
                    context,
                    "This is reserved, right Now. Please wait !",
                    Colors.yellow);
              } else {
                showSuccessSnackBar(context,
                    "This is Occupied, right Now, Please wait !", Colors.red);
              }
            },
            child: Card(
              color: table["color"], // Assign color based on status
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Table ${table["number"]}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    table["status"],
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant, color: Colors.blue[700], size: 30),
                    SizedBox(width: 15),
                    Text(
                      companyName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Total Ordered Items",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "150 Items Order Today",
                  style: TextStyle(fontSize: 16, color: Colors.blue[900]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text("Restaurant Features",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Column(
            children: [
              _buildFeatureTile(Icons.delivery_dining, "Online Food Delivery"),
              _buildFeatureTile(Icons.payment, "Online Payment"),
              _buildFeatureTile(Icons.event_seat, "Table Reservation"),
              _buildFeatureTile(Icons.local_offer, "Discount Offers"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[700], size: 30),
          SizedBox(width: 15),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSettingsScreen() {
    return Column(
      children: [
        Container(
          color: primaryColor,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/logo/cr7.jpg"),
              ),
              SizedBox(height: 10),
              Text(
                "Cristiano Ronaldo",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                )
              ],
            ),
            child: Column(
              children: [
                _buildSettingItem(Icons.lock, "Forget Password"),
                Divider(),
                _buildSettingItem(Icons.notifications, "Notifications",
                    hasToggle: true),
                Divider(),
                _buildSettingItem(Icons.logout, "Logout"),
                Divider(),
                _buildSettingItem(Icons.info, "Company Info"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(IconData icon, String title,
      {bool hasToggle = false}) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: hasToggle
          ? Switch(
              activeColor: primaryColor,
              value: _isNotificationEnabled, // ✅ Toggle state
              onChanged: (value) {
                setState(() {
                  _isNotificationEnabled = value;
                  hasToggle = value;
                  if (hasToggle) {
                    showSuccessSnackBar(
                        context, "You will get Notification", Colors.green);
                  } else {
                    showSuccessSnackBar(
                        context, "You Won't get Notification", Colors.red);
                  }
                });
              },
            )
          : null,
      onTap: () {
        if (title == "Logout") {
          _showLogoutDialog();
        }
        if (title == "Company Info") {
          urlLauncher(aboutUsUrl);
        }
        if (title == "Forget Password") {
          showSuccessSnackBar(context,
              "You will get new password at Register Mobile No.", Colors.green);
        }
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Logout")),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(color: primaryColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pushReplacement(slideTransition(LoginScreen()));

                showSuccessSnackBar(context, "Logout Successful", Colors.green);
              },
              child: Text(
                "Confirm",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNotificationScreen() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jan 05, 2025",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          NotificationItemWidget(
            iconName: Icons.notifications_active_outlined,
            containerColor: secondaryColor,
            iconColor: neutralMutedGrey,
            notificationTitle: "Table No. 1 Food is ready. Pick up Now",
          ),
          SizedBox(height: 14),
          NotificationItemWidget(
            iconName: Icons.notifications_active_outlined,
            containerColor: secondaryColor,
            iconColor: neutralMutedGrey,
            notificationTitle:
                "Table No. 7 is Reserved. No order can be placed now",
          ),
          SizedBox(height: 14),
          NotificationItemWidget(
            iconName: Icons.notifications_outlined,
            containerColor: Colors.white60,
            iconColor: primaryColor,
            notificationTitle: "Table No. 2 food is ready. Pick up Now",
          ),
          SizedBox(height: 24),
          Text(
            "Jan 01, 2025",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          NotificationItemWidget(
            iconName: Icons.notifications_outlined,
            containerColor: Colors.white60,
            iconColor: primaryColor,
            notificationTitle: "Today Shop will be closed",
          ),
          SizedBox(height: 24),
          Text(
            "Dec 28, 2024",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          NotificationItemWidget(
            iconName: Icons.notifications_outlined,
            containerColor: Colors.white60,
            iconColor: primaryColor,
            notificationTitle:
                "Table No. 7 is Occupied. No Order can be placed now",
          ),
        ],
      ),
    );
  }
}
