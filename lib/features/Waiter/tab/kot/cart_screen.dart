import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';
import 'package:hotel_pos/core/widget/custom_snackbar.dart';
import 'package:hotel_pos/core/widget/transition_effect.dart';
import 'package:hotel_pos/features/Waiter/waiter_screen.dart';

class CartScreen extends StatelessWidget {
  final int cartCount = 1;
  CartScreen({super.key, required int cartCount});

  final List<CartItem> items = [
    CartItem(
      name: 'Burger Chicken',
      variant: 'large',
      variantPrice: 220.0,
      price: 440.0,
      quantity: 2,
      image: 'assets/logo/logo.png',
    ),
    CartItem(
      name: 'Chicken Pizza',
      variant: 'Small',
      variantPrice: 300.0,
      price: 600.0,
      quantity: 2,
      image: 'assets/logo/logo.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartCount == 0
          ? Center(
              child: Text("No food item added in Cart...!!!"),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      item.image,
                                      width: 40,
                                      height: 40,
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${item.variant}@ ${item.variantPrice}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${item.price}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutlinedButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.note_add_outlined),
                                        label: Text('Add remarks to Dish'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.black54,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {},
                                        style: IconButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Text(
                                          '${item.quantity}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {},
                                        style: IconButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'KOT Remarks',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              // fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'QTY: 4',
                            style: TextStyle(
                                // fontSize: 16,
                                ),
                          ),
                          Text(
                            '1040.0',
                            style: TextStyle(
                              // fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Pop the CartScreen
                                // Navigate with fade transition
                                // Navigator.of(context).pushReplacement(fadeTransition(_buildOrderScreen()));
                                showSuccessSnackBar(
                                    context,
                                    "Order placed Successfully and ready to print... !!!",
                                    Colors.green);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                foregroundColor: Colors.black54,
                                backgroundColor: darkGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text('Confirm & Print'),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Pop the CartScreen
                                showSuccessSnackBar(context,
                                    "Order placed Successfully", Colors.green);
                              },
                              child: Text('Confirm Order'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class CartItem {
  final String name;
  final String variant;
  final double variantPrice;
  final double price;
  final int quantity;
  final String image;

  CartItem({
    required this.name,
    required this.variant,
    required this.variantPrice,
    required this.price,
    required this.quantity,
    required this.image,
  });
}
