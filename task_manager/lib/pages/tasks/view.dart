import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task_manager/common/app_colors.dart';
import 'package:task_manager/pages/tasks/controller.dart';
import 'package:task_manager/pages/tasks/widgets/custom_app_bar.dart';
import 'package:task_manager/routes/app_pages.dart';
import 'package:task_manager/routes/app_routes.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController searchController = TextEditingController();
  final TasksController tasksController = Get.put(TasksController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hi Jerome',
        showBackArrow: false,
        actionWidgets: [
          PopupMenuButton<int>(
            elevation: 1,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/calender.svg',
                        width: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Sort by date",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset('assets/svgs/filter.svg'),
            ),
          )
        ],
      ),
      body: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => tasksController.tasks.isNotEmpty
                ? const Column()
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/tasks.svg',
                          height: Get.mediaQuery.size.height * .20,
                          width: Get.mediaQuery.size.width,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Schedule your tasks',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 30,
                            color: AppColors.kBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Manage your task schedule easily\nand efficiently',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.kBlackColor.withOpacity(.5),
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.createNewTask);
        },
        child: const Icon(
          Icons.add_circle,
          color: AppColors.kPrimaryColor,
        ),
      ),
    );
  }
}
