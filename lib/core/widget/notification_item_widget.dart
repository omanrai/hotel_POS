import 'package:flutter/material.dart';

class NotificationItemWidget extends StatelessWidget {
  final String notificationTitle;
  final Color iconColor;
  final Color containerColor;
  final IconData iconName;
  const NotificationItemWidget({
    super.key,
    required this.notificationTitle,
    required this.iconColor,
    required this.containerColor,
    required this.iconName,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      // margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: containerColor,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            iconName,
            color: iconColor,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              notificationTitle,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
