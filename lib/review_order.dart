import 'dart:math';
import 'package:catering_service/fill_details.dart';
import 'package:flutter/material.dart';
import 'package:catering_service/menu.dart';
import 'package:catering_service/main.dart';

class ReviewOrderPage extends StatelessWidget {
  final String? occasion;
  final DateTime date;
  final TimeOfDay time;
  final int guestCount;
  final double totalPrice;

  ReviewOrderPage({
    required this.occasion,
    required this.date,
    required this.time,
    required this.guestCount,
    required this.totalPrice,
  });

  // Function to calculate discounted price
  double calculateDiscount(double price, double discountPercentage) {
    return price - (price * (discountPercentage / 100));
  }

  // Function to generate a random hotel name
  String getRandomHotelName() {
    final List<String> hotelNames = [
      "Millet BreakFast",
      "Indian Soiree",
      "South Indian",
    ];
    return hotelNames[Random().nextInt(hotelNames.length)];
  }

  @override
  Widget build(BuildContext context) {
    final double discountPercentage = 7.0;
    final double discountedPrice = calculateDiscount(totalPrice, discountPercentage);
    final double priceDifference = totalPrice - discountedPrice; // Calculate the price difference
    final String randomHotelName = getRandomHotelName(); // Get a random hotel name

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('Order Review'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // Hotel Name and Details Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hotel Name
                    Row(
                      children: [
                        Icon(Icons.square_rounded, color: Colors.purple, size: 24),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Hotel: $randomHotelName',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // Horizontal Line
                    Divider(thickness: 1, color: Colors.grey[300]),
                    SizedBox(height: 12),
                    // Occasion, Date & Time, and Guest Count
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Guest Count
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.person, color: Colors.purple, size: 20),
                              SizedBox(width: 3),
                              Text(
                                '$guestCount',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        // Date
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.purple, size: 20),
                              SizedBox(width: 1),
                              Text(
                                '${date.day}/${date.month}/${date.year}',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        // Time
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.access_time_filled, color: Colors.purple, size: 20),
                              SizedBox(width: 3),
                              Text(
                                '${time.format(context)}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Edit Button (Positioned at the top-right corner of the card)
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FillDetailsPage(initialPricePerPlate: 299,)),
                          );
                          // Handle edit functionality
                        },
                        icon: Icon(Icons.edit, color: Colors.purple),
                        tooltip: 'Edit Details',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Total Price and Discount
            Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Savings Statement
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                    child: Text(
                      'Hurray! You saved ₹${priceDifference.toStringAsFixed(2)} on the total order.',
                      style: TextStyle(
                        fontSize: 13.65,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Original Price: ₹$totalPrice',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Discounted Price (7% Off): ₹${discountedPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Incl. Taxes & Charges',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'To Pay: ₹${discountedPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the payment page or show a confirmation dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Order Placed'),
                    content: Text('Your order has been placed successfully!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Place Order',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
