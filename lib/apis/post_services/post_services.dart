import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fire_app/features/postscreen/post_helper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;

class PostService {
  static const String baseUrl =
      'https://recipeapp-recipeapp.up.railway.app/api/post/create';

  Future<Uint8List> compressImage(File file) async {
    try {
      final compressedBytes = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        minWidth: 800,
        minHeight: 600,
        quality: 30,
      );
      return compressedBytes ?? await file.readAsBytes();
    } catch (e) {
      print('Error compressing image: $e');
      return await file.readAsBytes();
    }
  }

  Future<bool> postRecipe({
    required String name,
    required String cookingTime,
    required String description,
    required List<String> ingredients,
    required String portion,
    required File image,
  }) async {
    try {
      String? token = await getToken();

      print("before getting token");
      if (token == null) {
        print('Error: User token is missing');
        return false;
      }
      print("after getting token: $token");

      // Compress the image before uploading
      // Uint8List compressedImageBytes = await compressImage(image);

      String base64Image = base64Encode(image.readAsBytesSync());

      // Prepare the request body
      var body = {
        'name': name,
        'cookingTime': cookingTime,
        'description': description,
        'portion': portion,
        'ingredients': ingredients,
        'image': base64Image,
      };

      // Send POST request
      var postresponse = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Check the response status
      // print("before getting response");
      // print(postresponse.statusCode);
      if (postresponse.statusCode == 200) {
        print(postresponse.body);
        print("after getting response");
        print("Recipe posted successfully.");
        return true;
      } else {
        print('Error posting recipe: ${postresponse.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error posting recipe: $e.getMessage()');
      return false;
    }
  }
}
