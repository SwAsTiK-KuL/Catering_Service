import 'package:flutter/material.dart';
import 'package:catering_service/menu.dart';

void main() {
  runApp(CateringApp());
}

class CateringApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Wedding'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedCategory = 0; // Track the selected category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200), // Increased height for AppBar
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false, // Hide back button
          flexibleSpace: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  'https://cdn.sanity.io/images/ocl5w36p/prod2/920942a6b84ec3af7236307326fa4b9d6f181b15-952x660.jpg?w=480&fm=webp&dpr=2',
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white, // White text to contrast with the image
                    fontSize: 28, // Adjust font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: WeddingPage(
        selectedCategory: _selectedCategory,
        onCategorySelected: (int index) {
          setState(() {
            _selectedCategory = index;
          });
        },
      ), // Pass the selectedCategory and callback to WeddingPage
    );
  }
}

class WeddingPage extends StatelessWidget {
  final int selectedCategory;
  final ValueChanged<int> onCategorySelected;

  const WeddingPage({
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Bulk Food Delivery',
                    style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Catering Service',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Food Categories Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryTab('ALL (8)', selectedCategory == 0, 0),
                _buildCategoryTab('Breakfast', selectedCategory == 1, 1),
                _buildCategoryTab('Lunch & Dinner', selectedCategory == 2, 2),
                _buildCategoryTab('Snacks', selectedCategory == 3, 3),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Food Cards based on selected category
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                if (selectedCategory == 0) ...[
                  _buildFoodCard(
                    context: context,
                    title: 'Indian Soiree',
                    subtitle: '10 Categories & 15 Items',
                    price: '₹299/guest',
                    guests: 'Min 15 - Max 150',
                    images: [
                      'https://www.blueosa.com/wp-content/uploads/2020/07/Matar-Paneer-Peas-and-Cooked-Cottage-Cheese.jpg',
                    ],
                    bestFor: 'Weddings',
                  ),

                  SizedBox(height: 16),
                  _buildFoodCard(
                    context: context,
                    title: 'Grand Feast',
                    subtitle: '10 Categories & 15 Items',
                    price: '₹299/guest',
                    guests: 'Min 15 - Max 150',
                    images: [
                      'https://hogr.app/blog/wp-content/uploads/2024/09/image-24.png',
                    ],
                    bestFor: 'Weddings',
                  ),

                  SizedBox(height: 16),
                  _buildFoodCard(
                    context: context,
                    title: 'South Indian',
                    subtitle: '10 Categories & 15 Items',
                    price: '₹299/guest',
                    guests: 'Min 25 - Max 150',
                    images: [
                      'https://img.traveltriangle.com/blog/wp-content/uploads/2022/01/Famous-Food-Of-South-India.jpg',
                    ],
                    bestFor: 'Weddings',
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String text, bool isSelected, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () => onCategorySelected(index), // Trigger category change
        child: Chip(
          backgroundColor: isSelected ? Colors.purple : Colors.grey[200],
          label: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFoodCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String price,
    required String guests,
    required List<String> images, // Accept a list of images
    required String bestFor,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuPage(),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                images.isNotEmpty ? images[0] : '',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        guests,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
