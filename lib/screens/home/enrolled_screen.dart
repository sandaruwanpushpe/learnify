import 'package:flutter/material.dart';
import 'package:learnify/components/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:learnify/providers/home_provider.dart';

class EnrolledScreen extends StatelessWidget {
  const EnrolledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const RalewayText(
          text: "My Courses",
          color: Colors.white,
          fWaight: FontWeight.bold,
          fontSize: 26,
        ),
        automaticallyImplyLeading: false,
      ),
      body: homeProvider.enrolledCourses.isEmpty
          ? const Center(child: Text('No enrolled courses'))
            : ListView.builder(
              itemCount: homeProvider.enrolledCourses.length,
              itemBuilder: (context, index) {
              final course = homeProvider.enrolledCourses[index];
              return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
                ),
              ],
              ),
              child: Row(
                children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                  course['thumbnail'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    course['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    const SizedBox(height: 8),
                    Text('Instructor: ${course['instructor']}'),
                  ],
                  ),
                ),
                ],
              ),
              );
              },
            ),
        );
  }
}
