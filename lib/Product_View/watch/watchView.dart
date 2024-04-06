import 'package:flutter/material.dart';

class WatchView extends StatelessWidget {
  const WatchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watches'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
          itemCount: 2, // Number of rows
          separatorBuilder: (context, index) => SizedBox(height: 16), // Add space between rows
          itemBuilder: (context, index) {
            return _buildProductRow(context);
          },
        ),
      ),
    );
  }

  Widget _buildProductRow(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width / 2 - 10.0; // Account for spacing
    return Row(
      children: [
        Expanded(
          child: ProductCard(
            imagePath: 'assets/images/watch1.jpg',
            productAbout: 'Luxury Smartwatch',
            price: '\$299',
            location: 'San Francisco, USA',
            postDate: 'Posted: April 5th, 2024',
            maxWidth: maxWidth,
          ),
        ),
        SizedBox(width: 10), // Add spacing between cards
        Expanded(
          child: ProductCard(
            imagePath: 'assets/images/watch2.jpg',
            productAbout: 'Classic Analog Watch',
            price: '\$149',
            location: 'Paris, France',
            postDate: 'Posted: April 10th, 2024',
            maxWidth: maxWidth,
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String productAbout;
  final String price;
  final String location;
  final String postDate;
  final double maxWidth;

  const ProductCard({
    required this.imagePath,
    required this.productAbout,
    required this.price,
    required this.location,
    required this.postDate,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle card tap
        print('Card tapped: $productAbout');
      },
      child: Container(
        width: maxWidth,
        height: 260,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(imagePath),
              SizedBox(height: 5),
              Text(
                productAbout,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                price,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16.0),
                  Text(location),
                ],
              ),
              Text(postDate, style: TextStyle(fontSize: 12.0)),
            ],
          ),
        ),
      ),
    );
  }
}
