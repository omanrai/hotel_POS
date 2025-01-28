import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';
import 'package:hotel_pos/features/auth/login_screen.dart';

import '../../core/widget/custom_snackbar.dart';
import '../../core/widget/transition_effect.dart';

class ChiefScreen extends StatefulWidget {
  @override
  _ChiefScreenState createState() => _ChiefScreenState();
}

class _ChiefScreenState extends State<ChiefScreen> {
  int _selectedIndex = 1;
  bool _isNotificationEnabled = true;
  Map<int, List<String>> tableOrders = {
    1: ["Pizza", "Burger", "Pasta", "Beer"],
    2: ["Sushi", "Ramen", "Fried Rice", "Miso Soup", "Sake"],
    3: ["Steak", "Salad", "Soup", "Wine"],
    4: ["Biryani", "Tandoori Chicken", "Naan", "Lassi", "Chai", "Gulab Jamun"],
    5: ["Tacos", "Burrito", "Nachos"],
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 🔹 Titles for each screen
  final List<String> _appBarTitles = ["Cook", "Home", "Settings"];

  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = [
      _buildCookScreen(),
      _buildHomeScreen(),
      _buildSettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      body: _widgetOptions[_selectedIndex], //
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[200],
        unselectedItemColor: primaryColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.kitchen), label: 'Cook'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCookScreen() {
    return ListView(
      padding: EdgeInsets.all(10),
      children: tableOrders.entries.map((entry) {
        int tableNumber = entry.key;
        List<String> orders = entry.value;

        return GestureDetector(
          onTap: () {
            _showOrderDetails(context, tableNumber, orders);
          },
          child: Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Table $tableNumber",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${orders.length} Items",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showOrderDetails(
      BuildContext context, int tableNumber, List<String> orders) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Table $tableNumber Orders")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: orders.map((item) => Text(item)).toList(),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Close",
                  style: TextStyle(color: primaryColor),
                )),
          ],
        );
      },
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
                      "Restaurant Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Total Cooked Items",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "150 Items Cooked Today",
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
                backgroundImage: AssetImage("assets/logo/logo.png"),
              ),
              SizedBox(height: 10),
              Text(
                "John Doe",
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
                  _isNotificationEnabled = value; // ✅ Update state when pressed
                });
              },
            )
          : null,
      onTap: () {
        if (title == "Logout") {
          _showLogoutDialog();
        }
        if (title == "Notifications") {
          setState(() {
            hasToggle = true;
          });
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
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pushReplacement(slideTransition(LoginScreen()));

                showSuccessSnackBar(context, "Logout Successful", Colors.green);
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
