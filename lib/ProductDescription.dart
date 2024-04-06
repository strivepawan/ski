import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productAbout;
  final String price;
  final String location;
  final String postDate;
  final List<String> imagePaths; // List to store multiple image paths

  ProductDetailsScreen({
    required this.productAbout,
    required this.price,
    required this.location,
    required this.postDate,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0), // Add some space before content

            // Image carousel using a PageView
            Container(
              height: 200.0, // Set a fixed height for the carousel
              child: PageView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0), // Add margin between images
                  child: Image.asset(
                    imagePaths[index], // Use imagePaths for multiple images
                    fit: BoxFit.cover, // Ensure images fill the container
                  ),
                );
              },
              itemCount: imagePaths.length, // Display all images
              controller: PageController(viewportFraction: 0.8), // Adjust viewport size
            ),

            ),

            SizedBox(height: 16.0), // Add space after carousel

            Text(
              productAbout,
              style: TextStyle(fontSize: 18.0),
            ),

            SizedBox(height: 16.0),

            Text(
              'Price: \$' + price,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8.0),

            Text(
              'Location: $location',
              style: TextStyle(fontSize: 16.0),
            ),

            SizedBox(height: 8.0),

            Text(
              'Post Date: $postDate',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),

            SizedBox(height: 16.0),

            ElevatedButton.icon(
              onPressed: () {
                // Implement functionality to open WhatsApp for negotiation
                // (You'll need a package like url_launcher)
              },
              icon: Icon(Icons.call),
              label: Text('Negotiate with Seller'),
            ),
          ],
        ),
      ),
    );
  }
}
