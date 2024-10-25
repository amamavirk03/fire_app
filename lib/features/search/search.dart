import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/reciepepage.dart/reciepepage.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Recipe> filteredRecipes = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipes;
  }

  void searchRecipes(String query) {
    setState(() {
      filteredRecipes = recipes.where((recipe) {
        return recipe.name.toLowerCase().contains(query.toLowerCase()) ||
            recipe.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        title: const Center(child: Text("Search Page")),
      ),
      body: Padding(

        padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.02.sh),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: searchRecipes,

                decoration: InputDecoration(
                  hintText: 'Search recipes...',

                  prefixIcon: Icon(Icons.search, size: 24.sp),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 0.02.sh),
              customTextRow(firstText: 'Search History', secondText: 'See all'),

              SizedBox(height: 0.02.sh),
              SizedBox(

                height: 0.6.sh,
                child: ListView.builder(
                  itemCount: filteredRecipes.length,
                  itemBuilder: (context, index) {
                    return Padding(

                      padding: EdgeInsets.only(bottom: 0.02.sh),
                      child: recipeCard(context, filteredRecipes[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextRow({
    required String firstText,
    required String secondText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstText,

          style: TTextStyles.heading.copyWith(fontSize: 0.05.sw),
        ),
        Text(
          secondText,
          style: TTextStyles.subtitle

              .copyWith(fontSize: 0.045.sw, color: TColors.primary),
        ),
      ],
    );
  }
}

class Recipe {
  final String name;
  final String imageUrl;
  final String duration;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String avatarImage;
  final String userName;
  final String userEmail;
  final String portion;

  Recipe({
    required this.name,
    required this.imageUrl,
    required this.duration,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.avatarImage,
    required this.userName,
    required this.userEmail,
    required this.portion,
  });
}

final List<Recipe> recipes = [
  Recipe(
    name: 'Crispy Fried Chicken',
    imageUrl: 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58',
    duration: '45 mins',
    description: 'Crispy and juicy fried chicken with special seasoning',
    ingredients: [
      '1 whole chicken',
      '2 cups flour',
      '1 tsp salt',
      '1 tsp black pepper',
      'Vegetable oil for frying'
    ],
    instructions: [
      'Clean the chicken and cut into pieces',
      'Mix flour with seasonings',
      'Coat chicken pieces with flour mixture',
      'Deep fry until golden brown'
    ],
    avatarImage: 'https://randomuser.me/api/portraits/men/1.jpg',
    userName: 'John Doe',
    userEmail: 'john@example.com',
    portion: '4 servings',
  ),
  Recipe(
    name: 'Grilled Salmon',
    imageUrl: 'https://images.unsplash.com/photo-1567121938596-6d9d9ea70783',
    duration: '30 mins',
    description: 'Fresh salmon fillet grilled to perfection',
    ingredients: [
      'Salmon fillet',
      'Olive oil',
      'Lemon',
      'Fresh herbs',
      'Salt and pepper'
    ],
    instructions: [
      'Season salmon with salt and pepper',
      'Brush with olive oil',
      'Grill for 5-6 minutes each side',
      'Garnish with lemon and herbs'
    ],
    avatarImage: 'https://randomuser.me/api/portraits/women/1.jpg',
    userName: 'Jane Smith',
    userEmail: 'jane@example.com',
    portion: '2 servings',
  ),
];

Widget recipeCard(BuildContext context, Recipe recipe) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeScreen(
            recipeData: {
              'title': recipe.name,
              'imageUrl': recipe.imageUrl,
              'cookTime': recipe.duration,
              'description': recipe.description,
              'ingredients': recipe.ingredients,
              'instructions': recipe.instructions,
              'avatarImage': recipe.avatarImage,
              'userName': recipe.userName,
              'userEmail': recipe.userEmail,
              'portion': recipe.portion,
            },
          ),
        ),
      );
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(


          width: 0.2.sw,
          height: 0.2.sw,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(recipe.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),

        SizedBox(width: 0.04.sw),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.name,
              style: TTextStyles.heading.copyWith(

                fontSize: 0.04.sw,
              ),
            ),

            SizedBox(height: 0.01.sh),
            Text(
              recipe.duration,
              style: TTextStyles.subtitle.copyWith(color: TColors.darkGrey),
            ),
          ],
        ),
      ],
    ),
  );

}