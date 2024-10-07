import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_admin/features/attendances/views/components/atttendance_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      child: Center(
        child: Padding(
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
                                MediaQuery.of(context).size.width / 2 - 32,
                          ),
                          child: InkWell(
                            onTap: () {
                              context.push('/attendance/details', extra: {
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
                  child: Text(
                    'No Attendances found...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
