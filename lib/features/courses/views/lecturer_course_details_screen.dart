import 'package:course_repository/course_repository.dart';
import '../../../components/my_mini_text_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LecturerCourseDetailsScreen extends StatelessWidget {
  final Course? course;
  const LecturerCourseDetailsScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    if (course == null) {
      return const Scaffold(
        body: Center(
          child: Text('Course data is not available.'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Course Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),
                  course!.imageUrl.isEmpty
                      ? SizedBox(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                Colors.grey,
                                BlendMode.srcIn,
                              ),
                              child: Image.asset(
                                'assets/images/estu_logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 400,
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            radius: 100,
                            backgroundImage: NetworkImage(
                              course!.imageUrl,
                              scale: 1,
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 400,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            course!.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: Row(
                          children: [
                            MyMiniTextCard(
                                title: 'Code',
                                value: course!.code,
                                icon: FontAwesomeIcons.hashtag,
                                iconColor: Colors.lightBlue),
                            const SizedBox(width: 10),
                            MyMiniTextCard(
                                title: 'Classroom',
                                value: course!.classroom,
                                icon: FontAwesomeIcons.landmark,
                                iconColor: Colors.lightGreen),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: Row(
                          children: [
                            MyMiniTextCard(
                                title: 'Weeks',
                                value: course!.weeks.toString(),
                                icon: FontAwesomeIcons.calendarWeek,
                                iconColor: Colors.tealAccent),
                            const SizedBox(width: 10),
                            MyMiniTextCard(
                                title: 'H/W',
                                value: course!.hours.toString(),
                                icon: FontAwesomeIcons.clock,
                                iconColor: Colors.orangeAccent),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: Row(
                          children: [
                            MyMiniTextCard(
                                title: 'Students',
                                value:
                                    '${course!.studentsIds == null ? 0 : course!.studentsIds!.length}',
                                icon: FontAwesomeIcons.users,
                                iconColor: Colors.deepPurple),
                            const SizedBox(width: 10),
                            MyMiniTextCard(
                                title: 'Attendances',
                                value:
                                    ' ${course!.attendancesIds == null ? 0 : course!.attendancesIds!.length}',
                                icon: FontAwesomeIcons.calendar,
                                iconColor: Colors.deepOrange),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(
                        width: 400,
                        child: Divider(
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            context.go('/attendance', extra: course!);
                          },
                          child: Ink(
                            width: 400,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Attendance',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.arrowRight,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
