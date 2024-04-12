import 'package:closet/model/ScreenSize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageScreen extends StatefulWidget {
  final updateData;

  ImageScreen({required this.updateData});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  XFile? _selectedImage;
  UploadTask? uploadTask;
  final user = FirebaseAuth.instance.currentUser;
  String? _loc;
  bool _uploadLoading = false;

  Future uploadFile(String category) async {
    
    setState(() {
      _uploadLoading = true;
    });
    print("In Function");

    final ref = FirebaseStorage.instance
        .ref()
        .child("${user!.uid}/category/${_selectedImage!.name}");

    print("Printing");

    UploadTask uploadTask = ref.putFile(File(_selectedImage!.path));
    TaskSnapshot snapshot = await uploadTask;

    var imageURL = await snapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("user_clothes")
        .doc(user!.uid)
        .collection(category)
        .add({"url": imageURL});

    print("${imageURL}");
    widget.updateData(category,imageURL);
    setState(() {
      _uploadLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Screensize.w(context) * 47),
        child: _selectedImage == null
            ? Column(
                children: [
                  SizedBox(
                    height: Screensize.h(context) * 149,
                  ),
                  Text(
                    "Add Clothes To Your Wardrobe",
                    style: GoogleFonts.publicSans(
                      textStyle: TextStyle(fontSize: 30),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Screensize.h(context) * 100,
                  ),
                  GestureDetector(
                    onTap: _pickFromGallery,
                    child: Container(
                      height: Screensize.h(context) * 61,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Pick from Gallery",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: _pickFromCamera,
                    child: Container(
                      height: Screensize.h(context) * 61,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Click Photo",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screensize.h(context) * 100,
                  ),
                ],
              )
            : Column(
                children: [
                  SizedBox(
                    height: Screensize.h(context) * 156,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: Screensize.h(context) * 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                    child: Image.file(File(_selectedImage!.path)),
                  ),
                  SizedBox(
                    height: Screensize.h(context) * 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                    child: CircleAvatar(
                      radius: 30,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: Screensize.h(context) * 20,
                  ),
                  Container(
                    height: Screensize.h(context) * 169,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Screensize.w(context) * 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButton(
                            // underline: Container(),
                            isExpanded: true,
                            hint: Text("Choose a category"),
                            items: <String>[
                              'Jacket',
                              'T-Shirt',
                              'Jeans',
                              'Shoes'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: GoogleFonts.publicSans(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              );
                            }).toList(),
                            value: _loc,
                            onChanged: (_val) {
                              setState(() {
                                _loc = _val;
                              });
                            },
                          ),
                          !_uploadLoading
                              ? GestureDetector(
                                  onTap: () => uploadFile(_loc!),
                                  child: Container(
                                    height: Screensize.h(context) * 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    padding: EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Upload",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: Screensize.h(context) * 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future _pickFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = returnedImage;
    });
  }

  Future _pickFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = returnedImage;
    });
  }
}
