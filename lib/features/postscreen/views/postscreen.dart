import 'dart:io';

import 'package:fire_app/apis/post_services/post_services.dart';
import 'package:fire_app/common/components/customTextField.dart';
import 'package:fire_app/common/components/cutombutton.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PostScreen extends StatefulWidget {
  // final String token; // Assuming you pass the token from the parent widget

  const PostScreen({
    super.key,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();
  final TextEditingController portionController = TextEditingController();
  final TextEditingController ingredientController = TextEditingController();
  final List<String> ingredients = [];
  final postServices = PostServices();
  File? _image;
  final _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void postRecipe() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await postServices.createRecipe(
        name: titleController.text,
        cookingTime: cookingTimeController.text,
        description: descriptionController.text,
        portion: int.parse(portionController.text),
        ingredients: ingredients,
        image: _image!,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe posted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error posting recipe: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    cookingTimeController.dispose();
    portionController.dispose();
    ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Post Recipe", style: TextStyle(fontSize: 0.02.sh)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0.05.sw),
          child: Column(
            children: [
              if (_image != null)
                Container(
                  height: 0.25.sh,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: FileImage(_image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  height: 0.25.sh,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add_photo_alternate, size: 0.05.sh),
                    onPressed: _pickImage,
                  ),
                ),
              SizedBox(height: 0.02.sh),
              CustomTextField(
                fieldName: "Recipe Title",
                controller: titleController,
                inputType: TextInputType.text,
                hintText: "Enter name of your recipe",
                validator: (value) => value == null || value.isEmpty
                    ? "Title cannot be empty"
                    : null,
              ),
              SizedBox(height: 0.02.sh),
              CustomTextField(
                fieldName: "Description",
                controller: descriptionController,
                inputType: TextInputType.text,
                hintText: "Enter details",
                maxLines: 5,
                validator: (value) => value == null || value.isEmpty
                    ? "Description cannot be empty"
                    : null,
              ),
              SizedBox(height: 0.02.sh),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: ingredientController,
                      fieldName: "Ingredients",
                      inputType: TextInputType.text,
                      hintText: "Enter ingredients",
                      validator: (value) => value == null || value.isEmpty
                          ? "Ingredients cannot be empty"
                          : null,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (ingredientController.text.isNotEmpty) {
                        setState(() {
                          ingredients.add(ingredientController.text);
                          ingredientController.clear();
                        });
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: TColors.primary,
                      size: 0.03.sh,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.02.sh),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(ingredients[index], style: TextStyle(fontSize: 0.016.sh)),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: TColors.primary,
                        size: 0.03.sh,
                      ),
                      onPressed: () {
                        setState(() {
                          ingredients.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 0.02.sh),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 0.4.sw,
                    child: CustomTextField(
                      fieldName: "Portion",
                      controller: portionController,
                      inputType: TextInputType.number,
                      hintText: "Enter no of people",
                      validator: (value) => value == null || value.isEmpty
                          ? "Portion cannot be empty"
                          : null,
                    ),
                  ),
                  SizedBox(
                    width: 0.4.sw,
                    child: CustomTextField(
                      fieldName: "Cooking Time",
                      controller: cookingTimeController,
                      inputType: TextInputType.text,
                      hintText: "Enter duration",
                      validator: (value) => value == null || value.isEmpty
                          ? "Cooking time cannot be empty"
                          : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.02.sh),
              _isLoading
                  ? SizedBox(
                      height: 0.05.sh,
                      width: 0.05.sh,
                      child: const CircularProgressIndicator())
                  : CustomButton(buttonText: "Post", onPressed: postRecipe),
            ],
          ),
        ),
      ),
    );
  }
}