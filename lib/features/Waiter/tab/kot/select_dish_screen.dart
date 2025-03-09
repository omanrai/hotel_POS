import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hotel_pos/features/Waiter/tab/kot/cart_screen.dart';

import '../../../../core/widget/custom_snackbar.dart';

class SelectDishScreen extends StatefulWidget {
  const SelectDishScreen({super.key});

  @override
  _SelectDishScreenState createState() => _SelectDishScreenState();
}

class _SelectDishScreenState extends State<SelectDishScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedVariant = "Small";

  int count = 1;
  int cartCount = 0;
  final bool _showBadge = true;

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
      "image": "assets/food/burger.jpg",
      "category": "Lunch"
    },
    {
      "name": "Pizza",
      "price": 799,
      "image": "assets/food/pizza.jpg",
      "category": "Lunch"
    },
    {
      "name": "Orange Juice",
      "price": 160,
      "image": "assets/food/orangejuice.jpg",
      "category": "Beverages"
    },
    {
      "name": "Coffee",
      "price": 120,
      "image": "assets/food/coffee.jpg",
      "category": "Beverages"
    },
    {
      "name": "Steak",
      "price": 1500,
      "image": "assets/food/steak.jpg",
      "category": "Dinner"
    },
    {
      "name": "Pasta",
      "price": 150,
      "image": "assets/food/pasta.jpg",
      "category": "Dinner"
    },
    {
      "name": "Pancakes",
      "price": 100,
      "image": "assets/food/pancakes.jpg",
      "category": "Breakfast"
    },
    {
      "name": "Omelette",
      "price": 120,
      "image": "assets/food/omelette.jpg",
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
              showBadge: cartCount != 0 ? _showBadge : !_showBadge,
              badgeContent: Text(
                cartCount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              child: Icon(Icons.shopping_cart),
            ),
            onPressed: () async {
              setState(() {
                cartCount == 0;
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cartCount: cartCount,
                  ),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          labelStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.6),
          indicatorColor: secondaryColor,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: darkGrey,
          indicatorWeight: 3,
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
                  item["image"],
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
        return StatefulBuilder(
          // Ensures state updates within the bottom sheet
          builder: (context, setStateSheet) {
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                            count = 1;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            item["image"],
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
                              borderRadius: BorderRadius.circular(8),
                              color: primaryColor,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setStateSheet(() {
                                      if (count > 1) {
                                        count--; // Prevents going below 1
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.remove,
                                      size: 16, color: Colors.white),
                                ),
                                SizedBox(width: 8),
                                Text(count.toString(),
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    setStateSheet(() {
                                      count++;
                                    });
                                  },
                                  icon: Icon(Icons.add,
                                      size: 16, color: Colors.white),
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
                        _buildVariantOption("Small", setStateSheet),
                        const SizedBox(width: 10),
                        _buildVariantOption("Medium", setStateSheet),
                        const SizedBox(width: 10),
                        _buildVariantOption("Large", setStateSheet),
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
                    const SizedBox(height: 250),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                cartCount++;
                              });
                              Navigator.pop(context);
                              showSuccessSnackBar(
                                  context,
                                  "Order placed in cart Successfully",
                                  Colors.green);
                            },
                            child: const Text("Add to Cart"),
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
      },
    );
  }

  Widget _buildVariantOption(String variant, Function setStateSheet) {
    return GestureDetector(
      onTap: () {
        setStateSheet(() {
          selectedVariant = variant;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selectedVariant == variant
              ? Colors.blue[100]
              : Colors.transparent, // Change color when selected
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              variant,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text("Rs. 150", style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
