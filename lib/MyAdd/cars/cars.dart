import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CarSaleScreen extends StatefulWidget {
  @override
  _CarSaleScreenState createState() => _CarSaleScreenState();
}

class _CarSaleScreenState extends State<CarSaleScreen> {
  String? selectedBrand;
  int? selectedYear;
  String? selectedFuelType;
  int? drivenKm;
  int? numOwners;
  String? title;
  double? price;
  bool autofacted = false;
  bool fetchLocation = false;
  String? location;
  File? selectedImage;

  // Sample lists for selection purposes
  final List<String> carBrands = ['Maruti Suzuki', 'Hyundai', 'Tata Motors'];
  final List<String> fuelTypes = ['Petrol', 'Diesel', 'CNG', 'Electric'];

  // Helper function to validate user input
  bool validateInput() {
    return selectedBrand != null &&
        selectedYear != null &&
        selectedFuelType != null &&
        drivenKm != null &&
        numOwners != null &&
        title != null &&
        price != null &&
        selectedImage != null;
  }

  // Helper function to reset form fields
  void resetForm() {
    setState(() {
      selectedBrand = null;
      selectedYear = null;
      selectedFuelType = null;
      drivenKm = null;
      numOwners = null;
      title = null;
      price = null;
      autofacted = false;
      fetchLocation = false;
      location = null;
      selectedImage = null;
    });
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    setState(() {
      location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          selectedImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image'),
        ),
      );
    }
  }

  Future<void> uploadImageAndPostData() async {
    // Upload image to Firebase Storage
    String? imageUrl;
    try {
      if (selectedImage != null) {
        final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('car_images/${DateTime.now().millisecondsSinceEpoch}');
        await storageRef.putFile(selectedImage!);
        imageUrl = await storageRef.getDownloadURL();
      }
    } catch (error) {
      // Handle image upload error
      print('Error uploading image: $error');
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload image'),
        ),
      );
      return;
    }

    // Add car details to Firestore
    try {
      await FirebaseFirestore.instance.collection('cars').add({
        'brand': selectedBrand,
        'year': selectedYear,
        'fuelType': selectedFuelType,
        'drivenKm': drivenKm,
        'numOwners': numOwners,
        'title': title,
        'location': location,
        'autofacted': autofacted,
        'price': price,
        'imageUrl': imageUrl,
      });
      // Data added successfully
      print("Car details submitted to Firestore!");
    } catch (error) {
      // Handle Firestore error
      print("Failed to submit car details: $error");
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit car details'),
        ),
      );
      return;
    }

    // Reset form fields
    resetForm();

    // Show success message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Car details submitted successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Your Car'),
        // Add search bar if desired
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            // Brand Selection
            DropdownButtonFormField<String>
            (
              value: selectedBrand,
              hint: Text('Select Brand'),
              items: carBrands.map((brand) => DropdownMenuItem(
                value: brand,
                child: Text(brand),
              )).toList(),
              onChanged: (value) => setState(() => selectedBrand = value),
            ),

            // Year Selection (manual input)
            TextField(
              decoration: InputDecoration(labelText: 'Year'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() => selectedYear = int.tryParse(value)),
            ),

            // Fuel Selection
            DropdownButtonFormField<String>(
              value: selectedFuelType,
              hint: Text('Select Fuel Type'),
              items: fuelTypes.map((fuelType) => DropdownMenuItem(
                value: fuelType,
                child: Text(fuelType),
              )).toList(),
              onChanged: (value) => setState(() => selectedFuelType = value),
            ),

            // KM Driven
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'KM Driven'),
              onChanged: (value) => setState(() => drivenKm = int.tryParse(value)),
            ),

            // Number of Owners
            Row(
              children: [
                Text('Number of Owners:'),
                SizedBox(width: 10.0),
                DropdownButton<int>(
                  value: numOwners,
                  items: [1, 2, 3].map((owners) => DropdownMenuItem(
                    value: owners,
                    child: Text('$owners'),
                  )).toList(),
                  onChanged: (value) => setState(() => numOwners = value),
                ),
              ],
            ),

            // Title
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (value) => setState(() => title = value),
            ),

            // Location (toggle to enable/disable)
            Row(
              children: [
                Text('Fetch Current Location:'),
                Switch(
                  value: fetchLocation,
                  onChanged: (value) => setState(() {
                    fetchLocation = value;
                    if (!value) location = null; // Clear location if fetchLocation is false
                  }),
                ),
                IconButton(
                  icon: Icon(Icons.location_on_outlined),
                  onPressed: fetchLocation ? null : getCurrentLocation, // Disable if already fetching
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              enabled: fetchLocation,
              onChanged: (value) => setState(() => location = value),
            ),

                        // Autofacted
            Row(
              children: [
                Text('Autofacted:'),
                Checkbox(
                  value: autofacted,
                  onChanged: (value) => setState(() => autofacted = value!),
                ),
              ],
            ),

            // Price
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
              onChanged: (value) => setState(() => price = double.tryParse(value)),
            ),
            // ElevatedButton(
            //   onPressed: _pickImage,
            //   child: Text('Pick Image'),
            // ),
            if (selectedImage != null) // Display selected image
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 200,
                width: double.infinity,
                child: Image.file(
                  selectedImage!,
                  fit: BoxFit.cover,
                ),
              ),

            // Post Now Button
            ElevatedButton(
              onPressed: () {
                // Validate and process user input
                if (!validateInput()) {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill out all required fields'),
                    ),
                  );
                  return;
                }
                uploadImageAndPostData();

                // Reset fields after submission
                resetForm();
              },
              child: Text('Post Your Car'),
            ),
          ],
        ),
      ),
    );
  }
}
