import 'package:flutter/material.dart';
import 'package:responsi/category_model.dart';
import 'package:responsi/controller.dart';
import 'package:responsi/detail_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Meal Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: Controller.instance.loadList('categories.php'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Category category = Category.fromJson(snapshot.data!);
              return ListView.builder(
                itemCount: category.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailCategory(
                            categoryName:
                                category.categories[index].strCategory,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          Image.network(
                            category.categories[index].strCategoryThumb,
                            width: 150,
                            height: 150,
                          ),
                          Flexible(
                            child: Text(
                              category.categories[index].strCategory,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
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
