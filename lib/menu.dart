import 'package:flutter/material.dart';
import 'package:catering_service/fill_details.dart';
class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool isVegSelected = true;
  List<bool> isAdded = List.filled(18, false);

  final List<String> items = [
    "Idli Sambar",
    "Appam",
    "Dosa",
    "Wada",
    "Pongal",
    "Vada",
    "Malai Kofta",
    "Bhindi Masala",
    "Baingan Bharta",
    "Mix Veg Curry",
    "Tandoori Roti",
    "Butter Naan",
    "Freid Rice",
    "Dal Fry",
    "Rasgulla",
    "Ice Cream",
    "Raas Malai",
    "Falooda",
  ];

  final List<String> images = [
    "https://yummy-valley.com/wp-content/uploads/2024/01/millet-idli.webp",
    "https://www.cookshideout.com/wp-content/uploads/2018/04/Instant-Appam_FI.jpg",
    "https://vismaifood.com/storage/app/uploads/public/8b4/19e/427/thumb__1200_0_0_0_auto.jpg",
    "https://content.jdmagicbox.com/v2/comp/mumbai/k5/022pxx22.xx22.130312091438.t7k5/catalogue/mendu-wada-stall-lower-parel-mumbai-fast-food-4hw40rc.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQonLqWxFc3-G-HKlsDDhNcvXvIn_XkxYbJ_A&s",
    "https://upload.wikimedia.org/wikipedia/commons/8/8b/Mumbai-vada.jpg",
    "https://carveyourcraving.com/wp-content/uploads/2021/09/Best-Malai-Kofta-recipe.jpg",
    "https://www.anveshan.farm/cdn/shop/articles/BhindiMasala.jpg?v=1690790485",
    "https://spicecravings.com/wp-content/uploads/2023/03/Baingan-Bharta-Featured-2.jpg",
    "https://atanurrannagharrecipe.com/wp-content/uploads/2023/01/Dhaba-Style-Mix-Veg-Photo-01.jpg",
    "https://inredberry.com/wp-content/uploads/2023/10/Tandoori-Roti.png",
    "https://i.ytimg.com/vi/H3tW-UFSojU/maxresdefault.jpg",
    "https://cdn.sanity.io/images/g1s4qnmz/production/9edf7c23ab535752b4e4c597636756078930551a-2500x2500.jpg",
    "https://tikkastotapas.com/wp-content/uploads/2021/08/IMG_9208-2.jpg",
    "https://cdn.zeptonow.com/production///tr:w-600,ar-100-100,pr-true,f-auto,q-80/web/recipes/rasgulla.png",
    "https://www.allrecipes.com/thmb/SI6dn__pfJb9G5eBpYAqkyGCLxQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/50050-five-minute-ice-cream-DDMFS-4x3-076-fbf49ca6248e4dceb3f43a4f02823dd9.jpg",
    "https://i.pinimg.com/736x/cd/3f/66/cd3f6644e282b26eadc3e97a240ccc91.jpg",
    "https://rachnas-kitchen.com/wp-content/uploads/2017/07/rasmalai-2-e1505245876472-gpo.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          'South Indian Breakfast',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          Icon(Icons.edit, color: Colors.black),
          SizedBox(width: 16),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Veg/Non-Veg Toggle
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Pure Veg Option
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isVegSelected = true;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.eco, color: isVegSelected ? Colors.green : Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "Pure Veg",
                        style: TextStyle(
                          color: isVegSelected ? Colors.green : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Switch(
                        value: isVegSelected,
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.grey.shade300,
                        onChanged: (value) {
                          setState(() {
                            isVegSelected = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                // Non Veg Option
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isVegSelected = false;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.radio_button_checked,
                          color: !isVegSelected ? Colors.red : Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "Non Veg",
                        style: TextStyle(
                          color: !isVegSelected ? Colors.red : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                // Categories Sidebar
                _buildCategorySidebar(),
                // Food Items Grid
                Expanded(
                  child: _buildFoodGrid(),
                ),
              ],
            ),
          ),
          // Price and Fill Details Button
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price per plate ₹299',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the DetailsPage when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FillDetailsPage(initialPricePerPlate: 299,)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text('Fill Details'),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _vegNonVegToggle(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isVegSelected = label == "Pure Veg";
        });
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: isSelected ? Colors.green : Colors.red,
            child: Icon(Icons.check, color: Colors.white, size: 14),
          ),
          SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCategorySidebar() {
    return Container(
      width: 80,
      color: Colors.grey.shade100,
      child: Column(
        children: [
          _categoryItem("Starters", true, 2, 2),
          _categoryItem("Mains", true, 2, 2),
          _categoryItem("Desserts", true, 3, 3),
        ],
      ),
    );
  }

  Widget _categoryItem(String name, bool isCompleted, int selected, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: isCompleted ? Colors.green : Colors.grey.shade300,
            child: Icon(Icons.check, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            '$selected/$total',
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _foodItem(index);
      },
    );
  }

  Widget _foodItem(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                images[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          SizedBox(height: 0),
          Text(
            items[index],
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(height:0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isAdded[index] = !isAdded[index];
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isAdded[index] ? Colors.pink : Colors.grey.shade200,
            ),
            child: Text(
              isAdded[index] ? "Added" : "Add",
              style: TextStyle(color: isAdded[index] ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
