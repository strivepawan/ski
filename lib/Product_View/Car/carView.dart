import 'package:flutter/material.dart';

class CarView extends StatelessWidget {
  const CarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
          itemCount: 10, // Number of rows
          separatorBuilder: (context, index) => SizedBox(height: 16), // Add space between rows
          itemBuilder: (context, index) {
            return _buildProductRow(context);
          },
        ),
      ),
    );
  }

  Widget _buildProductRow(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width / 2 - 12.0; // Account for spacing
    return Row(
      children: [
        Expanded(
          child: ProductCard(
            imagePath: 'assets/images/car2.jpeg',
            productAbout: '2020 Honda Accord',
            price: '\$15,000',
            location: 'New York, USA',
            postDate: 'Posted: April 2nd, 2024',
            maxWidth: maxWidth,
          ),
        ),
        SizedBox(width: 10), // Add spacing between cards
        Expanded(
          child: ProductCard(
            imagePath: 'assets/images/car2.jpeg',
            productAbout: '2018 Toyota Camry',
            price: '\$12,000',
            location: 'Los Angeles, CA',
            postDate: 'Posted: March 25th, 2024',
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
        height: 220, // Increased height to accommodate content below image
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.asset(
                imagePath,
                width: maxWidth,
                fit: BoxFit.cover, // Ensure the image fills the container without distortion
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productAbout,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    price,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16.0),
                      Text(location),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    postDate,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class ProductCard extends StatelessWidget {
//   final String imagePath;
//   final String productAbout;
//   final String price;
//   final String location;
//   final String postDate;
//   final double maxWidth;

//   const ProductCard({
//     required this.imagePath,
//     required this.productAbout,
//     required this.price,
//     required this.location,
//     required this.postDate,
//     required this.maxWidth,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Handle card tap
//         print('Card tapped: $productAbout');
//       },
//       child: Container(
//         width: maxWidth,
//         height: 220,
//         margin: EdgeInsets.symmetric(horizontal: 5.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1.0,
//               blurRadius: 2.0,
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Image.asset(imagePath),
//               SizedBox(height: 5),
//               Text(
//                 productAbout,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Text(
//                 price,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.location_on, size: 16.0),
//                   Text(location),
//                 ],
//               ),
//               Text(postDate, style: TextStyle(fontSize: 12.0)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
