// import 'package:flutter/material.dart';
// import 'package:hotel_pos/core/app_colors.dart';

// class ChiefScreen extends StatefulWidget {
//   @override
//   _ChiefScreenState createState() => _ChiefScreenState();
// }

// class _ChiefScreenState extends State<ChiefScreen> {
//   int _selectedIndex = 1;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   static const List<Widget> _widgetOptions = <Widget>[
//     Text('Cook Screen', style: TextStyle(fontSize: 24)),
//     Text('Home Screen', style: TextStyle(fontSize: 24)),
//     Text('Settings Screen', style: TextStyle(fontSize: 24)),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('Chief Screen'),
//         ),
//         body: Center(
//           child: _widgetOptions.elementAt(_selectedIndex),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           elevation: 2,
//           backgroundColor: Colors.blue[200],
//           unselectedItemColor: secondaryColor,
//           // unselectedItemColor: Colors.white,
//           showSelectedLabels: false,
//           showUnselectedLabels: true,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.kitchen),
//               label: 'Cook',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Settings',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: primaryColor,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';

class ChiefScreen extends StatefulWidget {
  @override
  _ChiefScreenState createState() => _ChiefScreenState();
}

class _ChiefScreenState extends State<ChiefScreen> {
  int _selectedIndex = 1;
  Map<int, List<String>> tableOrders = {
    1: ["Pizza", "Burger", "Pasta"],
    2: ["Sushi", "Ramen", "Fried Rice"],
    3: ["Steak", "Salad", "Soup"],
    4: ["Biryani", "Tandoori Chicken", "Naan"],
    5: ["Tacos", "Burrito", "Nachos"],
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          title: Text("Table $tableNumber Orders"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: orders.map((item) => Text(item)).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
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
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
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
          SizedBox(height: 20),
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
        SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage("assets/logo/logo.png"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        _buildSettingItem(Icons.lock, "Forget Password"),
        _buildSettingItem(Icons.notifications, "Notifications",
            hasToggle: true),
        _buildSettingItem(Icons.logout, "Logout"),
        _buildSettingItem(Icons.info, "Company Info"),
      ],
    );
  }

  Widget _buildSettingItem(IconData icon, String title,
      {bool hasToggle = false}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[700]),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: hasToggle ? Switch(value: true, onChanged: (value) {}) : null,
      onTap: () {
        if (title == "Logout") {
          _showLogoutDialog();
        }
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Logged out successfully"),
                ));
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = [
      _buildCookScreen(),
      _buildHomeScreen(),
      _buildSettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Chief Screen')),
      body: _widgetOptions[_selectedIndex], // ✅ Directly access the list
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[200],
        unselectedItemColor: secondaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.kitchen), label: 'Cook'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
