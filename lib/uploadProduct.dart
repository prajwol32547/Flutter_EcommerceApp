import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'Field.dart';

enum typeValue { Budho, Sports, New }

class uploadProduct extends StatefulWidget {
  @override
  State<uploadProduct> createState() => _uploadProductState();
}

class _uploadProductState extends State<uploadProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final DescriptionController = TextEditingController();
  typeValue _choose = typeValue.Budho;

  var pickedimage;
  late var latestfilepath;

  Future pickimage(ImageSource imageType) async {
    final ImagePicker picker = new ImagePicker();
    try {
      var photo = await picker.pickImage(source: imageType);
      if (photo == null) return;
      var tempImage = File(photo.path);
      setState(() async {
        this.pickedimage = tempImage;
        print(pickedimage);
        Directory newpath = await getApplicationDocumentsDirectory();
        latestfilepath = newpath.path;
      });
    } catch (e) {
      print(e);
    }
  }

  uploadAll(dynamic url) {
    var itsname = nameController.text.trim();
    var itsDescripton = DescriptionController.text.trim();
    var itsprice = int.parse(priceController.text.trim());
    var itsurl = url;
    var choice = _choose;
    Map<String, dynamic> productdata = {
      "image": itsurl,
      "name": itsname,
      "price": itsprice,
      "Description": itsDescripton
    };
    if (choice == typeValue.Budho) {
      FirebaseFirestore.instance.collection('Budho').add(productdata);
    } else if (choice == typeValue.New) {
      FirebaseFirestore.instance.collection('Cycle').add(productdata);
    } else {
      FirebaseFirestore.instance.collection('sports').add(productdata);
    }
  }

  uploadFile(dynamic latestfilepath) async {
    if (latestfilepath == null) {
      return null;
    } else {
      print("Here is the path: ${latestfilepath}");
      var stringTypeImg = latestfilepath.toString();
      var name = stringTypeImg.lastIndexOf('/');
      print("This is name:${name}");
      var path = stringTypeImg.substring(name + 1);
      var ref = FirebaseStorage.instance.ref().child('files').child(path);
      var response = await ref.putFile(latestfilepath);
      if (response.state == TaskState.success) {
        Get.snackbar("success", "uploaded");
        var strUrl = await ref.getDownloadURL();
        uploadAll(strUrl);
      } else {
        Get.snackbar("failed", "Try again");
      }
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    // void openFile(PlatformFile file) {
    //   OpenFile.open(file.path!);
    // }
    // uploadFile(PlatformFile file) {
    //   final path = 'files/${file.name}';
    // }

    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Wrap(
                runSpacing: 30,
                children: [
                  Column(
                    children: [
                      Text("product name:"),
                      Field(nameController, context, "Product Name")
                    ],
                  ),
                  Column(
                    children: [
                      Text("product Price:"),
                      Field(priceController, context, "Product Name")
                    ],
                  ),
                  Column(
                    children: [
                      Text("product Description:"),
                      Field(DescriptionController, context, "Product Name")
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: const Text("Budho"),
                        leading: Radio(
                          groupValue: _choose,
                          value: typeValue.Budho,
                          onChanged: (value) {
                            setState(() {
                              _choose = value!;
                              print(_choose);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text("New"),
                        leading: Radio(
                          groupValue: _choose,
                          value: typeValue.New,
                          onChanged: (value) {
                            setState(() {
                              _choose = value!;
                              print(_choose);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text("sports"),
                        leading: Radio(
                          groupValue: _choose,
                          value: typeValue.Sports,
                          onChanged: (value) {
                            setState(() {
                              _choose = value!;
                              print(_choose);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                      child: Text("select file"),
                      onPressed: () {
                        pickimage(ImageSource.gallery);
                      }),
                  ElevatedButton(
                      child: Text("upload file"),
                      onPressed: () {
                        uploadFile(pickedimage);
                      })
                ],
              )),
        ),
      ),
    );
  }
}
