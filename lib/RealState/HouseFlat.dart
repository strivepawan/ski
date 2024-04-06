import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HouseFlat extends StatefulWidget {
  @override
  _HouseFlatState createState() => _HouseFlatState();
}

class _HouseFlatState extends State<HouseFlat> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  double price = 0.0;
  int area = 0;
  String description = '';
  final picker = ImagePicker();
  List<File?> images = []; // List to store selected images

  Future<void> pickImages() async {
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        images.addAll(pickedImages.map((image) => File(image.path)));
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sell Your Flat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'List Your Add',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text('Property for rent', style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 10,),
              Center(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () => pickImages(),
                    child: Text('Select Images'),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: List.generate(images.length, (index) {
                  return Stack(
                    children: [
                      if (images[index] != null)
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: FileImage(images[index]!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if (images[index] != null)
                        Positioned(
                          right: 0.0,
                          top: 0.0,
                          child: IconButton(
                            icon: Icon(Icons.clear, color: Colors.red),
                            onPressed: () => removeImage(index),
                          ),
                        ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Simulate submitting the data to OLX or your backend (replace with actual implementation)
                    // For demonstration purposes, print the submitted data
                    print('Title: $title');
                    print('Price: $price');
                    print('Area: $area');
                    print('Description: $description');
                    print('Images: $images');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
