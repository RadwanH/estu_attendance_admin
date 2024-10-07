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
  final weeksController = TextEditingController(text: '14');
  final classroomController = TextEditingController();
  Uint8List? _image;
  String? errorMsg;

  late Course course;

  @override
  initState() {
    super.initState();
    course = Course.empty;
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
                course = course.copyWith(imageUrl: state.imgUrl);
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
            if (state is CreateCourseSuccess) {
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create a Course',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                          maxHeight: 1000,
                          maxWidth: 1000,
                        );

                        if (image != null) {
                          _image = await image.readAsBytes();
                          BlocProvider.of<UploadPictureBloc>(context).add(
                            UploadPicture(_image!, "course_images"),
                          );
                        }
                      },
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.memory(
                                _image!,
                                width: double.infinity,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(16),
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
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Add a Picture...",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
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
                            controller: nameController,
                            hintText: 'Course Name',
                            validator: (val) => val!.isEmpty
                                ? 'Please fill in this field'
                                : null,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              MyMacroWidgetField(
                                title: 'Course Code',
                                icon: FontAwesomeIcons.hashtag,
                                controller: codeController,
                                validator: (val) => val!.isEmpty
                                    ? 'Please fill in this field'
                                    : null,
                              ),
                              const SizedBox(width: 10),
                              MyMacroWidgetField(
                                title: 'Classroom',
                                icon: FontAwesomeIcons.landmark,
                                controller: classroomController,
                                validator: (val) => val!.isEmpty
                                    ? 'Please fill in this field'
                                    : null,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              MyMacroWidgetField(
                                title: 'Weeks',
                                icon: FontAwesomeIcons.calendarWeek,
                                controller: weeksController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (val) => val!.isEmpty
                                    ? 'Please fill in this field'
                                    : null,
                              ),
                              const SizedBox(width: 10),
                              MyMacroWidgetField(
                                title: 'Hours per Week',
                                icon: FontAwesomeIcons.clock,
                                controller: hoursController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (val) => val!.isEmpty
                                    ? 'Please fill in this field'
                                    : null,
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
