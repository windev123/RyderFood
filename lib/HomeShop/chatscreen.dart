import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/HomeShop/sender_bubble.dart';
import 'package:flutter_application_3/UserShop/ScreenShop.dart';
import 'package:flutter_application_3/UserShop/data_controller.dart';
import 'package:flutter_application_3/UserShop/product_image_picker.dart';
import 'package:get/get.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({Key? key}) : super(key: key);
  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Title",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              color: Color.fromARGB(255, 212, 57, 57),
              child: ListView(
                children: [
                  senderBubble(),
                  senderBubble(),
                ],
              ),
            )),
            Row(
              children: [
                SizedBox(
                  width: 320,
                  height: 40,
                  child: Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 227, 22, 22))),
                        hintText: ""),
                  )),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.message)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
