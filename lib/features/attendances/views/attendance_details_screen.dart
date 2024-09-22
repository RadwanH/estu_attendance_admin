import 'package:estu_attendance_admin/blocs/get_students_cubit/get_students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    print('students Ids at the attendance details screen: ${course}');
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course: ${course.name}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Expanded(
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
                            columnSpacing: 20,
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
                              DataColumn(
                                label: Text('Attendance'),
                              ),

                            ],
                            rows: state.students.map((student) {
                              bool attended = attendance.attendeesIds!
                                  .contains(student.userId);
                              return DataRow(cells: [
                                DataCell(Text(student.tcId.toString())),
                                DataCell(Text(student.name)),
                                DataCell(Text(student.lastname)),
                                DataCell(
                                  Icon(
                                    attended
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: attended ? Colors.green : Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Unexpected state'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
