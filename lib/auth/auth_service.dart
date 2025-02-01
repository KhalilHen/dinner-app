import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getLoggedInUser() async {
    final session = supabase.auth.currentSession;
    final User = session?.user.id;

    if (User == null) {
      print('No authenticated user found.');
      return null;
    }

    print("User value $User");

    return User;
  }

  Future<AuthResponse?> signUpWithEmaiPassword(
    String email,
    String password,
  ) async {
    try {
      print("Signing up with email: $email, password: $password, ");

      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final userId = response.user!.id;

        // Use .insert() method and handle potential errors
        final insertResponse = await supabase.from('person').insert({
          'id': userId,
          'email': email,
        });

        print("User created successfully");
        return response;
      }

      return null;
    } on PostgrestException catch (e) {
      print("Postgres Error during sign up: ${e.message}");
      return null;
    } catch (e) {
      print("Error during sign up: $e");
      return null;
    }
  }
}
