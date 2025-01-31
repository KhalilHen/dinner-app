import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/meal_model.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class fetchMealController {
//API
// Not tested yet
  Future<Meal> fetchMeal() async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php');

    if (url == null || url == '') {
      throw Exception('Invalid URL');
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<dynamic> mealsJson = data['meals'];
      List<Meal> meals = mealsJson.map((mealJson) => Meal.fromJson(mealJson)).toList();
      return meals[0];
    } else {
      throw Exception('Failed to load meal');
    }
  }
}
