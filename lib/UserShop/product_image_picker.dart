import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagePicker extends StatefulWidget {
  final void Function(File pickedImage) getImageValue;
  ProductImagePicker(this.getImageValue);

  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  var pickedImage;

  void imagePickerOption() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("เพิ่มรูปอาหาร"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  print("Camera");
                  pickImage(ImageSource.camera);
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.camera,
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                    Text(
                      "Camera",
                      style: TextStyle(
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  print("Gallery");
                  pickImage(ImageSource.gallery);
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.image,
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.close,
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                    Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  pickImage(ImageSource imageType) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final photo = await _picker.pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        this.pickedImage = tempImage;
        print(pickedImage);
        widget.getImageValue(pickedImage!);
      });

      Navigator.pop(context);
    } catch (error) {
      print(error);
    }
  }

  //   Get.bottomSheet(
  // SingleChildScrollView(
  //   child: ClipRRect(
  //     borderRadius: BorderRadius.only(
  //       topLeft: Radius.circular(10.0),
  //       topRight: Radius.circular(10.0),
  //     ),
  //     child: Container(
  //       color: Colors.white,
  //       height: 250,
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             Text(
  //               "Pic Image From",
  //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //               textAlign: TextAlign.center,
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             ElevatedButton.icon(
  //               onPressed: () {
  //                 print("Camera");
  //               },
  //               icon: Icon(Icons.camera),
  //               label: Text("Camera"),
  //             ),
  //             ElevatedButton.icon(
  //               onPressed: () {
  //                 print("Gallery");
  //               },
  //               icon: Icon(Icons.image),
  //               label: Text("Gallery"),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             ElevatedButton.icon(
  //               onPressed: () {
  //                 Get.back();
  //               },
  //               icon: Icon(Icons.close),
  //               label: Text("Cancel"),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ),
  // ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 100,
          height: 100,
          child: pickedImage != null
              ? Image.file(
                  pickedImage!,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  'https://static.thenounproject.com/png/2413564-200.png',
                  fit: BoxFit.cover,
                ),
        ),
        ElevatedButton.icon(
          onPressed: imagePickerOption,
          icon: Icon(Icons.image),
          label: Text('เพิ่มรูปอาหาร'),
        ),
      ],
    );
  }
}
