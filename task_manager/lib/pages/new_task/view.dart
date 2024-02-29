import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/common/app_colors.dart';
import 'package:task_manager/pages/tasks/widgets/custom_app_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Create New Task"),
      body: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2030, 1, 1),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor.withOpacity(.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: const Text('Select a date range'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Title',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.kBlackColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: AppColors.kPrimaryColor,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.kWhiteColor,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.kGrey1,
                    ),
                  ),
                  hoverColor: AppColors.kWhiteColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Description',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.kBlackColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: AppColors.kPrimaryColor,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.kWhiteColor,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.kGrey1,
                    ),
                  ),
                  hoverColor: AppColors.kWhiteColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
