import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnify/providers/home_provider.dart';

class EnrolledScreen extends StatelessWidget {
  const EnrolledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrolled Courses'),
      ),
      body: homeProvider.enrolledCourses.isEmpty
          ? const Center(child: Text('No enrolled courses'))
          : ListView.builder(
              itemCount: homeProvider.enrolledCourses.length,
              itemBuilder: (context, index) {
                final course = homeProvider.enrolledCourses[index];
                return ListTile(
                  title: Text(course['title']),
                  subtitle: Text('Instructor: ${course['instructor']}'),
                );
              },
            ),
    );
  }
}