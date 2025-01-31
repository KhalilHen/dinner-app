import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/fetch_meal.dart';
import 'package:flutter_application_1/models/meal_model.dart';

class PickMealPage extends StatefulWidget {
  const PickMealPage({super.key});

  @override
  State<PickMealPage> createState() => _PickMealPageState();
}

class _PickMealPageState extends State<PickMealPage> {
  Meal? _meal;

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
      appBar: AppBar(
        title: Text('Pick Meal'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Pick Meal',
              style: TextStyle(fontSize: 26),
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
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _meal != null ? NetworkImage(_meal!.strMealThumb) : AssetImage('assets/placeholder.png') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              height: 200,
              width: 300,
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _fetchMeal,
              child: Text(' Next'),
            ),
          ],
        ),
      ),
    );
  }
}
