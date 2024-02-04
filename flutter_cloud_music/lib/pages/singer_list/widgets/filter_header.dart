import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
import 'package:flutter_cloud_music/pages/singer_list/controller.dart';
import 'package:flutter_cloud_music/pages/singer_list/state.dart';
import 'package:get/get.dart';

class FilterHeader extends StatefulWidget {
  const FilterHeader({super.key});

  @override
  State<FilterHeader> createState() => _FilterHeaderState();
}

class _FilterHeaderState extends State<FilterHeader> {
  double offset = 0.0;
  late Animation<double> animation;
  late SingerListState state;

  @override
  void initState() {
    super.initState();
    state = Get.find<SingerListController>().singerListState;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85 - 45 * offset,
      color: Get.theme.cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Visibility(
            visible: offset != 1,
            child: Opacity(
              opacity: 1.0 - offset,
              child: _buildExpanded(),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Visibility(
              visible: offset > 0,
              child: Opacity(
                opacity: offset,
                child: _buildPackUp(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpanded() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 20,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final type = state.listArea.elementAt(index);
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      state.area.value = type;
                    },
                    child: Text(
                      type.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: state.area.value.id == type.id
                            ? AppColors.appMainLight
                            : body1Style().color,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 28);
              },
              itemCount: state.listArea.length,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 20,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final type = state.listType.elementAt(index);
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        state.type.value = type;
                      },
                      child: Text(
                        type.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: state.type.value.id == type.id
                              ? AppColors.appMainLight
                              : body1Style().color,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 28);
                },
                itemCount: state.listType.length),
          ),
        ],
      ),
    );
  }

  ///收起时的widget
  Widget _buildPackUp() {
    return const SizedBox(
      height: 40,
      child: Row(
        children: [],
      ),
    );
  }
}
