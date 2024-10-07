import 'package:course_repository/course_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceCardLg extends StatelessWidget {
  final Attendance attendance;
  final Color? color;
  final String? courseName;

  const AttendanceCardLg({
    super.key,
    required this.attendance,
    this.courseName,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final formattedDate = attendance.date != null
        ? dateFormat.format(attendance.date!)
        : 'No date';

    final formattedTime = attendance.date != null
        ? timeFormat.format(attendance.date!)
        : 'No time';

    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black26,
        child: Container(
          width: 530,
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: color != null
                  ? [
                      color!.withOpacity(0.8),
                      color!.withOpacity(0.4),
                    ]
                  : [
                      Colors.blue.shade200,
                      Colors.blue.shade50,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  courseName ?? 'No course name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.blue.shade600,
                        size: 30,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.blue.shade600,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        formattedTime,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 30, thickness: 1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.school,
                            color: Colors.black87,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Week: ${attendance.week}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.black87,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Timer: ${attendance.timer}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.people,
                            color: Colors.black87,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Attendees: ${attendance.attendeesIds?.length ?? 0}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.schedule,
                            color: Colors.black87,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'For Hours: ${attendance.forHours.join(', ')}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
