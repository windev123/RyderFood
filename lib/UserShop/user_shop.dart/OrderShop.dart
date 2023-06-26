import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/UserShop/user_shop.dart/historyshop.dart';

class OrderShop extends StatefulWidget {
  const OrderShop({Key? key}) : super(key: key);

  @override
  State<OrderShop> createState() => _OrderShopState();
}

class _OrderShopState extends State<OrderShop> {
  var now = DateTime.now();
  int totalxs = 0;
  @override
  Widget build(BuildContext context) {
    body:
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.network(
              'https://firebasestorage.googleapis.com/v0/b/dzenshop-1fb49.appspot.com/o/GIF%2Fgiphy.gif?alt=media&token=98f325e1-7395-40bc-b7ff-4645e37d47ae',
              fit: BoxFit.fill),
          Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("order")
                      .doc("nawinklo@gmail.com")
                      .collection("order")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    Future addtostatus() async {
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      var currentUser = _auth.currentUser;
                      CollectionReference _collectionRef =
                          FirebaseFirestore.instance.collection("status");
                      {
                        print(currentUser!.email);

                        _collectionRef.doc("nawinklo@gmail.com").set({
                          "status": "กำลังดำเนินการจัดส่ง",
                          "image":
                              "https://firebasestorage.googleapis.com/v0/b/dzenshop-1fb49.appspot.com/o/GIF%2Fgiphy%20(2).gif?alt=media&token=3039f5ce-30f2-40f2-b6d2-5aaee461770e"
                        }).then((value) => print("status"));
                      }
                    }

                    Future adddelete() async {
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      for (var i = 0; i < snapshot.data!.docs.length; i++) {
                        FirebaseFirestore.instance
                            .collection("order")
                            .doc("nawinklo@gmail.com")
                            .collection("order")
                            .doc('${snapshot.data!.docs[i]['id'].toString()}')
                            .delete();
                      }
                    }

                    Future addtoOrder() async {
                      CollectionReference _collectionRef =
                          FirebaseFirestore.instance.collection("order-rider");
                      for (var i = 0; i < snapshot.data!.docs.length; i++) {
                        print('${snapshot.data!.docs[i]['name'].toString()}');

                        _collectionRef
                            .doc("nawinklo@gmail.com")
                            .collection("order")
                            .doc(
                              '${snapshot.data!.docs[i]['id'].toString()}',
                            )
                            .set({
                          "email": ("nawinklo@gmail.com"),
                          "id": '${snapshot.data!.docs[i]['id'].toString()}',
                          "name":
                              '${snapshot.data!.docs[i]['name'].toString()}',
                          "price":
                              '${snapshot.data!.docs[i]['price'].toString()}',
                          "images":
                              '${snapshot.data!.docs[i]['images'].toString()}',
                          "market":
                              '${snapshot.data!.docs[i]['market'].toString()}',
                          "quantity":
                              " ${snapshot.data!.docs[i]['quantity'].toString()}",
                          "sumprice":
                              '${snapshot.data!.docs[i]['sumprice'].toString()}',
                          "total": totalxs.toString().trim(),
                        }).then((value) => print("Added to Order"));
                      }
                    }

                    for (int i = 0; i < snapshot.data!.docs.length; i++)
                      // total = total +
                      //     int.parse(
                      //         '${snapshot.data!.docs[i]['sumprice'].toString()}');
                      // print('จำนวน');
                      // print(i);
                      // print('ราคาล่าสุด');
                      // print(
                      //     '${snapshot.data!.docs[i]['sumprice'].toString()}');
                      // print(totalxs.toString().trim());
                      // print('ราคาทั้งหมด');
                      // print('${snapshot.data!.docs[i]['sumprice'].toString()}');
                      // print(totalxs.toString().trim());
                      print('${snapshot.data!.docs[i]['name'].toString()}');
                    // print('isss');
                    // print(snapshot.data!.docs.length);
                    // print(snapshot.data!.docs.length);
                    // print(
                    //     '${snapshot.data!.docs[i]['name'].toString()}');
                    // print("Added to Order");
                    // print(
                    //     "${snapshot.data!.docs[i]['name'].toString()}");

                    if (snapshot.data == null) {
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }

                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Stack(
                              children: <Widget>[
                                // Stroked text as border.
                                Text(
                                  'รายการอาหาร',
                                  style: TextStyle(
                                    fontSize: 18,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 4
                                      ..color = Colors.grey[700]!,
                                  ),
                                ),
                                // Solid text as fill.
                                Text(
                                  'รายการอาหาร',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (int i = 0; i < snapshot.data!.docs.length; i++)
                            ListTile(
                              leading: Container(
                                height: 70,
                                width: 70,
                                child: Image.network(
                                    '${snapshot.data!.docs[i]['images'].toString()} ',
                                    fit: BoxFit.fill),
                              ),
                              title: Wrap(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${snapshot.data!.docs[i]['name'].toString()}:',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        " ${snapshot.data!.docs[i]['quantity'].toString()}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 119, 0)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                " ${snapshot.data!.docs[i]['sumprice'].toString()}฿",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 119, 0)),
                              ),
                            ),
                          Container(
                            height: 50,
                            color: Color.fromARGB(255, 248, 248, 249),
                            child: Row(
                              children: [
                                ElevatedButton(
                                    child: Wrap(
                                      children: [
                                        Text(
                                          "ทำเสร็จแล้ว",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                        SizedBox(
                                          width: 18,
                                        ),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(215, 188, 187, 187),
                                      elevation: 3,
                                    ),
                                    onPressed: () async => {
                                          showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                    content: Text(
                                                        "คนขับรับออเดอร์แล้ว?"),
                                                    actions: [
                                                      MaterialButton(
                                                        onPressed: () async => {
                                                          Navigator.pop(
                                                              context),
                                                          addtoOrder(),
                                                          adddelete(),
                                                          addtostatus(),
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              /////////////////////////////ข้อความเตื่อน
                                                              content: Text(
                                                                "คนขับได้รับออเดอร์แล้ว",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        },
                                                        child: Text("ใช่"),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("ไม่"),
                                                      ),
                                                    ],
                                                  )),
                                          // addtoOrder(),
                                          // adddelete(),
                                          // addtostatus(),
                                          // print('items'),
                                        }),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: ElevatedButton(
                                      child: Wrap(
                                        children: [
                                          Text(
                                            "ประวัติการขาย",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(215, 188, 187, 187),
                                        elevation: 3,
                                      ),
                                      onPressed: () async => {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        HistoryShop())),
                                          }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
