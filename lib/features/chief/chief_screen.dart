import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';
import 'package:hotel_pos/features/auth/login_screen.dart';
import 'package:hotel_pos/features/chief/delete_item_screen.dart';

import '../../core/widget/custom_snackbar.dart';
import '../../core/widget/transition_effect.dart';

class ChiefScreen extends StatefulWidget {
  @override
  _ChiefScreenState createState() => _ChiefScreenState();
}

class _ChiefScreenState extends State<ChiefScreen> {
  int _selectedIndex = 1;
  bool _isNotificationEnabled = true;
  // List<Map<String, dynamic>> deletedOrders = [];
  List<Map<int, List<Map<String, dynamic>>>> deletedTables = [];

  Map<int, List<Map<String, dynamic>>> tableOrders = {
    1: [
      {"name": "Pizza", "quantity": 2},
      {"name": "Burger", "quantity": 1},
      {"name": "Pasta", "quantity": 3},
      {"name": "Beer", "quantity": 4},
    ],
    3: [
      {"name": "Sushi", "quantity": 5},
      {"name": "Ramen", "quantity": 2},
      {"name": "Fried Rice", "quantity": 1},
      {"name": "Miso Soup", "quantity": 3},
      {"name": "Sake", "quantity": 2},
    ],
    5: [
      {"name": "Steak", "quantity": 2},
      {"name": "Salad", "quantity": 1},
      {"name": "Soup", "quantity": 3},
      {"name": "Wine", "quantity": 4},
      {"name": "Cheesecake", "quantity": 2},
    ],
    2: [
      {"name": "Biryani", "quantity": 3},
      {"name": "Tandoori Chicken", "quantity": 1},
      {"name": "Naan", "quantity": 4},
      {"name": "Lassi", "quantity": 2},
      {"name": "Chai", "quantity": 3},
      {"name": "Gulab Jamun", "quantity": 2},
    ],
    7: [
      {"name": "Tacos", "quantity": 3},
      {"name": "Burrito", "quantity": 2},
      {"name": "Nachos", "quantity": 5},
    ],
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 🔹 Titles for each screen
  final List<String> _appBarTitles = ["Cook List", "Home", "Settings"];

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
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    DeleteItemScreen(
                        deletedTables: deletedTables, tableOrders: tableOrders);
                  },
                ),
              ]
            : null,
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
        List<Map<String, dynamic>> orders = entry.value;

        return GestureDetector(
          onTap: () {
            _showOrderDetails(context, tableNumber, orders);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/logo/logo.png", width: 50, height: 50),
                Text(
                  "Table $tableNumber",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "${orders.length} Items",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    setState(() {
                      deletedTables.add({tableNumber: orders});
                      tableOrders.remove(tableNumber);
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showOrderDetails(BuildContext context, int tableNumber,
      List<Map<String, dynamic>> orders) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Table $tableNumber Orders")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Food Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Quantity",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              ...orders.map((item) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['name'], style: TextStyle(fontSize: 16)),
                      Text(
                        "x ${item['quantity']}",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  )),
              Divider(thickness: 1, color: Colors.grey), // Add a divider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Quantity",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${orders.fold<int>(0, (sum, item) => sum + ((item['quantity'] ?? 0) as int))}", // Calculate total quantity
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
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
