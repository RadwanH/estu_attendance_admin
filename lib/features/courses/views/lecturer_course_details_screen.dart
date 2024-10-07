import 'package:course_repository/course_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../components/my_mini_text_card.dart';

class LecturerCourseDetailsScreen extends StatelessWidget {
  final Course? course;
  const LecturerCourseDetailsScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    if (course == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Course Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: const Center(
          child: Text('Course data is not available.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Course Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            child: Center(
              heightFactor: 1,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.onPrimary,
                        Theme.of(context).colorScheme.surface
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildCourseImage(context),
                          const SizedBox(height: 20),
                          _buildCourseName(context),
                          const SizedBox(height: 20),
                          _buildCourseInfo(context),
                          const SizedBox(height: 20),
                          _buildAttendanceSection(context),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseImage(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundImage: course!.imageUrl.isEmpty
            ? const AssetImage('assets/images/estu_logo.png') as ImageProvider
            : NetworkImage(course!.imageUrl),
        child: course!.imageUrl.isEmpty
            ? Icon(
                Icons.image,
                color: Colors.grey[400],
                size: 80,
              )
            : null,
      ),
    );
  }

  Widget _buildCourseName(BuildContext context) {
    return Text(
      course!.name,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildCourseInfo(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MyMiniTextCard(
              title: 'Code',
              value: course!.code,
              icon: FontAwesomeIcons.hashtag,
              iconColor: Colors.lightBlue,
            ),
            MyMiniTextCard(
              title: 'Classroom',
              value: course!.classroom,
              icon: FontAwesomeIcons.landmark,
              iconColor: Colors.lightGreen,
            ),
            MyMiniTextCard(
              title: 'Weeks',
              value: course!.weeks.toString(),
              icon: FontAwesomeIcons.calendarWeek,
              iconColor: Colors.tealAccent,
            ),
            MyMiniTextCard(
              title: 'Hours/Week',
              value: course!.hours.toString(),
              icon: FontAwesomeIcons.clock,
              iconColor: Colors.orangeAccent,
            ),
            MyMiniTextCard(
              title: 'Students',
              value: '${course!.studentsIds?.length ?? 0}',
              icon: FontAwesomeIcons.users,
              iconColor: Colors.deepPurple,
            ),
            const MyMiniTextCard(
              title: 'Lecturer',
              value: 'You',
              icon: FontAwesomeIcons.user,
              iconColor: Colors.deepOrange,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAttendanceSection(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          context.push('/attendance', extra: course!);
        },
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              FaIcon(
                FontAwesomeIcons.arrowRight,
                size: 25,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
