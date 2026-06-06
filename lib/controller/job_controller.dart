import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/job_model.dart';

class JobController extends GetxController {
  final RxList<JobModel> allJobs = <JobModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxSet<int> bookmarkedIndexes = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final response = await http.get(
        Uri.parse('https://www.arbeitnow.com/api/job-board-api'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List jobs = data['data'] ?? [];
        allJobs.value = jobs.map((j) => JobModel.fromJson(j)).toList();
      } else {
        hasError.value = true;
      }
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void toggleBookmark(int index) {
    if (bookmarkedIndexes.contains(index)) {
      bookmarkedIndexes.remove(index);
    } else {
      bookmarkedIndexes.add(index);
    }
  }

  bool isBookmarked(int index) => bookmarkedIndexes.contains(index);
}