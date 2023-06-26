import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/Cart/cart_data.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/HomeShop/homeshop.dart';
import 'package:flutter_application_3/UserShop/ScreenShop.dart';
import 'package:flutter_application_3/user/Me.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileShop extends StatefulWidget {
  const EditProfileShop({Key? key}) : super(key: key);

  @override
  State<EditProfileShop> createState() => _EditProfileShopState();
}

class _EditProfileShopState extends State<EditProfileShop> {
  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 30),
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController!.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _surnameController;
  TextEditingController? _ImageController;
  TextEditingController? _genderController;
  TextEditingController? _ageController;
  TextEditingController? _dobController;
  TextEditingController? _shopnameController;
  // TextEditingController? _marketController;
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  // PickedFile? _pickedFile;
  // final _picked = ImagePicker();
  // Future<void> _pickImage() async {
  //   _pickedFile = await _picked.getImage(source: ImageSource.gallery);
  //   if (_pickedFile != null) {
  //     setState(() {
  //       _image = File(_pickedFile!.path);
  //     });
  //   }
  // }

  setDataToTextField(data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.all(10),
            //   child: Column(
            //     children: [
            //       Spacer(),
            //       image != null
            //           ? Image.file(
            //               image!,
            //               width: 160,
            //               height: 160,
            //               fit: BoxFit.cover,
            //             )
            //           : FlutterLogo(size: 20),
            //       const SizedBox(height: 24),
            //       Text(
            //         'Image Picker',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.center,
            //   child: CircleAvatar(
            //     radius: 101,
            //     backgroundColor: Color.fromARGB(255, 0, 0, 0),
            //     child: ClipOval(
            //       child: SizedBox(
            //         width: 200.0,
            //         height: 200.0,
            //         child: image != _ImageController
            //             ? ClipOval(
            //                 child: Image.file(
            //                   File(image!.path),
            //                   width: 85,
            //                   height: 85,
            //                   fit: BoxFit.cover,
            //                 ),
            //               )
            //             : Center(
            //                 child: const Text(
            //                 "โปรดเพิ่มรูปภาพครับ",
            //                 style: TextStyle(
            //                     color: Color.fromARGB(255, 255, 255, 255)),
            //               )),
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: 60.0),
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.add_photo_alternate_rounded,
            //       size: 30.0,
            //     ),
            //     onPressed: () {
            //       pickImage(ImageSource.gallery);
            //       // _pickImage();
            //     },
            //   ),
            // ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "ชื่อร้าน",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _shopnameController =
                  TextEditingController(text: data['shopname']),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "ชื่อ",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _nameController =
                  TextEditingController(text: data['name']),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "นามสกุล",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _surnameController =
                  TextEditingController(text: data['surname']),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "เบอร์โทรศัพท์",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _phoneController =
                  TextEditingController(text: data['phone']),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "เพศ",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _genderController =
                  TextEditingController(text: data['gender']),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "อายุ",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _ageController =
                  TextEditingController(text: data['age']),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 5,
            //     ),
            //     Text(
            //       "ชื่อร้าน",
            //       style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // TextFormField(
            //   controller: _marketController =
            //       TextEditingController(text: data['market']),
            // ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // TextField(
        //   keyboardType: TextInputType.text,
        //   controller: _dobController = TextEditingController(text: data['dob']),
        //   readOnly: true,
        //   decoration: InputDecoration(
        //     hintText: "กรุณาป้อนวันเกิด",
        //     suffixIcon: IconButton(
        //         onPressed: () => _selectDateFromPicker(context),
        //         icon: Icon(Icons.calendar_today_outlined)),
        //   ),
        // ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
              child: Wrap(
                children: [
                  Text(
                    "แก้ไขข้อมูล",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                elevation: 3,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("คุณแน่ใจที่จะเเก้ไขข้อมูล?"),
                          content:
                              Text("ถ้าหากแก้ไขข้อมูลแล้วข้อมูลเดิมจะหายไป!"),
                          actions: [
                            MaterialButton(
                              onPressed: () async => {
                                Navigator.pop(context),
                                updateData(),
                                Fluttertoast.showToast(
                                    msg: "คุณได้แก้ไขข้อมูลแล้วครับ".toString(),
                                    gravity: ToastGravity.BOTTOM),
                              },
                              child: Text("ใช่"),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("ไม่"),
                            ),
                          ],
                        ));
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(builder: (_) {
                //     return Home();
                //   }),
                // ),
                // updateData(),
                // Fluttertoast.showToast(
                //   msg: "แก้ไขแล้วครับ".toString(),
                // )
              }),
        ),
      ],
    );
  }

  updateData() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("usershop-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "name": _nameController!.text,
      "shopname": _shopnameController!.text,
      "surname": _surnameController!.text,
      "phone": _phoneController!.text,
      "age": _ageController!.text,
      "gender": _genderController!.text,
      // "market": _marketController!.text,
    }).then((value) => print("Updated Successfully"));
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              print('');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) {
                  return ScreenShop();
                }),
              );
            },
          ),
          backgroundColor: Color.fromARGB(215, 188, 187, 187),
          elevation: 10,
          title: Text("แก้ไขข้อมูล",
              style: TextStyle(
                color: Color.fromARGB(255, 249, 249, 249),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 870,
                width: 650,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 254),
                  border: Border.all(
                      color: Color.fromARGB(255, 255, 254, 254), width: 8.0),
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
        ));
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle == null ? "" : subtitle),
      leading: Icon(icon),
      trailing: const Icon(Icons.arrow_right),
      onTap: () {
        onPressed();
      },
    );
  }
}
