// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsi/controller.dart';
import 'package:responsi/detail_meal_screen.dart';
import 'package:responsi/meal_model.dart';

class DetailCategory extends StatelessWidget {
  String categoryName;
  DetailCategory({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('$categoryName Meal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
          future: Controller.instance.loadList('filter.php?c=$categoryName'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Meal meal = Meal.fromJson(snapshot.data!);
              return ListView.builder(
                itemCount: meal.meals.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMealScreen(
                              idMeal: meal.meals[index].idMeal),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          Image.network(
                            meal.meals[index].strMealThumb,
                            width: 150,
                            height: 150,
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text(
                              meal.meals[index].strMeal,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
