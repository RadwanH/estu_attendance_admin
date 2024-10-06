import 'package:estu_attendance_admin/features/attendances/blocs/edit_student_attendance_status_cubit/edit_student_attendance_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estu_attendance_admin/blocs/get_students_cubit/get_students_cubit.dart';
import 'package:estu_attendance_admin/features/attendances/views/components/attendance_card_lg.dart';

import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';
import 'package:course_repository/course_repository.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  final Course course;
  final Attendance attendance;

  const AttendanceDetailsScreen({
    Key? key,
    required this.course,
    required this.attendance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<GetStudentsCubit>().getStudents(course.studentsIds ?? []);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/attendance', extra: course);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context
                  .read<GetStudentsCubit>()
                  .getStudents(course.studentsIds ?? []);
            },
          ),
        ],
        title: const Center(child: Text('Attendance Details')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Course: ${course.name}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            AttendanceCardLg(attendance: attendance),
            const SizedBox(height: 16),
            Center(
              child: BlocProvider(
                create: (context) => EditStudentAttendanceStatusCubit(
                  FirebaseAttendanceRepo(),
                ),
                child: BlocBuilder<GetStudentsCubit, GetStudentsState>(
                  builder: (context, state) {
                    if (state is GetStudentsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetStudentsFailure) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else if (state is GetStudentsSuccess) {
                      if (state.students.isEmpty) {
                        return const Center(child: Text('No students found.'));
                      }

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: DataTable(
                            columnSpacing: 30,
                            dataRowMaxHeight: 60,
                            headingRowColor: WidgetStateProperty.all(
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                            ),
                            columns: const [
                              DataColumn(label: Text('TC Number')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Surname')),
                              DataColumn(label: Text('Attendance')),
                              DataColumn(label: Text('Edit')),
                            ],
                            rows: state.students.map((student) {
                              bool attended = attendance.attendeesIds!
                                  .contains(student.userId);
                              return DataRow(cells: [
                                DataCell(Text(student.tcId.toString())),
                                DataCell(Text(student.name)),
                                DataCell(Text(student.lastname)),
                                DataCell(
                                  Center(
                                    child: Icon(
                                      attended
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color:
                                          attended ? Colors.green : Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // Pass the current context (from the parent widget)
                                      final parentContext = context;

                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Edit Attendance'),
                                            content: const Text(
                                                'Mark the student as present or absent?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  if (!attended) {
                                                    parentContext
                                                        .read<
                                                            EditStudentAttendanceStatusCubit>()
                                                        .editStudentAttendance(
                                                          attendance:
                                                              attendance,
                                                          studentId:
                                                              student.userId,
                                                          isPresent: true,
                                                        );
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Present'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  if (attended) {
                                                    parentContext
                                                        .read<
                                                            EditStudentAttendanceStatusCubit>()
                                                        .editStudentAttendance(
                                                          attendance:
                                                              attendance,
                                                          studentId:
                                                              student.userId,
                                                          isPresent: false,
                                                        );
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Absent'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: Text('Unexpected state'));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
