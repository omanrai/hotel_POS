import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';

import 'package:badges/badges.dart' as badges;
import 'package:hotel_pos/core/widget/transition_effect.dart';

import '../../core/widget/contstant.dart';
import '../../core/widget/custom_snackbar.dart';
import '../../core/widget/notification_item_widget.dart';
import '../../core/widget/url_launcher.dart';
import '../auth/login_screen.dart';
import 'tab/kot/cart_screen.dart';
import 'tab/kot/kot_screen.dart';
import 'tab/kot/select_dish_screen.dart';

class WaiterScreen extends StatefulWidget {
  const WaiterScreen({super.key});

  @override
  _WaiterScreenState createState() => _WaiterScreenState();
}

class _WaiterScreenState extends State<WaiterScreen> {
  int _selectedIndex = 1;
  bool _isNotificationEnabled = true;
  int? _currentlyExpandedIndex;

  bool _showBadge = true;
  final cartCount = 1;

  List<Map<int, List<Map<String, dynamic>>>> deletedTables = [];

  Map<int, List<Map<String, dynamic>>> tableOrders = {
    1: [
      {"name": "Pizza", "quantity": 2},
      {"name": "Burger", "quantity": 1},
      {"name": "Pasta", "quantity": 3},
      {"name": "Beer", "quantity": 4},
    ],
    3: [
      {"name": "Sushi", "quantity": 5, "remarks": ""},
      {"name": "Ramen", "quantity": 2, "remarks": "with boiled egg"},
      {"name": "Fried Rice", "quantity": 1, "remarks": "less oil"},
      {"name": "Miso Soup", "quantity": 3, "remarks": ""},
      {"name": "Sake", "quantity": 2, "remarks": ""},
    ],
    5: [
      {"name": "Steak", "quantity": 2, "remarks": "warm soup"},
      {"name": "Salad", "quantity": 1, "remarks": "cucumber only"},
      {"name": "Soup", "quantity": 3, "remarks": "with pepper"},
      {"name": "Wine", "quantity": 4, "remarks": ""},
      {"name": "Cheesecake", "quantity": 2, "remarks": "no omlette"},
    ],
    2: [
      {"name": "Biryani", "quantity": 3, "remarks": "ghee added"},
      {"name": "Tandoori Chicken", "quantity": 1, "remarks": ""},
      {"name": "Naan", "quantity": 4, "remarks": ""},
      {"name": "Lassi", "quantity": 2, "remarks": ""},
      {"name": "Chai", "quantity": 3, "remarks": ""},
      {"name": "Gulab Jamun", "quantity": 2, "remarks": ""},
    ],
    7: [
      {"name": "Tacos", "quantity": 3, "remarks": ""},
      {"name": "Burrito", "quantity": 2, "remarks": ""},
      {"name": "Nachos", "quantity": 5, "remarks": ""},
    ],
    9: [
      {"name": "Lassi", "quantity": 1, "remarks": "with ice"},
      {"name": "Burrito", "quantity": 2, "remarks": ""},
      {"name": "Coco-cola", "quantity": 1, "remarks": "lemon added"},
      {"name": "Momo", "quantity": 2, "remarks": "pork soup"},
    ],
  };

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

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = [
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

      body: widgetOptions[_selectedIndex], //
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
          Container(
            color: primaryColor,
            child: TabBar(
              labelColor: Colors.white,
              labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6),
              indicatorColor: secondaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: darkGrey,
              indicatorWeight: 3,
              tabs: [
                Tab(text: "Table"),
                Tab(text: "Order"),
                Tab(text: "KOT"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTableScreen(), // Table screen with cards
                _buildOrderedScreen(),
                _buildKOTScreen(),
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
      {
        "number": 1,
        "status": "Open",
        "color": Colors.green[300],
      },
      {"number": 2, "status": "Occupied", "color": Colors.blue[300]},
      {"number": 3, "status": "Reserved", "color": Colors.yellow[300]},
      {"number": 4, "status": "Occupied", "color": Colors.blue[300]},
      {
        "number": 5,
        "status": "Open",
        "color": Colors.green[300],
      },
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
                    const Color.fromARGB(255, 255, 230, 0));
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
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    table["status"],
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderedScreen() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(10),
      children: tableOrders.entries.map((entry) {
        int tableNumber = entry.key;
        List<Map<String, dynamic>> orders = entry.value;

        // Calculate total quantity
        int totalQuantity =
            orders.fold(0, (sum, item) => sum + (item['quantity'] as int));

        int index = tableNumber; // Use tableNumber as the unique index

        return Card(
          color: Colors.blue[50],
          margin: EdgeInsets.only(bottom: 10),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            key: Key(index.toString()), // Unique key for each tile
            initiallyExpanded:
                _currentlyExpandedIndex == index, // Control expansion
            onExpansionChanged: (isExpanded) {
              setState(() {
                log("🔹 Enter onExpansionChanged function");
                log("Previous Expanded Index: $_currentlyExpandedIndex");
                log("Current Pressed Index: $index");

                if (isExpanded) {
                  log("✅ Expanding Card: $index (Collapsing previous one if needed)");

                  // Collapse the previously expanded tile before opening a new one
                  if (_currentlyExpandedIndex != null &&
                      _currentlyExpandedIndex != index) {
                    log("🔻 Collapsing previous card: $_currentlyExpandedIndex");
                  }

                  _currentlyExpandedIndex = index; // Expand the new card
                } else if (_currentlyExpandedIndex == index) {
                  log("❌ Collapsing Card: $index");
                  _currentlyExpandedIndex = null; // Collapse the current one
                }
              });
            },

            tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Image.asset("assets/logo/logo.png", width: 50, height: 50),
            title: Text(
              "Table No. $tableNumber Orders",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${orders.length} Items",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: primaryColor,
                ),
              ],
            ),
            children: [
              Container(
                color: Colors.white70,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...orders
                          .map((order) => Padding(
                                padding: EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            order['name'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color:
                                                primaryColor.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            "Qty: ${order['quantity']}",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (order['remarks'] != null &&
                                        order['remarks'].toString().isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          "Remarks: ${order['remarks']}",
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ))
                          ,
                      Divider(thickness: 1),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () async {
                                // Show loading indicator
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // Prevent closing during loading
                                  builder: (context) => Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  ),
                                );
                                log(cartCount.toString());

                                // Wait for 2 seconds
                                await Future.delayed(Duration(seconds: 2));

                                // Close the loading indicator
                                Navigator.pop(context);

                                // Navigate with fade transition
                                Navigator.of(context)
                                    .push(slideTransition(CartScreen(
                                  cartCount: cartCount,
                                )));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: primaryColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  // _showDeleteBadge = true;
                                  deletedTables.add({tableNumber: orders});
                                  tableOrders.remove(tableNumber);
                                  showSuccessSnackBar(
                                      context, "Order Cancelled", Colors.red);
                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Total Quantity: ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "$totalQuantity",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKOTScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < 3; i++)
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    // Show loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // Prevent closing during loading
                      builder: (context) => Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    );

                    // Wait for 2 seconds
                    await Future.delayed(Duration(seconds: 2));

                    // Close the loading indicator
                    Navigator.pop(context);

                    // Navigate with fade transition
                    Navigator.of(context)
                        .push(slideTransition(OrderStatusScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              // color: Colors.grey.withOpacity(0.3),
                              color: ancientColor,
                              spreadRadius: 1,
                              blurRadius: 3,
                              // offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("KOT #5"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Table No. 1",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Status : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: "Pending",
                                          style: TextStyle(
                                              color: secondaryColor,
                                              letterSpacing: 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Date : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: "2025-01-20"),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Time : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: "08:55 PM"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Total QTY : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: "20"),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Total Price : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: "Rs. 50,000"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // Show loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // Prevent closing during loading
                      builder: (context) => Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    );

                    // Wait for 2 seconds
                    await Future.delayed(Duration(seconds: 2));

                    // Close the loading indicator
                    Navigator.pop(context);

                    // Navigate with fade transition
                    Navigator.of(context)
                        .push(slideTransition(OrderStatusScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              // color: Colors.grey.withOpacity(0.3),
                              color: ancientColor,
                              spreadRadius: 1,
                              blurRadius: 3,
                              // offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("KOT #7"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Table No. 4",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Status : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // TextSpan(text: "Pending",),
                                        TextSpan(
                                          text: "Completed",
                                          style: TextStyle(
                                              color: Colors.green,
                                              letterSpacing: 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Date : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: "2025-01-22"),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Time : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: "02:30 PM"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Total QTY : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: "5"),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Total Price : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: "Rs. 70,000"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
        ],
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

                showSuccessSnackBar(context, "Logout Successful", Colors.red);
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
