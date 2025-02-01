import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/fetch_meal.dart';
import 'package:flutter_application_1/models/meal_model.dart';
import 'package:flutter_application_1/pages/dashboard.dart';
import 'package:flutter_application_1/pages/list_overview.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class PickMealPage extends StatefulWidget {
  const PickMealPage({super.key});

  @override
  State<PickMealPage> createState() => _PickMealPageState();
}

class _PickMealPageState extends State<PickMealPage> {
  final controller = FlipCardController();
      final currentIndex = 1;

  Meal? _meal;

  void _flipCard() {
    _fetchMeal();
  }

  void _fetchMeal() async {
    final fetchMealController = FetchMealController();
    final meal = await fetchMealController.fetchRandomMeal();
    setState(() {
      _meal = meal;
    });
    controller.flipcard();
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
        backgroundColor: Color(0xFF2E7D32),
        elevation: 2,
        title: Text(
          'Pick Meal',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Pick Meal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              _meal != null ? _meal!.strMeal : 'Loading...',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            FlipCard(
              controller: controller,
              rotateSide: RotateSide.right,
              frontWidget: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _meal != null ? NetworkImage(_meal!.strMealThumb) : AssetImage('assets/placeholder.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
                width: 300,
              ),
              backWidget: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _meal != null ? NetworkImage(_meal!.strMealThumb) : AssetImage('assets/placeholder.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
                width: 300,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _flipCard,
              child: Text(' Next'),
            ),
          ],
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
              },
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.restaurant),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => PickMealPage()));
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
