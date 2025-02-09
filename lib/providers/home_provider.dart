import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {
  List<Map<String, dynamic>> courses = [];
  List<Map<String, dynamic>> pdfs = [];
  List<Map<String, dynamic>> enrolledCourses = [];

  HomeProvider() {
    loadCourses();
    loadPdfs();
    loadEnrolledCourses();
  }

  Future<void> loadCourses() async {
    final String response = await rootBundle.loadString('assets/courses.json');
    final data = json.decode(response) as List;
    courses = data.map((course) => course as Map<String, dynamic>).toList();
    notifyListeners();
  }

  Future<void> loadPdfs() async {
    final String response = await rootBundle.loadString('assets/pdf.json');
    final data = json.decode(response) as List;
    
    List<Map<String, dynamic>> tempPdfs = [];
    
    for (var pdf in data) {
      String localPath = await _copyAssetPdfToLocal(pdf['file']);
      tempPdfs.add({
        "category": pdf['category'],
        "title": pdf['title'],
        "file": localPath, // Save the local file path
      });
    }
    
    pdfs = tempPdfs;
    notifyListeners();
  }

  Future<String> _copyAssetPdfToLocal(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = '${tempDir.path}/${assetPath.split('/').last}';
    
    final File file = File(tempPath);
    await file.writeAsBytes(bytes, flush: true);
    
    return tempPath;
  }

  Future<void> loadEnrolledCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final enrolledCourseIds = prefs.getStringList('enrolledCourses') ?? [];

    enrolledCourses = courses
        .where((course) => enrolledCourseIds.contains(course['id'].toString()))
        .toList();
    notifyListeners();
  }

  Future<void> enrollCourse(Map<String, dynamic> course) async {
    final prefs = await SharedPreferences.getInstance();
    final enrolledCourseIds = prefs.getStringList('enrolledCourses') ?? [];

    final courseId = course['id'].toString();
    if (!enrolledCourseIds.contains(courseId)) {
      enrolledCourseIds.add(courseId);
      await prefs.setStringList('enrolledCourses', enrolledCourseIds);
      enrolledCourses.add(course);
      notifyListeners();
    }
  }
}
