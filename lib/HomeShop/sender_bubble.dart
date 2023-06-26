import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget senderBubble() {
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 164, 164, 164),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        )),
    child: Column(
      children: [
        Text(
          "Message",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "11:45 PM",
          style:
              TextStyle(color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5)),
        ),
      ],
    ),
  );
}
