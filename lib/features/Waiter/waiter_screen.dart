import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';

import 'package:badges/badges.dart' as badges;

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
            indicatorColor: Colors.blue,
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
      {"number": 4, "status": "Open", "color": Colors.green},
      {"number": 5, "status": "Occupied", "color": Colors.red},
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 cards in one row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
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

  Widget _buildHomeScreen() => Center(child: Text("Home Screen"));

  Widget _buildNotificationScreen() =>
      Center(child: Text("Notification Screen"));

  Widget _buildSettingsScreen() => Center(child: Text("Settings Screen"));
}
