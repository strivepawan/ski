import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skl/BottomNavigation/ChatPage.dart';
import 'package:skl/BottomNavigation/Sell.dart';
import 'package:skl/MyAdd/AddIcons.dart';
import 'package:skl/ProductDescription.dart';
import 'package:skl/Product_View/Books/booksView.dart';
import 'package:skl/Product_View/Car/carView.dart';
import 'package:skl/Product_View/Furniture/furniture.dart';
import 'package:skl/Product_View/Laptop/laptopView.dart';
import 'package:skl/Product_View/Phone/phoneView.dart';
import 'package:skl/Product_View/Sports/sportsView.dart';
import 'package:skl/Product_View/pets/petsView.dart';
import 'package:skl/Product_View/watch/watchView.dart';
import 'package:skl/homeScreen/customDrawer.dart';

class HomePage extends StatefulWidget {
  final int adCount; // Fetch ad count from backend

  HomePage({required this.adCount});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _currentIndex = 0; // Currently selected navigation item index
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: (user != null)
          ? AppBar(
              title: Text(
                'S K i',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              actions: [
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () => Scaffold.of(context).openEndDrawer(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user?.photoURL ??
                            'https://picsum.photos/200'),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
      endDrawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What are you Looking For?',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text('15K Ads in your area'),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to all products screen
                      },
                      child: Text(
                        'All Products',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   _buildCircularButton(
                    icon: Icons.car_crash_sharp,
                    text: 'Car',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CarView()),
                    ),
                  ),
                    _buildCircularButton(
                    icon: Icons.home_repair_service,
                    text: 'Furniture',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FurnitureView()),
                    ),
                  ),
                    _buildCircularButton(
                    icon: Icons.mobile_screen_share_rounded,
                    text: 'Phone',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PhoneView()),
                    ),
                  ),
                   _buildCircularButton(
                    icon: Icons.sports,
                    text: 'Sports',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SportsView()),
                    ),
                  ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircularButton(
                    icon: Icons.laptop,
                    text: 'Laptop',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>const LaptopView()),
                    ),
                  ),
                    _buildCircularButton(
                        icon: Icons.watch, text: 'Watch', onPressed: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WatchView()),
                          );
                        }),
                    _buildCircularButton(
                        icon: Icons.pets, text: 'Pets', onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PetsView()));
                        }),
                    _buildCircularButton(
                        icon: Icons.book,
                        text: 'Books',
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> BooksView()));
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Latest in Your Area',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildProductCard(
                imagePath: 'assets/images/doctor.jpg',
                productabout: 'Product Description',
                price: '\$200',
                location: 'New York, USA',
                postDate: 'Posted: 15th March 2024',
              ),
              SizedBox(height: 10),
              _buildProductCard(
                imagePath: 'assets/images/doctor.jpg',
                productabout: 'Product Description',
                price: '\$200',
                location: 'New York, USA',
                postDate: 'Posted: 15th March 2024',
              ),
              SizedBox(height: 10),
              _buildProductCard(
                imagePath: 'assets/images/doctor.jpg',
                productabout: 'Product Description',
                price: '\$200',
                location: 'New York, USA',
                postDate: 'Posted: 15th March 2024',
              ),
              SizedBox(height: 10),
              _buildProductCard(
                imagePath: 'assets/images/doctor.jpg',
                productabout: 'Product Description',
                price: '\$200',
                location: 'New York, USA',
                postDate: 'Posted: 15th March 2024',
              ),
              SizedBox(height: 10),
              _buildProductCard(
                imagePath: 'assets/images/doctor.jpg',
                productabout: 'Product Description',
                price: '\$200',
                location: 'New York, USA',
                postDate: 'Posted: 15th March 2024',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            // Navigate to ChatPage when the first item is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(adCount: 50)),
            );
          } else if (index == 1) {
            // Navigate to myAdd when the second item is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage()),
            );
          } else if (index == 2) {
            // Navigate to myAdd when the third item is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAdd()),
            );
          } else if (index == 3) {
            // Navigate to myAdd when the fourth item is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Sell()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'My Ads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.blue,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            text,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String imagePath,
    required String price,
    required String location,
    required String postDate,
    required String productabout,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to the product details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              productAbout: productabout,
              price: price,
              location: location,
              postDate: postDate,
              imagePaths: [
                'assets/images/doctor.jpg',
                'assets/images/doctor.jpg',
                'assets/images/doctor.jpg',
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Text(productabout, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(price, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(location, style: TextStyle(fontSize: 16)),
                Text(postDate, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class ProductDetailsScreen extends StatelessWidget {
//   final String productAbout;
//   final String price;
//   final String location;
//   final String postDate;
//   final List<String> imagePaths;

//   ProductDetailsScreen({
//     required this.productAbout,
//     required this.price,
//     required this.location,
//     required this.postDate,
//     required this.imagePaths,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Product About: $productAbout',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text('Price: $price'),
//               SizedBox(height: 10),
//               Text('Location: $location'),
//               SizedBox(height: 10),
//               Text('Post Date: $postDate'),
//               SizedBox(height: 20),
//               Text(
//                 'Images:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               GridView.builder(
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 10.0,
//                   mainAxisSpacing: 10.0,
//                 ),
//                 itemCount: imagePaths.length,
//                 itemBuilder: (context, index) {
//                   return Image.asset(imagePaths[index]);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
