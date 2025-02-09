import 'package:flutter/material.dart';
import 'package:learnify/components/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:learnify/providers/home_provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const RalewayText(
            text: 'Categories',
            fontSize: 26,
            fWaight: FontWeight.bold,
            color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: Provider.of<HomeProvider>(context, listen: false)
              .loadCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Consumer<HomeProvider>(
                builder: (context, homeProvider, child) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: homeProvider.categories.length,
                    itemBuilder: (context, index) {
                      final category = homeProvider.categories[index];
                      return GestureDetector(
                        onTap: () {},
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: GridTile(
                            footer: GridTileBar(
                              backgroundColor: Colors.black54,
                              title: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RalewayText(
                                      text: category['name'],
                                      fontSize: 16,
                                      fWaight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            child: Image.asset(category['thumbnail'],
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
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
