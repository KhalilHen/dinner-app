import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/list_model.dart';

class ListController {
  final authService = AuthService();
  void createList(String listName) async {
    final userResponse = await authService.getLoggedInUser();
    if (userResponse == null) {
      return;
    }

    final response = await supabase.from('list').insert([
      {
        'listName': listName,
        'user_id': userResponse,
      }
    ]);
  }

  Future<List<Lists>> fetchUserList() async {
    final userResponse = await authService.getLoggedInUser();
    if (userResponse == null) {
      return [];
    }

    final response = await supabase.from('list').select().eq('user_id', userResponse);
    if (response == null) {
      return [];
    }

    List<dynamic> data = response as List<dynamic>;
    return data.map((listJson) => Lists.fromJson(listJson as Map<String, dynamic>)).toList();
  }
}
