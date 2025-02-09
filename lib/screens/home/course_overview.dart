import 'package:flutter/material.dart';
import 'package:learnify/components/custom_text.dart';
import 'package:learnify/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:learnify/screens/home/pdf_viewer/pdf_viewer.dart';

class CourseOverview extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseOverview({super.key, required this.course});

  @override
  State<CourseOverview> createState() => _CourseOverviewState();
}

class _CourseOverviewState extends State<CourseOverview> {
  bool _isEnrolled = false;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const RalewayText(
          text: "Course Overview",
          color: Colors.white,
          fWaight: FontWeight.bold,
          fontSize: 26,
        ),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.course['thumbnail'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.course['title'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Instructor: ${widget.course['instructor']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.course['description'],
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Duration: ${widget.course['duration']} weeks',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Sessions: ${widget.course['sessions']}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (!_isEnrolled)
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isEnrolled = true;
                    });
                    await homeProvider.enrollCourse(widget.course);
                  },
                  child: const Text('Enroll Now'),
                ),
              ),
            if (_isEnrolled) ...[
              const Text(
                'PDFs:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) {
                    final pdfs = homeProvider.pdfs
                        .where((pdf) =>
                            pdf['category'] == widget.course['category'])
                        .toList();

                    return ListView.builder(
                      itemCount: pdfs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.picture_as_pdf,
                              color: Colors.red),
                          title: Text(pdfs[index]['title']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFViewerScreen(
                                  filePath: pdfs[index]['file'],
                                  title: pdfs[index]['title'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
