import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';
import 'package:hotel_pos/features/Waiter/tab/kot/cart_screen.dart';
import 'package:hotel_pos/features/Waiter/tab/kot/order_item.dart';

import '../../../../core/widget/custom_snackbar.dart';
import '../../../../core/widget/transition_effect.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  final cartCount = 1;

  String selectedStatus = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Status"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
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
                      Navigator.of(context).push(slideTransition(CartScreen(
                        cartCount: cartCount,
                      )));
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 18,
                      color: primaryColor,
                    ),
                    label: Text(
                      'Edit',
                      // style: TextStyle(color: primaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 100),
                  Expanded(
                    child: PopupMenuButton<String>(
                      splashRadius: 0,
                      offset: Offset(0, 45),
                      // color: trans,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: Container(
                        padding: EdgeInsets.only(left: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              selectedStatus,
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  null, // Disabled as PopupMenuButton handles the tap
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                          ],
                        ),
                      ),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Pending',
                          child: Text(
                            'Pending',
                            style: TextStyle(
                                color: secondaryColor, letterSpacing: 0.5),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Complete',
                          child: Text(
                            'Complete',
                            style: TextStyle(
                                color: Colors.green, letterSpacing: 0.5),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Cancelled',
                          child: Text(
                            'Cancelled',
                            style: TextStyle(
                                color: Colors.red, letterSpacing: 0.5),
                          ),
                        ),
                      ],
                      onSelected: (String status) {
                        setState(() {
                          selectedStatus = status;
                        });
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32),

              // Order Details Card
              Card(
                color: Colors.blue[100],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'KOT #2',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Table No. 5',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Table'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '29 Jan 2025',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('07:15 PM'),
                            ],
                          ),
                        ],
                      ),

                      Text('Entry By: Oman rai'),
                      SizedBox(height: 16),

                      // Order Items
                      OrderItem(name: 'Iced Latte', quantity: 1),
                      OrderItem(name: 'Coffee', quantity: 3),
                      OrderItem(name: 'Burger - Chicken', quantity: 2),
                      OrderItem(name: 'Coke', quantity: 6),
                      OrderItem(name: 'Burger - Chicken', quantity: 1),
                      OrderItem(name: 'Water', quantity: 1),
                      OrderItem(name: 'Chicken Pizza - Small', quantity: 2),

                      Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '16',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),
                      Text(
                        'Remarks:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Chicken Pizza - Small: make it spicy and no mushroom added.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20), // Actions Footer
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);

                        showSuccessSnackBar(context,
                            "Send KOT to Print Successfully.", Colors.green);
                      },
                      icon: Icon(
                        Icons.print_outlined,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('Send KOT'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
