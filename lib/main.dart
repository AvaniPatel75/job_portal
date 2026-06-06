import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/job_controller.dart';
import 'screens/job_dashboard.dart';

void main() {
  Get.put(JobController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HireHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: false,
      ),
      home: JobDashboardScreen(),
    );
  }
}
