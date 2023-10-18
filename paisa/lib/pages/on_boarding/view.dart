import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa/localization/translation_keys.dart' as translation;
import 'package:paisa/pages/on_boarding/widgets/intro_image_picker_widget.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_set_name_widget.dart';

class UserOnboardingPage extends StatefulWidget {
  const UserOnboardingPage({super.key});

  @override
  State<UserOnboardingPage> createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        controller: _pageController,
        children: [
          IntroSetNameWidget(
            formState: _formState,
            nameController: _nameController,
          ),
          IntroImagePickerWidget(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Visibility(
                visible: currentIndex != 0,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.bounceIn,
                    );
                  },
                  label: Text("Back"),
                ),
              ),
              const Spacer(),
              FloatingActionButton.extended(
                onPressed: () {
                  if (currentIndex == 0) {}
                },
                label: const Icon(Icons.arrow_forward),
                icon: Text(
                  translation.next.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
