import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/list_overview.dart';
import 'package:flutter_application_1/pages/pick_meal.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'Dinner App',
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Colors.orange,
        backgroundColor: Color(0xFF2E7D32),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Today's Suggestion",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  'data:image/jpeg;base64,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',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Meal title",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Meal description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[800]),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.restaurant),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PickMealPage()));
              },
            ),
            label: 'Choose-meal',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListOverview()));
              },
            ),
            label: 'List',
          ),
        ],
      ),
    );
  }
}
