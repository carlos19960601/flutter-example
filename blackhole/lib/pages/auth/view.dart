import 'package:blackhole/localization/translation_keys.dart'
    as translation_keys;
import 'package:blackhole/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Box setting = GStorage.setting;
  Uuid uuid = const Uuid();

  Future _addUserData(String name) async {
    await setting.put(SettingBoxKey.name, name.trim());

    final String userId = uuid.v1();
    await setting.put(SettingBoxKey.userId, userId);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // 背景图片
            Positioned(
              left: MediaQuery.sizeOf(context).width / 1.85,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width,
                child: const Image(
                  image: AssetImage(
                    "assets/icon-white-trans.png",
                  ),
                ),
              ),
            ),
            Column(
              children: [
                // 恢复按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        translation_keys.restore.tr,
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.7),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        translation_keys.skip.tr,
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.7),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // 展示文字logo
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Black\nHole\n',
                                  style: TextStyle(
                                    height: 0.97,
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Music',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 80,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 80,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.1,
                          ),
                          // 昵称输入
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                  left: 10,
                                  right: 10,
                                ),
                                height: 57.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[900],
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5.0,
                                      offset: Offset(0.0, 3.0),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: controller,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: translation_keys.enterName.tr,
                                    hintStyle: const TextStyle(
                                      color: Colors.white60,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  onSubmitted: (value) async {
                                    if (value.trim() == "") {
                                      await _addUserData(
                                          translation_keys.guest.tr);
                                    } else {
                                      await _addUserData(value.trim());
                                    }
                                    Get.toNamed("/pref");
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (controller.text.trim() == "") {
                                    await _addUserData(
                                        translation_keys.guest.tr);
                                  } else {
                                    await _addUserData(controller.text.trim());
                                  }
                                  Get.toNamed("/pref");
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.0,
                                        offset: Offset(0.0, 3.0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      translation_keys.getStarted.tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                child: Text(
                                  '${translation_keys.disclaimer.tr} ${translation_keys.disclaimerText.tr}',
                                  style: TextStyle(
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
