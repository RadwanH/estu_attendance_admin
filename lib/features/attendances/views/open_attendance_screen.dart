import 'package:flutter/material.dart';

class OpenAttendanceScreen extends StatelessWidget {
  const OpenAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 16),
          child: Column(
            children: [
              const Text(
                'Open an Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                child: Column(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
