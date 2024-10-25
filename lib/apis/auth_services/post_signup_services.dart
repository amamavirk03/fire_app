import 'dart:convert';
import 'package:fire_app/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupServices {
  Future<dynamic>? signup(String name, String email, String password,
      String confirmPassword) async {
    try {
      print("Starting Api");
      var response = await http.post(
        Uri.parse('https://recipeapp-recipeapp.up.railway.app/api/user/signup'),
        body: {
          'name': name,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );
      if (response.statusCode == 200) {
        print("getting response");
        UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
        print("${userModel.success} ${userModel.message}");
        Get.defaultDialog(
          title: "Success",
          content: const Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 10),
              Text("User created successfully"),
            ],
          ),
        );
        Get.back();
        return userModel;
      } else {
        print("Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Network Error: ${e.toString()}");
    }
    return null;
  }
}
