// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:responsi/controller.dart';
import 'package:responsi/detail_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMealScreen extends StatelessWidget {
  String idMeal;
  DetailMealScreen({
    Key? key,
    required this.idMeal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? linkYoutube;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detail Meal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: FutureBuilder(
          future: Controller.instance.loadList('lookup.php?i=$idMeal'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              MealDetail detail = MealDetail.fromJson(snapshot.data!);

              return ListView.builder(
                itemCount: detail.meals!.length,
                itemBuilder: (context, index) {
                  linkYoutube = detail.meals![index].strYoutube!;
                  return Column(
                    children: [
                      Text(
                        detail.meals![index].strMeal!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Image.network(
                        detail.meals![index].strMealThumb!,
                        height: 200,
                        width: 200,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category : ${detail.meals![index].strCategory}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Area : ${detail.meals![index].strArea}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Tags : ${detail.meals![index].strTags}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              '${detail.meals![index].strInstructions}',
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 18),
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            launchUrl(
              Uri.parse(linkYoutube!),
            );
          },
          child: Container(
            alignment: Alignment.center,
            height: 20,
            width: MediaQuery.of(context).size.width,
            child: const Text('Lihat Youtube'),
          ),
        ),
      ),
    );
  }
}
