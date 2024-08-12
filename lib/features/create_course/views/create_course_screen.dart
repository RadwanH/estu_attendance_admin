import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_admin/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:estu_attendance_admin/components/my_macro_widget.dart';
import 'package:estu_attendance_admin/features/create_course/blocs/create_coourse_cubit/create_course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/my_text_feild.dart';
import '../blocs/upload_picture_bloc/upload_picture_bloc.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final hoursController = TextEditingController();
  var weeksController = TextEditingController();
  final classroomController = TextEditingController();
  Uint8List? _image;

  String? _errorMsg;
  bool creationRequired = false;

  late Course course;
  @override
  initState() {
    super.initState();
    course = Course.empty;
    weeksController = TextEditingController(text: '14');
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    hoursController.dispose();
    weeksController.dispose();
    classroomController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UploadPictureBloc, UploadPictureState>(
          listener: (context, state) {
            if (state is UploadPictureSuccess) {
              setState(() {
                course.imageUrl = state.imgUrl;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image Uploaded Successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is UploadPictureFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
        BlocListener<CreateCourseCubit, CreateCourseState>(
          listener: (context, state) {
            if (state is CreateCourseLoading) {
              setState(() {
                creationRequired = true;
              });
            } else if (state is CreateCourseSuccess) {
              setState(() {
                creationRequired = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Course Created Successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              context.go('/');
            } else if (state is CreateCourseFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create a Course',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();

                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 1000,
                        maxWidth: 1000,
                      );

                      _image = await image!.readAsBytes();

                      if (_image != null && context.mounted) {
                        BlocProvider.of<UploadPictureBloc>(context).add(
                            UploadPicture(
                                await image.readAsBytes(), "course_images"));
                      }
                    },
                    child: course.imageUrl.isNotEmpty
                        ? Ink(
                            width: 400,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Image.memory(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Ink(
                            width: 400,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.camera,
                                  size: 100,
                                  color: Colors.grey.shade200,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Add a Picture here...",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 400,
                            child: MyTextField(
                              fillColor: Colors.white,
                              controller: nameController,
                              hintText: 'Course Name',
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                }
                                return null;
                              },
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 400,
                            child: Row(
                              children: [
                                MyMacroWidget(
                                  title: 'Course Code',
                                  icon: FontAwesomeIcons.hashtag,
                                  iconColor: Colors.lightBlue,
                                  controller: codeController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(width: 10),
                                MyMacroWidget(
                                  title: 'Classroom',
                                  icon: FontAwesomeIcons.landmark,
                                  iconColor: Colors.lightGreen,
                                  controller: classroomController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 400,
                            child: Row(
                              children: [
                                MyMacroWidget(
                                  title: 'Weeks',
                                  icon: FontAwesomeIcons.calendarWeek,
                                  iconColor: Colors.tealAccent,
                                  controller: weeksController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(width: 10),
                                MyMacroWidget(
                                  title: 'Hours per Week',
                                  icon: FontAwesomeIcons.clock,
                                  iconColor: Colors.orangeAccent,
                                  controller: hoursController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  !creationRequired
                      ? SizedBox(
                          width: 400,
                          height: 40,
                          child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  //TODO: later you might want to upload the image here so that the image gets uploaded to the server only when the form is valid and the course is ready

                                  // BlocProvider.of<UploadPictureBloc>(context)
                                  //     .add(UploadPicture(
                                  //         _image!, "course_images"));

                                  final authState =
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .state;
                                  if (authState.status ==
                                      AuthenticationStatus.authenticated) {
                                    // course.lecturerId = authState.user!.userId;
                                    course = course.copyWith(
                                      lecturerId: authState.user!.userId,
                                    );
                                  }

                                  course = course.copyWith(
                                    name: nameController.text,
                                    code: codeController.text,
                                    classroom: classroomController.text,
                                    hours: int.parse(hoursController.text),
                                    weeks: int.parse(weeksController.text),
                                  );

                                  // setState(() {
                                  //   course.name = nameController.text;
                                  //   course.code = codeController.text;
                                  //   course.classroom = classroomController.text;
                                  //   course.hours =
                                  //       int.parse(hoursController.text);
                                  //   course.weeks =
                                  //       int.parse(weeksController.text);
                                  // });

                                  BlocProvider.of<CreateCourseCubit>(context)
                                      .createCourse(course);
                                }
                              },
                              style: TextButton.styleFrom(
                                  elevation: 3.0,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60))),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                child: Text(
                                  'Create Course',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                        )
                      : const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  selectImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (file != null) {
      return await file.readAsBytes();
    }
  }
}
