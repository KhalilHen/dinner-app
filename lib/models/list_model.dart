import 'package:flutter/material.dart';

class Lists {
  final int id;
  final String title;
  final String userId;

  Lists({
    required this.id,
    required this.title,
    required this.userId,
  });

  factory Lists.fromJson(Map<String, dynamic> data) {
    return Lists(
      id: data['id'],
      title: data['title'],
      userId: data['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'user_id': userId,
    };
  }
}
