import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class DeleteItemScreen extends StatelessWidget {
  List<Map<int, List<Map<String, dynamic>>>> deletedTables = [];

  Map<int, List<Map<String, dynamic>>> tableOrders;

  DeleteItemScreen(
      {super.key, required this.deletedTables, required this.tableOrders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Item'),
      ),
      body: Expanded(
        child: Column(
          children: [
            _buildCookScreen(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCookScreen(BuildContext context) {
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
}
