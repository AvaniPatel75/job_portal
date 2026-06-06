import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/job_model.dart';

class JobDetailScreen extends StatelessWidget {
  final JobModel job;

  const JobDetailScreen({super.key, required this.job});

  Future<void> _launchUrl() async {
    final uri = Uri.parse(job.url);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        title: const Text('Job Details'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            color: Colors.green,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  job.companyName,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: Colors.white60),
                    const SizedBox(width: 4),
                    Text(
                      job.location,
                      style: const TextStyle(
                          color: Colors.white60, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Description
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Text(
                job.description.isNotEmpty
                    ? job.description
                    : 'No description available.',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                  height: 1.6,
                ),
              ),
            ),
          ),

          // Apply Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _launchUrl,
                style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Apply Now',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}