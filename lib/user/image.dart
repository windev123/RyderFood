import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/firebase/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUp extends StatefulWidget {
  @override
  State<ImageUp> createState() => _ImageUpState();
}

class _ImageUpState extends State<ImageUp> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  List<String> gender = ["ชาย", "หญิง", "อื่นๆ"];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? imageUrl;
  String? image = '';
  File? imageXFile;
  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("users-form-data")
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
        imageXFile = File(croppedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            print('');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) {
                return Home();
              }),
            );
          },
        ),
        backgroundColor: Color.fromARGB(215, 188, 187, 187),
        elevation: 10,
        title: Text("แก้ไข",
            style: TextStyle(
              color: Color.fromARGB(255, 112, 112, 112),
              fontSize: 18,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 800,
              width: 650,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 254),
                border: Border.all(
                    color: Color.fromARGB(255, 255, 254, 254), width: 8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _showImageDialog();
                        },
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          minRadius: 65.0,
                          child: CircleAvatar(
                            radius: 80.0,
                            backgroundImage: imageXFile == null
                                ? NetworkImage(image!)
                                : Image.file(imageXFile!).image,
                          ),
                        ),
                      ),
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
                          // Text(
                          //   "ชื่อ",
                          //   style: TextStyle(
                          //       color: Colors.blueGrey, fontSize: 14.0),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // TextFormField(
                      //   controller: _nameController =
                      //       TextEditingController(text: 'name'),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
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
                            onPressed: () async {
                              if (imageXFile == null) {
                                Fluttertoast.showToast(msg: "กรุณาเลือกรูป");
                                return;
                              }
                              try {
                                final ref = FirebaseStorage.instance
                                    .ref()
                                    .child("image")
                                    .child(DateTime.now().toString() + '.jpg');
                                await ref.putFile(imageXFile!);
                                imageUrl = await ref.getDownloadURL();
                                FirebaseFirestore.instance
                                    .collection("users-form-data")
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
