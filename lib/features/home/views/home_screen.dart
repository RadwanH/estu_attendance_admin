import 'package:course_repository/course_repository.dart';
import '../../courses/blocs/get_lecturer_courses_bloc/get_lecturer_courses_bloc.dart';

import '../../courses/views/lecturer_courses_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/authentication_bloc/authentication_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Material(
                    elevation: 3,
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {
                        context.go('/create_course');
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: const SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.plus,
                              size: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Add A Course',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20)),
                    child: BlocProvider(
                      create: (context) =>
                          GetLecturerCoursesBloc(FirebaseCourseRepo())
                            ..add(GetLecturerCourses(context
                                .read<AuthenticationBloc>()
                                .state
                                .user!
                                .userId)),
                      child: const LecturerCoursesGrid(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
