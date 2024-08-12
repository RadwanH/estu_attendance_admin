import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_admin/features/courses/get_lecturer_courses/blocs/get_lecturer_courses_bloc/get_lecturer_courses_bloc.dart';

import 'package:estu_attendance_admin/features/courses/get_lecturer_courses/views/lecturer_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LecturerCoursesGrid extends StatelessWidget {
  const LecturerCoursesGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<GetLecturerCoursesBloc, GetLecturerCoursesState>(
        builder: (context, state) {
          if (state is GetLecturerCoursesSuccess) {
            return CourseGrid(courses: state.courses);
          } else if (state is GetLecturerCoursesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('An error has occurred while loading courses...'),
            );
          }
        },
      ),
    );
  }
}

class CourseGrid extends StatelessWidget {
  final List<Course> courses;
  const CourseGrid({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 40,
          runSpacing: 40,
          children: courses
              .map(
                (course) => LecturerCourseCard(course: course),
              )
              .toList(),
        ),
      ),
    );
  }
}
