import 'package:flutter/material.dart';
import 'package:learnify/components/custom_text.dart';
import 'package:learnify/providers/home_provider.dart';
import 'package:learnify/screens/home/course_overview/course_overview.dart';
import 'package:learnify/utils/custom_navigator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.loadCourses();
    homeProvider.loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const RalewayText(
          text: "Courses",
          color: Colors.white,
          fWaight: FontWeight.bold,
          fontSize: 26,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            if (homeProvider.courses.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            // Group courses by category
            final Map<String, List<Map<String, dynamic>>> categorizedCourses =
                {};
            for (var course in homeProvider.courses) {
              if (!categorizedCourses.containsKey(course['category'])) {
                categorizedCourses[course['category']] = [];
              }
              categorizedCourses[course['category']]!.add(course);
            }

            return ListView(
              children: categorizedCourses.entries.map((entry) {
                final category = entry.key;
                final courses = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RalewayText(
                        text: category,
                        color: Colors.teal,
                        fWaight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 250, // Adjust height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          final course = courses[index];
                          return GestureDetector(
                            onTap: () {
                              CustomNavigator.goto(
                                context,CourseOverview(course: course),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              color: Colors.teal[50],
                              child: SizedBox(
                                width: 170, // Adjust width as needed
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          course['thumbnail'],
                                          height: 100,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        course['title'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                          'Instructor: ${course['instructor']}'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                          'Duration: ${course['duration']} weeks'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child:
                                          Text('Sessions: ${course['sessions']}'),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          LinearProgressIndicator(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.teal,
                                            value: course['progress'],
                                          ),
                                          //const SizedBox(height: 5),
                                          Text(
                                            '${(course['progress'] * 100).toStringAsFixed(1)}% completed',
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
