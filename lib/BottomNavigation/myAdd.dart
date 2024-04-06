import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import for image selection

class MyAdd extends StatefulWidget {
  const MyAdd({Key? key}) : super(key: key);

  @override
  State<MyAdd> createState() => _MyAddState();
}

class _MyAddState extends State<MyAdd> {
  final _formKey = GlobalKey<FormState>(); // For form validation
  List<XFile> _images = []; // List to store selected images

  // Functions to handle image selection from camera or gallery
  Future<void> _pickImageFromCamera() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final List<XFile>? images =
        await ImagePicker().pickMultiImage();
    if (images != null) {
      setState(() {
        _images.addAll(images);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell on OLX'), // More descriptive title
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image selection section
              Text(
                'Product Images (Max 5)',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Wrap(
                // Wrap for horizontal image layout
                spacing: 8.0,
                children: [
                  if (_images.isEmpty)
                    OutlinedButton.icon(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Add Images'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text('Take Photo'),
                                onTap: () => _pickImageFromCamera(),
                              ),
                              ListTile(
                                title: Text('Choose from Gallery'),
                                onTap: () => _pickImageFromGallery(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      icon: Icon(Icons.add_a_photo),
                      label: Text('Add'),
                    ),
                  for (var image in _images)
                    Stack(
                      children: [
                        Image.file(File(image.path)), // Display selected images
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => setState(() {
                              _images.remove(image);
                            }),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 16.0), // Spacing

              // Product details form fields
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product title.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: null, // Allow multiline for detailed descriptions
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product description.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number, // For numeric input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              DropdownButtonFormField<String>(
                // Category selection (replace with actual data)
                value: null, // Initially no selection
                hint: Text('Select Category'),
                items: [
                  DropdownMenuItem(
                    value: 'Category 1',
                    child: Text('Category 1'),
                  ),
                  DropdownMenuItem(
                    value: 'Category 2',
                    child: Text('Category 2'),
                  ),
                  DropdownMenuItem(
                    value: 'Category 3',
                    child: Text('Category 3'),
                  ),
                  // Add more dropdown items as needed
                ],
                onChanged: (value) {
                  // Implement your category selection logic here
                },
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  // Implement your form submission logic here
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
