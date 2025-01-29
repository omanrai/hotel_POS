import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';
import 'package:badges/badges.dart' as badges;

class SelectDishScreen extends StatefulWidget {
  @override
  _SelectDishScreenState createState() => _SelectDishScreenState();
}

class _SelectDishScreenState extends State<SelectDishScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int count = 1; // Starting value
  bool _showBadge = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> foodItems = [
    {
      "name": "Burger",
      "price": 599,
      "image":
          "https://static.vecteezy.com/system/resources/thumbnails/023/809/530/small/a-flying-burger-with-all-the-layers-ai-generative-free-photo.jpg",
      "category": "Lunch"
    },
    {
      "name": "Pizza",
      "price": 799,
      "image": "https://via.placeholder.com/80",
      "category": "Lunch"
    },
    {
      "name": "Orange Juice",
      "price": 349,
      "image": "https://via.placeholder.com/80",
      "category": "Beverages"
    },
    {
      "name": "Coffee",
      "price": 299,
      "image": "https://via.placeholder.com/80",
      "category": "Beverages"
    },
    {
      "name": "Steak",
      "price": 1599,
      "image": "https://via.placeholder.com/80",
      "category": "Dinner"
    },
    {
      "name": "Pasta",
      "price": 1099,
      "image": "https://via.placeholder.com/80",
      "category": "Dinner"
    },
    {
      "name": "Pancakes",
      "price": 100,
      "image": "https://via.placeholder.com/80",
      "category": "Breakfast"
    },
    {
      "name": "Omelette",
      "price": 99,
      "image": "https://via.placeholder.com/80",
      "category": "Breakfast"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Dish",
        ),
        actions: [
          IconButton(
            icon: badges.Badge(
              showBadge: _showBadge,
              badgeContent: Text(
                "7",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              child: Icon(Icons.shopping_cart),
            ),
            onPressed: () async {
              setState(() {
                // deletedTables.clear(); // Clear deleted tables
              });
              // Show loading indicator
              showDialog(
                context: context,
                barrierDismissible: false, // Prevent closing during loading
                builder: (context) => Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              );

              await Future.delayed(Duration(seconds: 2));
              // Close the loading indicator
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              // MaterialPageRoute(
              //   builder: (context) => CartScreen(),
              // ),
              // );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: "All Category"),
            Tab(text: "Lunch"),
            Tab(text: "Beverages"),
            Tab(text: "Dinner"),
            Tab(text: "Breakfast"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFoodGrid(foodItems), // All categories
          _buildFoodGrid(
              foodItems.where((item) => item["category"] == "Lunch").toList()),
          _buildFoodGrid(foodItems
              .where((item) => item["category"] == "Beverages")
              .toList()),
          _buildFoodGrid(
              foodItems.where((item) => item["category"] == "Dinner").toList()),
          _buildFoodGrid(foodItems
              .where((item) => item["category"] == "Breakfast")
              .toList()),
        ],
      ),
    );
  }

  Widget _buildFoodGrid(List<Map<String, dynamic>> items) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo/logo.png",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Text(item["name"],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                // Text("Rs. \${item["price"]}",
                Text("Rs. ${item["price"]}",
                    style: TextStyle(color: secondaryColor)),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _showCustomizeBottomSheet(context, item);
                    },
                    child: const Text("+ Add"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showCustomizeBottomSheet(
      BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Customize Dish",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        //  item["image"],
                        "assets/logo/logo.png",
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item["name"],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          // border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: primaryColor,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (count > 1) {
                                    // Prevents going below 1
                                    count--;
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              count.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Select Variant",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildVariantOption("Small"),
                    const SizedBox(width: 10),
                    _buildVariantOption("Medium"),
                    const SizedBox(width: 10),
                    _buildVariantOption("Large"),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Remarks",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Enter Remarks",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () {},
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVariantOption(String variant) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(variant,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600)),
          Text("Rs. 150", style: TextStyle(color: primaryColor)),
        ],
      ),
    );
  }
}
