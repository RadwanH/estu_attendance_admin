import 'package:course_repository/course_repository.dart';
import '../../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../../components/my_macro_widget_field.dart';
import '../blocs/create_course_cubit/create_course_cubit.dart';
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
              const CircularProgressIndicator();
            } else if (state is CreateCourseSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Course Created Successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              context.go('/home');
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
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      child: _image != null
                          ? Ink(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.memory(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Ink(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.camera,
                                    size: 100,
                                    color: Colors.grey.shade300,
                                  ),
                                  const SizedBox(height: 10),
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
                          MyTextField(
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
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(
                                child: MyMacroWidgetField(
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
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: MyMacroWidgetField(
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
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(
                                child: MyMacroWidgetField(
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
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: MyMacroWidgetField(
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<CreateCourseCubit, CreateCourseState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final authState =
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .state;
                                if (authState.status ==
                                    AuthenticationStatus.authenticated) {
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

                                BlocProvider.of<CreateCourseCubit>(context)
                                    .createCourse(course);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: state is CreateCourseLoading
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : const Text(
                                    'Create Course',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
