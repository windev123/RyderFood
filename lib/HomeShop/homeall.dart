import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/product/product.dart';

class HomeAll extends StatefulWidget {
  const HomeAll({Key? key}) : super(key: key);
  @override
  State<HomeAll> createState() => _HomeAllState();
}

class _HomeAllState extends State<HomeAll> {
  List _products = [];
  TextEditingController _searchController = TextEditingController();
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "products-id": qn.docs[i]["id"],
          "products-name": qn.docs[i]["name"],
          "products-image": qn.docs[i]["image"],
          "products-price": qn.docs[i]["price"],
          "products-market": qn.docs[i]["market"]
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(215, 188, 187, 187),
        elevation: 10,
        title: Stack(
          children: <Widget>[
            // Stroked text as border.
            Text(
              'อาหาร',
              style: TextStyle(
                fontSize: 18,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6
                  ..color = Colors.grey[700]!,
              ),
            ),
            // Solid text as fill.
            Text(
              'อาหาร',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.local_grocery_store_outlined,
              color: Color.fromARGB(255, 253, 253, 253),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 0.0,
            ),
            SizedBox(
              height: 0.0,
            ),
            SizedBox(
              height: 4.0,
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: GridView.builder(
                      itemCount: _products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.850,
                      ),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      ProductScreen(_products[index]))),
                          child: Card(
                            elevation: 3,
                            child: Column(children: [
                              // Container(
                              //   height: 23,
                              //   color: Color.fromARGB(255, 255, 255, 255),
                              //   child: Padding(
                              //     padding:
                              //         const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              //     child: Wrap(
                              //       alignment: WrapAlignment.start,
                              //       // spacing: 5,
                              //       // runSpacing: 5,
                              //       children: <Widget>[
                              //         Text(
                              //           "${_products[index]["products-market"]}",
                              //           overflow: TextOverflow.ellipsis,
                              //           style: TextStyle(fontSize: 10),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                  child: Image.network(
                                      _products[index]["products-image"],
                                      height: 150,
                                      width: 300,
                                      fit: BoxFit.fill)),
                              Container(
                                height: 23,
                                color: Color.fromARGB(255, 255, 255, 255),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    // spacing: 5,
                                    // runSpacing: 5,
                                    children: <Widget>[
                                      Text(
                                        "${_products[index]["products-name"]}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "${_products[index]["products-price"].toString()}฿",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 245, 123, 9),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        );
                      })),
            ),
          ],
        ),
      )),
    );
  }
}
