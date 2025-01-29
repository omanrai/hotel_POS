import 'package:flutter/material.dart';
import 'package:hotel_pos/core/app_colors.dart';

class DeleteItemScreen extends StatelessWidget {
  final List<Map<int, List<Map<String, dynamic>>>> deletedTables;

  const DeleteItemScreen({super.key, required this.deletedTables});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deleted Tables')),
      body: deletedTables.isEmpty
          ? Center(child: Text("No deleted tables"))
          : ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(10),
              children: deletedTables.map((table) {
                int tableNumber = table.keys.first;
                List<Map<String, dynamic>> orders = table[tableNumber]!;

                return GestureDetector(
                  onTap: () {
                    _showDeletedOrderDetails(context, tableNumber, orders);
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
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/logo/logo.png",
                            width: 50, height: 50),
                        Text(
                          "Table $tableNumber",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text("${orders.length} Items"),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }

  void _showDeletedOrderDetails(BuildContext context, int tableNumber,
      List<Map<String, dynamic>> orders) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Table $tableNumber Orders")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: orders.map((item) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['name'], style: TextStyle(fontSize: 16)),
                  Text("x ${item['quantity']}", style: TextStyle(fontSize: 16)),
                ],
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close", style: TextStyle(color: primaryColor)),
            ),
          ],
        );
      },
    );
  }
}
