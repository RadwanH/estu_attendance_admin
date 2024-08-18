import 'features/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Estu Attendance Admin Panel',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
            surface: Colors.grey.shade200,
            onSurface: Colors.black,
            primary: Colors.blue,
            onPrimary: Colors.white),
      ),
      routerConfig: router(context.read<AuthenticationBloc>()),
    );
  }
}
