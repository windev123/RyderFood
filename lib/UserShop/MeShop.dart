import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/UserShop/ChangePassShop.dart';
import 'package:flutter_application_3/UserShop/ContactScreenShop.dart';
import 'package:flutter_application_3/UserShop/Edit_profileShop.dart';
import 'package:flutter_application_3/download%20page/download_page.dart';
import 'package:flutter_application_3/user/ConTact.dart';
import 'package:flutter_application_3/user/Edit_profile.dart';
import 'package:flutter_application_3/user/change_pass.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MeShop extends StatefulWidget {
  const MeShop({Key? key}) : super(key: key);

  @override
  State<MeShop> createState() => _MeShopState();
}

class _MeShopState extends State<MeShop> {
  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("usershop-form-data")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((snapshop) async {
      if (snapshop.exists) {
        setState(() {
          image = snapshop.data()!["image"];
        });
      }
    });
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("แก้ไขรูปโปรไฟล์"),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            InkWell(
              onTap: () {
                _getFromCamera();
              },
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.camera,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _getFromGallery();
              },
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.image,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "Gallery",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  File? imageFile;
  String? imageUrl;
  String? image = '';
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _surnameController;
  TextEditingController? _ImageController;
  TextEditingController? _shopnameController;
  // TextEditingController? _marketController;
  setDataToTextField(data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    _showImageDialog();
                  },
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    minRadius: 0.0,
                    child: CircleAvatar(
                      radius: 62.0,
                      backgroundImage: imageFile == null
                          ? NetworkImage(image!)
                          : Image.file(imageFile!).image,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0),
              SizedBox(
                height: 36,
                width: 200,
                child: ElevatedButton(
                    child: Wrap(
                      children: [
                        Text(
                          "ยืนยันแก้ไขProfile",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black54,
                      elevation: 10,
                    ),
                    onPressed: () async {
                      if (imageFile == null) {
                        Fluttertoast.showToast(msg: "กรุณาเลือกรูป");
                        return;
                      }
                      try {
                        Fluttertoast.showToast(
                            msg: "บันทึกรูปแล้วครับ".toString(),
                            gravity: ToastGravity.BOTTOM_LEFT);
                        final ref = FirebaseStorage.instance
                            .ref()
                            .child("image")
                            .child(DateTime.now().toString() + '.jpg');
                        await ref.putFile(imageFile!);
                        imageUrl = await ref.getDownloadURL();
                        FirebaseFirestore.instance
                            .collection("usershop-form-data")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .update({
                          "image": imageUrl,
                        });
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                      } catch (error) {
                        Fluttertoast.showToast(msg: error.toString());
                      }
                    }),
              ),
            ],
          ),
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")),
          ),
        ),
        SizedBox(
          height: 0,
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text(
        //       'สวัสดีคุณ ' + auth.currentUser!.email.toString(),
        //       style: TextStyle(fontSize: 18),
        //     ),
        //   ],
        // ),
        SizedBox(
          height: 0,
        ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
        //   child: Text('สวัสดีคุณ ' + auth.currentUser!.email.toString()),
        // ),
        Column(
          children: [
            // Align(
            //   alignment: Alignment.center,
            //   child: CircleAvatar(
            //     radius: 55,
            //     backgroundColor: Color.fromARGB(255, 0, 0, 0),
            //     child: ClipOval(
            //       child: SizedBox(
            //         width: 100.0,
            //         height: 100.0,
            //         child: Image.network(
            //             "http://f.ptcdn.info/015/045/000/obj93gd82Gdem76oVlm-o.jpg",
            //             fit: BoxFit.fill),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        Container(
          color: Color.fromARGB(221, 123, 123, 123),
          height: 40,
          child: Center(
            child: Text(
              "ร้าน " + data['shopname'],
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 254, 254)),
            ),
          ),
        ),
        SizedBox(
          height: 0,
        ),
        Container(
          color: Color.fromARGB(214, 255, 255, 255),
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                "ข้อมูลทั่วไป",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),

        Wrap(alignment: WrapAlignment.start, children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            height: 30,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 10, 0),
              child: Wrap(
                children: [
                  SizedBox(
                    width: 0,
                  ),
                  Row(
                    children: [
                      Text(
                        "ชื่อ-นามสกุล:",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        data['name'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 6, 6, 6),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        data['surname'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),

        SizedBox(
          height: 3,
        ),

        // Container(
        //   color: Color.fromARGB(255, 255, 255, 255),
        //   width: 310,
        //   height: 50,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       SizedBox(
        //         width: 15,
        //       ),
        //       Text(
        //         "วัน/เดือน/ปีเกิด:",
        //         style: TextStyle(
        //           fontSize: 18,
        //           color: Color.fromARGB(255, 0, 0, 0),
        //         ),
        //       ),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       Text(
        //         data['dob'],
        //         style: TextStyle(
        //           fontSize: 18,
        //           color: Color.fromARGB(255, 0, 0, 0),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(
          height: 2,
        ),

        Wrap(alignment: WrapAlignment.start, children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 75,
                ),
                Row(
                  children: [
                    Text(
                      "เพศ:",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      data['gender'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),

        Wrap(alignment: WrapAlignment.start, children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 77,
                ),
                Text(
                  "อายุ:",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  data['age'],
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
        ]),
        // Wrap(alignment: WrapAlignment.start, children: [
        //   Container(
        //     color: Color.fromARGB(255, 255, 255, 255),
        //     height: 30,
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         SizedBox(
        //           width: 60,
        //         ),
        //         Text(
        //           "ชื่อร้าน:",
        //           style: TextStyle(
        //             fontSize: 13,
        //             color: Color.fromARGB(255, 0, 0, 0),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Text(
        //           data['market'],
        //           style: TextStyle(
        //             fontSize: 15,
        //             color: Color.fromARGB(255, 0, 0, 0),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ]),

        Container(
          color: Color.fromARGB(214, 255, 255, 255),
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                "ข้อมูลการติดต่อ",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 8, 8, 8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          color: Color.fromARGB(255, 255, 255, 255),
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                "เบอร์โทร:",
                style: TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                data['phone'],
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          color: Color.fromARGB(255, 255, 255, 255),
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                "อีเมล์:",
                style: TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                auth.currentUser!.email.toString(),
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 300,
              child: ElevatedButton(
                  child: Wrap(
                    children: [
                      Text(
                        "แก้ไขข้อมูล",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 141,
                      ),
                      Icon(
                        Icons.account_box,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(215, 188, 187, 187),
                    elevation: 3,
                  ),
                  onPressed: () async => {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) {
                            return EditProfileShop();
                          }),
                        ),
                      }),
            ),
          ],
        ),

        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 300,
              child: ElevatedButton(
                  child: Wrap(
                    children: [
                      Text(
                        "เปลี่ยนรหัสผ่าน",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 108,
                      ),
                      Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(215, 188, 187, 187),
                    elevation: 3,
                  ),
                  onPressed: () async => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChangePassShop())),
                      }),
            ),
          ],
        ),

        SizedBox(
          height: 20,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 300,
              child: ElevatedButton(
                  child: Wrap(
                    children: [
                      Text(
                        "ติดต่อฝ่ายสนับสนุน",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 72,
                      ),
                      Icon(
                        Icons.help_outline,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(215, 188, 187, 187),
                    elevation: 3,
                  ),
                  onPressed: () async => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ContactScreen2())),
                      }),
            ),
          ],
        ),

        SizedBox(
          height: 20,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 300,
              child: ElevatedButton(
                  child: Wrap(
                    children: [
                      Text(
                        "ออกจากระบบ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      Icon(
                        Icons.door_front_door_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(215, 188, 187, 187),
                    elevation: 3,
                  ),
                  onPressed: () async => {
                        Fluttertoast.showToast(
                            msg: "ออกจากระบบแล้ว".toString(),
                            gravity: ToastGravity.BOTTOM_LEFT),
                        auth.signOut().then((value) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return DownloadPage();
                          }));
                        }),
                      }),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("usershop-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "shopname": _shopnameController!.text,
      "name": _nameController!.text,
      "surname": _surnameController!.text,
      "phone": _phoneController!.text,
      "image": _ImageController!.text,
    }).then((value) => print("Updated Successfully"));
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.local_grocery_store_outlined),
            //   tooltip: 'Go to the next page',
            //   onPressed: () {
            //     print('');

            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (_) => Cart()));
            //   },
            // ),
            IconButton(
              color: Colors.black,
              icon: const Icon(Icons.message),
              tooltip: 'Go to the next page',
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              //   child: Image.asset(
              //     'images/15FT.jpg',
              //   ),
              // ),
              Wrap(
                children: [
                  Container(
                    height: 900,
                    width: 800,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(214, 255, 255, 255),
                      border: Border.all(color: Colors.black, width: 0.0),
                    ),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("usershop-form-data")
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        var data = snapshot.data;

                        if (data == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return setDataToTextField(data);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  // Widget _listTiles({
  //   required String title,
  //   String? subtitle,
  //   required IconData icon,
  //   required Function onPressed,
  // }) {
  //   return ListTile(
  //     title: Text(
  //       title,
  //       style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //     ),
  //     subtitle: Text(subtitle == null ? "" : subtitle),
  //     leading: Icon(icon),
  //     trailing: const Icon(Icons.arrow_right),
  //     onTap: () {
  //       onPressed();
  //     },
  //   );
  // }
}
