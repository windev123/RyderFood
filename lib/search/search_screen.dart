import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/product/product.dart';
import 'package:flutter_application_3/search/homesearch.dart';

class SearchScreen extends SearchDelegate {
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection("drink");

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['name']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/Versionbro.png'),
                  const SizedBox(height: 1),
                  const Text("ไม่มีรายการนี้กรุณาค้นหาใหม่ครับ"),
                ],
              );
            } else {
              print(snapshot.data);
              int index = 0;
              return ListView(children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['name']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((QueryDocumentSnapshot<Object?> data) {
                  final String name = data.get("name");
                  final String image = data.get("image");

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: ListTile(
                      onTap: () {
                        print('');
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) {
                            return HomeSearch(data);
                          }),
                        );
                      },
                      title: Text(name),
                      leading: Icon(Icons.search),
                    ),
                  );
                })
              ]);
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text(""));
  }
}
