import 'package:course_repository/course_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/atttendance_card.dart';

class AttendancesGrid extends StatelessWidget {
  final List<Attendance> attendances;
  final Course course;
  const AttendancesGrid({
    super.key,
    required this.attendances,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Attendances',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: attendances.isNotEmpty
                    ? Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: attendances
                            .map(
                              (attendance) => ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 2 -
                                          32,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    context.go('/attendance/details', extra: {
                                      'course': course,
                                      'attendance': attendance,
                                    });
                                  },
                                  child: AttendanceCard(attendance: attendance),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : const Center(
                        child: Text('No Attendances found...'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
