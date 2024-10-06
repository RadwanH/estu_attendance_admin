import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_admin/blocs/get_students_cubit/get_students_cubit.dart';
import 'package:estu_attendance_admin/features/attendances/blocs/current_attendance_cubit/current_attendance_cubit.dart';
import 'package:estu_attendance_admin/features/attendances/blocs/edit_student_attendance_status_cubit/edit_student_attendance_status_cubit.dart';
import 'package:estu_attendance_admin/features/attendances/views/active_attendance_screen.dart';
import 'package:user_repository/user_repository.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../attendances/blocs/create_attendance_cubit/create_attendance_cubit.dart';
import '../attendances/views/attendance_details_screen.dart';
import '../attendances/views/attendance_screen.dart';
import '../attendances/views/create_attendance_screen.dart';
import '../auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../auth/views/sign_in_screen.dart';
import '../courses/blocs/create_course_cubit/create_course_cubit.dart';
import '../courses/blocs/upload_picture_bloc/upload_picture_bloc.dart';
import '../courses/views/lecturer_course_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../attendances/blocs/get_attendances_bloc/get_attendances_bloc.dart';
import '../base/views/base_screen.dart';
import '../courses/views/create_course_screen.dart';
import '../home/views/home_screen.dart';
import '../splash/views/splash_screen.dart';

final _navKey = GlobalKey<NavigatorState>();
final _shellNavigationKey = GlobalKey<NavigatorState>();

GoRouter router(AuthenticationBloc authenticationBloc) {
  return GoRouter(
    navigatorKey: _navKey,
    initialLocation: '/',
    redirect: (context, state) {
      if (authenticationBloc.state.status == AuthenticationStatus.unknown) {
        return '/';
      }
    },
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigationKey,
        builder: (context, state, child) {
          if (state.fullPath == '/login' || state.fullPath == '/') {
            return child;
          } else {
            return BlocProvider<SignInBloc>(
              create: (context) =>
                  SignInBloc(context.read<AuthenticationBloc>().userRepository),
              child: BaseScreen(child),
            );
          }
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
              child: const SplashScreen(),
            ),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
              child: BlocProvider<SignInBloc>(
                create: (context) => SignInBloc(
                    context.read<AuthenticationBloc>().userRepository),
                child: const SignInScreen(),
              ),
            ),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => BlocProvider.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
              child: const HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/create_course',
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UploadPictureBloc(
                    FirebaseCourseRepo(),
                  ),
                ),
                BlocProvider<CreateCourseCubit>(
                  create: (context) => CreateCourseCubit(
                    courseRepo: FirebaseCourseRepo(),
                  ),
                ),
                BlocProvider.value(
                  value: context.read<AuthenticationBloc>(),
                ),
              ],
              child: const CreateCourseScreen(),
            ),
          ),
          GoRoute(
            path: '/course_details',
            builder: (context, state) {
              final course = state.extra as Course?;
              return BlocProvider.value(
                value: context.read<AuthenticationBloc>(),
                child: LecturerCourseDetailsScreen(course: course),
              );
            },
          ),
          GoRoute(
            path: '/attendance',
            builder: (context, state) {
              final course = state.extra as Course?;
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<AuthenticationBloc>(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        GetAttendancesBloc(FirebaseAttendanceRepo())
                          ..add(
                            GetAttendances(courseId: course!.courseId),
                          ),
                  ),
                ],
                child: AttendancesScreen(
                  course: course,
                ),
              );
            },
          ),
          GoRoute(
            path: '/attendance/create-attendance',
            builder: (context, state) {
              final course = state.extra as Course?;
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<AuthenticationBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => CreateAttendanceCubit(
                      attendanceRepo: FirebaseAttendanceRepo(),
                    ),
                  ),
                ],
                child: OpenAttendanceScreen(
                  course: course,
                ),
              );
            },
          ),
          GoRoute(
            path: '/attendance/active-attendance',
            builder: (context, state) {
              final extras = state.extra as Map<String, dynamic>;
              final attendance = extras['attendance'] as Attendance;
              final course = extras['course'] as Course;

              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<AuthenticationBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => CurrentAttendanceCubit(
                      FirebaseAttendanceRepo(),
                    )..startAttendanceSession(attendance),
                  ),
                ],
                child: ActiveAttendanceScreen(
                  course: course,
                ),
              );
            },
          ),
          GoRoute(
            path: '/attendance/details',
            builder: (context, state) {
              final extras = state.extra as Map<String, dynamic>;
              final attendance = extras['attendance'] as Attendance;
              final course = extras['course'] as Course;

              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => GetStudentsCubit(
                      FirebaseUserRepo(),
                    )..getStudents(course.studentsIds ?? []),
                  ),
                ],
                child: AttendanceDetailsScreen(
                  course: course,
                  attendance: attendance,
                ),
              );
            },
          ),
        ],
      )
    ],
  );
}
