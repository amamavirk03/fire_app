import 'package:fire_app/common/components/customTextField.dart';
import 'package:fire_app/common/components/cutomButton.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/postscreen/displayRecipe.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'dart:io';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final List<String> _ingredients = [];

  bool loading = false;

  // Firestore reference for the "posts" collection
  final CollectionReference firestoreRef =
      FirebaseFirestore.instance.collection('posts');

  final TextEditingController _titleC = TextEditingController();
  final TextEditingController _desC = TextEditingController();
  final TextEditingController _portionC = TextEditingController();
  final TextEditingController _cooktimeC = TextEditingController();
  final TextEditingController _ingredientC = TextEditingController();

  // Add this variable for the selected image
  File? _image;

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  void addIngredient() {
    if (_ingredientC.text.isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientC.text); // Add the ingredient to the list
        _ingredientC.clear(); // Clear the text field
      });
    }
  }

  // Method to pick image from gallery
  Future<void> pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path); // Assign the image file to _image
      });
    }
  }

  // Method to post recipe
  void postRecipe() async {
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

    // Create a unique ID for the post
    String id = firestoreRef.doc().id;

    // Upload image to Firebase Storage
    String? imageUrl;
    if (_image != null) {
      try {
        Reference storageRef = FirebaseStorage.instance.ref('images/$id');
        UploadTask uploadTask = storageRef.putFile(_image!);
        TaskSnapshot snapshot = await uploadTask;
        imageUrl = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print('Error uploading image: $e');
        setState(() {
          loading = false;
        });
        return;
      }
    }

    // Create a data map with the information and image URL
    Map<String, dynamic> recipeData = {
      'title': _titleC.text,
      'description': _desC.text,
      'portion': _portionC.text,
      'cooktime': _cooktimeC.text,
      'ingredients': _ingredients,
      'imageUrl': imageUrl, // Add the image URL
    };

    try {
      // Save the data to Firestore
      await firestoreRef.doc(id).set(recipeData);

      // Navigate to the DisplayScreen and pass the data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayScreen(
            title: _titleC.text,
            description: _desC.text,
            portion: _portionC.text,
            cooktime: _cooktimeC.text,
            ingredients: _ingredients,
            imageUrl: imageUrl, // Pass the image URL to the next screen
          ),
        ),
      );
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to save recipe. Please try again.')),
      );
    } finally {
      // Stop loading indicator regardless of success or failure
      setState(() {
        loading = false;
      });
    }
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
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        title: Text(
          "Post recipe",
          style: TTextStyles.heading,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Add the image container
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: TColors.grey,
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
                fieldName: "Recipe title",
                inputType: TextInputType.name,
                controller: _titleC,
                hintText: "Enter name of your recipe", validator: (value) {  },
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                fieldName: "Description",
                inputType: TextInputType.name,
                controller: _desC,
                hintText: "Enter details",
                maxLines: 5, validator: (value) {  },
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      fieldName: "Ingredient",
                      controller: _ingredientC,
                      hintText: "Enter ingredient",
                      inputType: TextInputType.name, validator: (value) {  },
                    ),
                  ),
                  IconButton(
                    onPressed: addIngredient,
                    icon: const Icon(Icons.add, color: TColors.primary),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // Display added ingredients
              if (_ingredients.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      "Ingredients:",
                      style: TTextStyles.heading.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _ingredients.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "- ${_ingredients[index]}",
                          style: TTextStyles.subtitle
                              .copyWith(fontSize: 14.sp, color: TColors.black),
                        );
                      },
                    ),
                  ],
                ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    fieldName: "Portion",
                    inputType: TextInputType.number,
                    controller: _portionC,
                    hintText: "Enter no of people",
                    width: 170.w, validator: (value) {  },
                  ),
                  CustomTextField(
                    fieldName: "Cooking time",
                    inputType: TextInputType.name,
                    controller: _cooktimeC,
                    hintText: "Enter duration",
                    width: 170.w, validator: (value) { 
                      
                     },
                  ),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
              loading
                  ? const CircularProgressIndicator(
                      color: TColors.primary,
                    )
                  : CustomButton(
                      buttonText: "Post",
                      onPressed: () {
                        postRecipe();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
