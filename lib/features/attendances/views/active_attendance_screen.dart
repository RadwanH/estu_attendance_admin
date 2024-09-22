import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_admin/features/attendances/blocs/current_attendance_cubit/current_attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ActiveAttendanceScreen extends StatelessWidget {
  const ActiveAttendanceScreen({super.key, required this.course});

  final Course course;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: theme.colorScheme.surface,
                  elevation: 3,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.go('/attendance', extra: course);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Active Attendance',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Material(
                  elevation: 3,
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: BlocBuilder<CurrentAttendanceCubit,
                          CurrentAttendanceState>(builder: (context, state) {
                        if (state is CurrentAttendanceInProgress) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Course: ${course.name}",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Week: ${state.attendance.week}",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      Text(
                                        "For Lessons:",
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                      ...state.attendance.forHours
                                          .map(
                                            (hour) => Container(
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: theme.colorScheme.primary
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: theme
                                                        .colorScheme.shadow
                                                        .withOpacity(0.2),
                                                    offset: const Offset(2, 2),
                                                    blurRadius: 5,
                                                  )
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  hour.toString(),
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Open for: ${state.attendance.timer} minutes",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    state.generatedCode,
                                    style:
                                        theme.textTheme.headlineLarge?.copyWith(
                                      fontSize: 50,
                                      color: theme.colorScheme.secondary,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Time Left: ${state.remainingTime ~/ 60}:${(state.remainingTime % 60).toString().padLeft(2, '0')} min",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (state is CurrentAttendanceSessionEnded) {
                          return Center(
                              child: Text(
                            "The Attendance Has Expired.",
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ));
                        } else if (state is CurrentAttendanceSuccess) {
                          return Center(
                            child: Text(
                              "No Attendances Opened At The Moment",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.grey.withOpacity(0.8),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          );
                        } else {
                          print(
                              'state in the last else clause of active attendance:  $state');
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
