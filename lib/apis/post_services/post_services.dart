import 'dart:convert';
import 'dart:io';
import 'package:fire_app/features/postscreen/post_helper.dart';
import 'package:http/http.dart' as http;

class PostServices {
  Future<bool> createRecipe({
    required String name,
    required String cookingTime,
    required String description,
    required int portion,
    required List<String> ingredients,
    required File image,
  }) async {
    final token = await getToken();
    try {
      print("after getting token: $token");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://recipeapp-recipeapp.up.railway.app/api/post/create'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      request.fields['name'] = name;
      request.fields['cookingTime'] = cookingTime;
      request.fields['description'] = description;
      request.fields['portion'] = portion.toString();
      request.fields['ingredients'] = jsonEncode(ingredients);

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
      ));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(responseData);
        print(response.statusCode);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error creating recipe: $e');
      return false;
    }
  }
}
