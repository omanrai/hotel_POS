import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String name;
  final int quantity;

  const OrderItem({
    required this.name,
    required this.quantity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$name'),
          Text('$quantity'),
        ],
      ),
    );
  }
}
