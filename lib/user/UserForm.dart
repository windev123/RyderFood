import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Login/user_login.dart';
import 'package:flutter_application_3/user/Login.dart';
import 'package:flutter_application_3/user/sign%20in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  // TextEditingController _marketController = TextEditingController();
  List<String> gender = ["ชาย", "หญิง", "อื่นๆ"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 30),
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "name": _nameController.text,
          "surname": _surnameController.text,
          "phone": _phoneController.text,
          "dob": _dobController.text,
          "gender": _genderController.text,
          "age": _ageController.text,
          "image": _imageController.text,
          // "market": _marketController.text,
        })
        .then((value) => print("user data added"))
        .catchError((error) => print("something is wrong"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "DzenShop ,",
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  Text(
                    "พวกเราจะเก็บรักษาข้อมูลให้ดีที่สุด      โปรดไว้ใจพวกเรา",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFFBBBBBB),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "กรุณาป้อนชื่อ"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _surnameController,
                    decoration: InputDecoration(hintText: "กรุณาป้อนนามสกุล"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _phoneController,
                    decoration:
                        InputDecoration(hintText: "กรุณาป้อนเบอร์โทรศัพท์"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _dobController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "กรุณาป้อนวันเกิด",
                      suffixIcon: IconButton(
                          onPressed: () => _selectDateFromPicker(context),
                          icon: Icon(Icons.calendar_today_outlined)),
                    ),
                  ),
                  TextField(
                    controller: _genderController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "เพศ",
                      prefixIcon: DropdownButton<String>(
                        items: gender.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                            onTap: () {
                              setState(() {
                                _genderController.text = value;
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: InputDecoration(
                      hintText: "กรุณาป้อนอายุ",
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        "ดำเนินการต่อ",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        elevation: 3,
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "สมัครสมาชิกสำเสร็จแล้วครับ".toString(),
                            gravity: ToastGravity.CENTER);
                        sendUserDataToDB();
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (_) {
                          return LoginPage();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
