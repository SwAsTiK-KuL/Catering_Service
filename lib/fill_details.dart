import 'package:flutter/material.dart';
import 'package:catering_service/review_order.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.purple,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
      ),
    ),
    home: FillDetailsPage(initialPricePerPlate: 299),
  ));
}

class CustomThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(30, 30); // Size of the thumb
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    // Draw the person icon as the thumb
    const icon = Icons.person;
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 24,
          fontFamily: icon.fontFamily,
          color: Colors.purple, // Icon color
        ),
      ),
      textDirection: textDirection,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }
}

TimeOfDay _calculateEndTime(TimeOfDay startTime) {
  int endHour = startTime.hour + 2; // Add 2 hours to the start time
  int endMinute = startTime.minute;

  // Handle hour overflow (e.g., 23 + 2 -> 1 AM next day)
  if (endHour >= 24) {
    endHour = endHour % 24;
  }

  return TimeOfDay(hour: endHour, minute: endMinute);
}

class FillDetailsPage extends StatefulWidget {
  final double initialPricePerPlate;

  FillDetailsPage({required this.initialPricePerPlate});

  @override
  _FillDetailsPageState createState() => _FillDetailsPageState();
}

class _FillDetailsPageState extends State<FillDetailsPage> {
  String? selectedOccasion = "Birthday";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 14, minute: 0);
  int guestCount = 120; // Default guest count
  late double pricePerPlate;

  @override
  void initState() {
    super.initState();
    pricePerPlate = widget.initialPricePerPlate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('Fill Details'),
      ),
      body: Column(
        children: [
          // Scrollable content wrapped in Expanded
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // South Indian Breakfast Card
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text displaying the item name
                          Row(
                            children: [
                              Text(
                                'South Indian Breakfast',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              // Padding for some space between the text and the icon
                              SizedBox(width: 8),
                              // Pencil icon for editing
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.purple),
                                onPressed: () {
                                  // Action for editing South Indian Breakfast details
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Occasion, Date, and Time Card
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Occasion', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                DropdownButton<String>(
                                  value: selectedOccasion,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedOccasion = newValue;
                                    });
                                  },
                                  items: ['Wedding', 'Birthday', 'Reception', 'Home Party', 'Gift']
                                      .map((String occasion) {
                                    return DropdownMenuItem<String>(
                                      value: occasion,
                                      child: Text(occasion),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, color: Colors.purple),
                                    SizedBox(width: 8),
                                    Text('Date and Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.purple),
                                  onPressed: () async {
                                    final pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
                                    );
                                    final pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: selectedTime,
                                    );

                                    if (pickedDate != null && pickedTime != null) {
                                      setState(() {
                                        selectedDate = pickedDate;
                                        selectedTime = pickedTime;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                // Date Box
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 16),

                                // Time Range Box
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${selectedTime.format(context)} - ${_calculateEndTime(selectedTime).format(context)}',
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Price per Plate and Guest Count
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price Per Plate:', style: TextStyle(fontSize: 16)),
                            Row(
                              children: [
                                Text(
                                  '20% ↓ ₹$pricePerPlate',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                                ),
                                Spacer(),
                                Text('₹349', style: TextStyle(decoration: TextDecoration.lineThrough)),
                              ],
                            ),
                            SizedBox(height: 16),
                            // Total Guests section inside the same row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align elements
                              children: [
                                Text('Total Guests:', style: TextStyle(fontSize: 16)),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.purple),
                                      onPressed: () {
                                        setState(() {
                                          if (guestCount > 10) guestCount--;
                                        });
                                      },
                                    ),
                                    Text('$guestCount', style: TextStyle(fontSize: 18)),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.purple),
                                      onPressed: () {
                                        setState(() {
                                          if (guestCount < 1500) guestCount++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbShape: CustomThumbShape(), // Custom thumb shape
                                activeTrackColor: Colors.purple,
                                inactiveTrackColor: Colors.grey[300],
                              ),
                              child: Slider(
                                value: guestCount.toDouble(),
                                min: 10,
                                max: 1500,
                                divisions: 1490,
                                onChanged: (value) {
                                  setState(() {
                                    guestCount = value.toInt();
                                  });
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.orange, size: 20),
                                SizedBox(width: 8),
                                Text('DYNAMIC PRICING: more guests, more savings.', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Order Review Button at the bottom
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                double totalPrice = pricePerPlate * guestCount; // Calculate the total price
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewOrderPage(
                      occasion: selectedOccasion,
                      date: selectedDate,
                      time: selectedTime,
                      guestCount: guestCount,
                      totalPrice: totalPrice, // Pass the total price here
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Order Review',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
