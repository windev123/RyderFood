import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants/colors.dart';
import 'package:flutter_application_3/item.dart';

class ItemDescription extends StatelessWidget {
  final Item item;

  ItemDescription({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, bottom: 0, top: 0),
              child: Row(
                children: <Widget>[],
              ),
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  item.imageUrl,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                      ),
                                      child: Icon(Icons.remove,
                                          color: Colors.black),
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      width: 48,
                                      height: 48,
                                      child: Column(
                                        children: [
                                          Text(
                                            "1",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child:
                                          Icon(Icons.add, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Text(
                                  item.price + r' บาท ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ])
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
