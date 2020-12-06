import 'package:flutter/material.dart';

Widget homeCardItem(Function onPressed, String imagePath, String title,
    String description, Color color) {
  return GestureDetector(
    onTap: () => onPressed(),
    child: Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        color: color,
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 50,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}
