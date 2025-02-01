import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/list_overview.dart';
import 'package:flutter_application_1/pages/pick_meal.dart';
import 'package:flutter_application_1/controllers/fetch_meal.dart';
import 'package:flutter_application_1/models/meal_model.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Meal? _meal;
  final currentIndex = 0;

  void _fetchMeal() async {
    final fetchMealController = FetchMealController();
    final meal = await fetchMealController.fetchRandomMeal();
    setState(() {
      _meal = meal;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchMeal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'Dinner App',
          style: TextStyle(color: Colors.white),
        ),
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
                child: _meal != null
                    ? Image.network(
                        _meal!.strMealThumb,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      )
                    : CircularProgressIndicator(),
              ),
              SizedBox(height: 16),
              Text(
                _meal != null ? _meal!.strMeal : 'Not found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 8),
              Text(
                _meal != null ? _meal!.strInstructions : 'Not found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[800]),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF2E7D32),
        currentIndex: currentIndex,
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
