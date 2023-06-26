import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/cart_data.dart';
import 'package:flutter_application_3/product/product.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  fetchProducts() async {
    var currentUser = _auth.currentUser;
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "id_product": qn.docs[i]["id_product"],
          "products-id": qn.docs[i]["id"],
          "products-name": qn.docs[i]["name"],
          "products-image": qn.docs[i]["image"],
          "products-price": qn.docs[i]["price"],
          "products-market": qn.docs[i]["market"],
          // "products-status": qn.docs[i]["status"]
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    // fatchCarouselImages();
    fetchProducts();
    // fatchDrink();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(215, 188, 187, 187),
        elevation: 10,
        title: Text("สินค้าที่ถูกใจ",
            style: TextStyle(
              fontSize: 18,
            )),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.local_grocery_store_outlined),
            tooltip: 'Go to the next page',
            onPressed: () {
              print('');

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Cart()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            tooltip: 'Go to the next page',
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-favourite-items")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot =
                      snapshot.data!.docs[index];
                  return Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  print(_documentSnapshot['name']);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ProductScreen(_products[index])));
                                },
                                child: Card(
                                  elevation: 6,
                                  child: ListTile(
                                    leading: Container(
                                      height: 70,
                                      width: 70,
                                      child: Image.network(
                                          _documentSnapshot["images"],
                                          fit: BoxFit.fill),
                                    ),
                                    title: Wrap(
                                      children: [
                                        Text(
                                          _documentSnapshot['name'],
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      " ${_documentSnapshot['price']}฿",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 255, 119, 0)),
                                    ),
                                    trailing: Wrap(
                                      children: [
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: Icon(
                                            Icons.remove_circle,
                                            size: 35,
                                          ),
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection(
                                                    "users-favourite-items")
                                                .doc(FirebaseAuth.instance
                                                    .currentUser!.email)
                                                .collection("items")
                                                .doc(_documentSnapshot.id)
                                                .delete();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
