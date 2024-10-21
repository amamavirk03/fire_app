import 'dart:io';
import 'package:fire_app/apis/post_services/post_services.dart';
import 'package:fire_app/common/components/customTextField.dart';
import 'package:fire_app/common/components/cutombutton.dart';
import 'package:fire_app/features/auth/model/user_model.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PostScreen extends StatefulWidget {
  final String token; // Assuming you pass the token from the parent widget

  const PostScreen({super.key, required this.token});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final List<String> _ingredients = [];
  bool loading = false;

  UserModel userModel = UserModel();
  final TextEditingController _titleC = TextEditingController();
  final TextEditingController _desC = TextEditingController();
  final TextEditingController _portionC = TextEditingController();
  final TextEditingController _cooktimeC = TextEditingController();
  final TextEditingController _ingredientC = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Method to pick image from gallery
  Future<void> pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void addIngredient() {
    if (_ingredientC.text.isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientC.text);
        _ingredientC.clear();
      });
    }
  }

  void postRecipe() async {
    // Ensure all fields are filled
    if (_titleC.text.isEmpty ||
        _desC.text.isEmpty ||
        _portionC.text.isEmpty ||
        _cooktimeC.text.isEmpty ||
        _ingredients.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and select an image')),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    // Call postRecipe service
    bool isSuccess = await PostService().postRecipe(
      name: _titleC.text,
      cookingTime: _cooktimeC.text,
      description: _desC.text,
      ingredients: _ingredients,
      portion: _portionC.text,
      image: _image!,
    );

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe posted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to post recipe!')),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    _titleC.dispose();
    _desC.dispose();
    _portionC.dispose();
    _cooktimeC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Post Recipe", style: TextStyle(fontSize: 20.sp)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _image == null
                      ? Center(
                          child: Icon(
                            Icons.image,
                            size: 50.sp,
                            color: Colors.grey,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20.sp),
              CustomTextField(
                fieldName: "Recipe Title",
                controller: _titleC,
                inputType: TextInputType.text,
                hintText: "Enter name of your recipe",
                validator: (value) => value == null || value.isEmpty
                    ? "Title cannot be empty"
                    : null,
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                fieldName: "Description",
                controller: _desC,
                inputType: TextInputType.text,
                hintText: "Enter details",
                maxLines: 5,
                validator: (value) => value == null || value.isEmpty
                    ? "Description cannot be empty"
                    : null,
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      fieldName: "Ingredient",
                      controller: _ingredientC,
                      inputType: TextInputType.text,
                      hintText: "Enter ingredient",
                      validator: (value) => value == null || value.isEmpty
                          ? "Ingredient cannot be empty"
                          : null,
                    ),
                  ),
                  IconButton(
                    onPressed: addIngredient,
                    icon: const Icon(Icons.add, color: TColors.primary),
                  ),
                ],
              ),
              if (_ingredients.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _ingredients.map((ingredient) {
                    return Text(
                      "- $ingredient",
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    );
                  }).toList(),
                ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170.w,
                    child: CustomTextField(
                      fieldName: "Portion",
                      controller: _portionC,
                      inputType: TextInputType.number,
                      hintText: "Enter no of people",
                      validator: (value) => value == null || value.isEmpty
                          ? "Portion cannot be empty"
                          : null,
                    ),
                  ),
                  SizedBox(
                    width: 170.w,
                    child: CustomTextField(
                      fieldName: "Cooking Time",
                      controller: _cooktimeC,
                      inputType: TextInputType.text,
                      hintText: "Enter duration",
                      validator: (value) => value == null || value.isEmpty
                          ? "Cooking time cannot be empty"
                          : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              loading
                  ? const CircularProgressIndicator()
                  : CustomButton(buttonText: "Post", onPressed: postRecipe),
            ],
          ),
        ),
      ),
    );
  }
}
