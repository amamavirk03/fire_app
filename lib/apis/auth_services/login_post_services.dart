import 'package:fire_app/features/auth/model/user_model.dart';
import 'package:fire_app/features/postscreen/post_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginServices {
  Future<UserModel?> login(String email, String password) async {
    try {
      print("Starting Api");
      var response = await http.post(
        Uri.parse('https://recipeapp-recipeapp.up.railway.app/api/user/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      print("before getting response");
      if (response.statusCode == 200) {
        print("before getting token");
        Map<String, dynamic> responseData = jsonDecode(response.body);

        String? token = responseData['token'];
        if (token != null) {
          await storeToken(token);
          print("token: $token");
          print("after getting token");
          print("Response Data: $responseData");
          return UserModel(token: token);
        } else {
          print("Token is null in the response");
        }
      } else {
        print("Status Code: ${response.statusCode.toString()}");
      }
    } catch (e) {
      print("Network Error");
      print(e.toString());
    }
    return null;
  }
}
