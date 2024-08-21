import 'package:course_repository/course_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/authentication_bloc/authentication_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            context.go('/home');
            // context.go(
            //   '/attendance/active-attendance',
            //   extra: Attendance(
            //     id: '2d3ec1f0-5e10-11ef-b63f-bbd5110a8455',
            //     lecturerId: '',
            //     courseId: '2d3ec1f0-5e10-11ef-b63f-bbd5110a8455',
            //     week: 3,
            //     timer: 1,
            //     forHours: [1, 2, 3],
            //     isActive: true,
            //     generatedCode: 'XYUJ9B',
            //   ),
            // );
          } else if (state.status == AuthenticationStatus.unauthenticated) {
            context.go('/login');
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
