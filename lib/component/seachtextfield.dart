import 'package:flutter/material.dart';
import 'package:fx_journal/constants.dart';

class SearchTextField extends StatelessWidget {

  final Map<String, dynamic>? total;

 SearchTextField({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20,right: 20),
      height: 65,
      width: 400,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 251, 251, 249),
              Color.fromARGB(255, 255, 255, 255),
            ],
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
  "Total Profit: ${total?['profit'] ?? '0.00'} \$",
),
            ],
          ),
          Row(
            children: [
              Text(
                "Total Loss: ${total?['loss'] ?? '0.00'} \$",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
