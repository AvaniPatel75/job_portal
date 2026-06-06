import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/job_controller.dart';
import '../model/job_model.dart';
import 'job_detail_screen.dart';

class JobDashboardScreen extends StatelessWidget {
  const JobDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobController>();

    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: const Text(
          'HireHub',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 60, color: Colors.grey),
                const SizedBox(height: 12),
                const Text(
                  'Something went wrong.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchJobs,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A73E8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        if (controller.allJobs.isEmpty) {
          return const Center(child: Text('No jobs found.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.allJobs.length,
          itemBuilder: (context, index) {
            final job = controller.allJobs[index];
            return _JobCard(job: job, index: index, controller: controller);
          },
        );
      }),
    );
  }
}

class _JobCard extends StatelessWidget {
  final JobModel job;
  final int index;
  final JobController controller;

  const _JobCard({
    required this.job,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => JobDetailScreen(job: job)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF1A1A2E),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    job.companyName,
                    style: const TextStyle(
                      color: Color(0xFF1A73E8),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 13, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          job.location,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bookmark Button
            Obx(() => IconButton(
                  icon: Icon(
                    controller.isBookmarked(index)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: controller.isBookmarked(index)
                        ? Colors.redAccent
                        : Colors.grey,
                  ),
                  onPressed: () => controller.toggleBookmark(index),
                )),
          ],
        ),
      ),
    );
  }
}