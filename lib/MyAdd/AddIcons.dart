import 'package:flutter/material.dart';
import 'package:skl/MyAdd/cars/cars.dart';
import 'package:skl/RealState/RealSateType.dart';

class MyAdd extends StatelessWidget {
  const MyAdd({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell on SKL',
        style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Highlight What You're Selling
            const Text(
              'What are you selling?',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0), // Spacing

            // Choose Category and Continue
           const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose your Category',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                
              ],
            ),
            const SizedBox(height: 16.0), // Spacing

            // Grid of Category Icons (Replace with actual icons)
            Wrap(
              spacing: 26, // Spacing between icons
              runSpacing: 16.0, // Spacing between rows
              children: [
                _buildCategoryIcon(Icons.phone_android, 'Phones', Colors.blue, () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RealEstateType()),
                );
                  // Navigate to phones page
                }),
                _buildCategoryIcon(Icons.laptop, 'Electronics', Colors.green, () {
                  // Navigate to electronics page
                }),
                _buildCategoryIcon(Icons.sports_bar, 'Sports', Colors.orange, () {
                  // Navigate to sports page
                }),
                _buildCategoryIcon(Icons.home, 'Furniture', Colors.red, () {
                  // Navigate to furniture page
                }),
                _buildCategoryIcon(Icons.home, 'Real Estates', Colors.deepOrange, () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RealEstateType()),
                );
                }),
                _buildCategoryIcon(Icons.card_membership, 'Cars', Colors.yellowAccent, () {
                  
                  // Navigate to fashion page
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>CarSaleScreen()),);
                }),
                _buildCategoryIcon(Icons.shopping_cart, 'Fashion', Colors.teal, () {
                  // Navigate to fashion page
                }),
                _buildCategoryIcon(Icons.shopping_cart, 'Fashion', Colors.pinkAccent, () {
                  // Navigate to fashion page
                }),
                _buildCategoryIcon(Icons.shopping_cart, 'Fashion', Colors.lime, () {
                  // Navigate to fashion page
                }),
                _buildCategoryIcon(Icons.shopping_cart, 'Fashion', Colors.lightGreenAccent, () {
                  // Navigate to fashion page
                }),
                _buildCategoryIcon(Icons.more_horiz, 'More', Colors.grey, () {
                  // Navigate to more page
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 60.0, color: color), // Increased size to 60.0
          Text(label),
        ],
      ),
    );
  }
}
