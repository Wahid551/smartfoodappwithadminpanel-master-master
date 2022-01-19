import 'package:flutter/material.dart';

class ProductUnit extends StatelessWidget {
  late final VoidCallback onTap;
  late final String title;
  ProductUnit({required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 5),
        height: 25,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                "$title",
                style: TextStyle(fontSize: 10),
              ),
            ),
            Center(
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.black87,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
