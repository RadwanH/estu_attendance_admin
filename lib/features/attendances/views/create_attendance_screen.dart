import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_admin/features/attendances/blocs/cubit/create_attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/authentication_bloc/authentication_bloc.dart';

class OpenAttendanceScreen extends StatefulWidget {
  final Course? course;
  const OpenAttendanceScreen({super.key, required this.course});

  @override
  State<OpenAttendanceScreen> createState() => _OpenAttendanceScreenState();
}

class _OpenAttendanceScreenState extends State<OpenAttendanceScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedWeek;
  String? selectedTimer;
  DateTime selectedDate = DateTime.now();
  List<bool> selectedHours = [];

  List<DropdownMenuItem<String>> timerDropdownItems = [];

  Attendance attendance = Attendance.empty;

  @override
  void initState() {
    super.initState();
    selectedHours = List<bool>.filled(widget.course!.hours, false);

    attendance = Attendance.empty;
    selectedTimer = '15';

    timerDropdownItems = List.generate(24, (index) {
      final int value = (index + 1) * 5;
      return DropdownMenuItem<String>(
        value: value.toString(),
        child: Text('$value minutes'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAttendanceCubit, CreateAttendanceState>(
      listener: (context, state) {
        if (state is CreateAttendanceSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Attendance created successfully'),
              duration: Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            context.go('/attendance');
          });
        } else if (state is CreateAttendanceFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('Failed to create attendance: ${state.message}'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                color: Theme.of(context).colorScheme.onSurface,
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: 500,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Open an Attendance',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                color: Theme.of(context).colorScheme.onSurface,
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: 500,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.course!.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              textAlign: TextAlign.center,
                              initialValue: selectedDate.toString(),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              readOnly: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: .2,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButtonFormField<String>(
                                  value: selectedWeek,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedWeek = value!;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Week',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(0),
                                  ),
                                  isExpanded: true,
                                  style: const TextStyle(color: Colors.black),
                                  dropdownColor: Colors.white,
                                  icon: const Icon(Icons.keyboard_arrow_down,
                                      color: Colors.black),
                                  items: List.generate(widget.course!.weeks,
                                      (index) {
                                    return DropdownMenuItem(
                                      value: (index + 1).toString(),
                                      child: Text('Week ${(index + 1)}'),
                                    );
                                  }),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a week';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: .2,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButtonFormField<String>(
                                  value: selectedTimer,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedTimer = value!;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Timer',
                                      border: InputBorder.none),
                                  isExpanded: true,
                                  style: const TextStyle(color: Colors.black),
                                  dropdownColor: Colors.white,
                                  icon: const Icon(Icons.keyboard_arrow_down,
                                      color: Colors.black),
                                  items: timerDropdownItems,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'The attendance is for:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12.0,
                          runSpacing: 12.0,
                          children:
                              List.generate(widget.course!.hours, (index) {
                            return Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: 147,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal: 0, vertical: 5),
                                child: CheckboxListTile(
                                  value: selectedHours[index],
                                  title: Text('Hour ${index + 1}'),
                                  controlAffinity:
                                      ListTileControlAffinity.platform,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedHours[index] = value ?? false;
                                    });
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<CreateAttendanceCubit,
                            CreateAttendanceState>(
                          builder: (context, state) {
                            if (state is CreateAttendanceLoading) {
                              return const CircularProgressIndicator();
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Process the attendance data here

                                  final selectedHourIndices = <int>[];

                                  for (int i = 0;
                                      i < selectedHours.length;
                                      i++) {
                                    if (selectedHours[i]) {
                                      selectedHourIndices.add(i + 1);
                                    }
                                  }

                                  final authState =
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .state;
                                  if (authState.status ==
                                      AuthenticationStatus.authenticated) {
                                    attendance = attendance.copyWith(
                                      lecturerId: authState.user!.userId,
                                    );
                                  }

                                  attendance = attendance.copyWith(
                                    courseId: widget.course!.courseId,
                                    week: int.parse(selectedWeek!),
                                    timer: int.parse(selectedTimer!),
                                    forHours: selectedHourIndices,
                                  );

                                  print(attendance.toString());

                                  context
                                      .read<CreateAttendanceCubit>()
                                      .createAttendance(attendance);
                                }
                              },
                              child: const Text('Create Attendance'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
