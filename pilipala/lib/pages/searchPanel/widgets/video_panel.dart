import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/widgets/video_card_h.dart';
import 'package:pilipala/models/common/search_type.dart';
import 'package:pilipala/pages/searchPanel/controller.dart';

class SearchVideoPanel extends StatelessWidget {
  SearchVideoPanel({super.key, this.ctr, this.list});

  final SearchPanelController? ctr;
  final List? list;

  final VideoPanelController controller = Get.put(VideoPanelController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 36),
          child: ListView.builder(
            controller: ctr!.scrollController,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemCount: list!.length,
            itemBuilder: (context, index) {
              var i = list![index];
              return Padding(
                padding: index == 0
                    ? const EdgeInsets.only(top: 2)
                    : EdgeInsets.zero,
                child: VideoCardH(videoItem: i),
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          height: 36,
          padding: const EdgeInsets.only(left: 8, top: 0, right: 12),
          child: Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() => Wrap(
                      children: [
                        for (var i in controller.filterList) ...[
                          CustomFilterChip(
                            label: i['label'],
                            type: i['type'],
                            selectedType: controller.selectedType.value,
                            callFn: (bool selected) async {
                              controller.selectedType.value = i['type'];
                              ctr!.order.value =
                                  i['type'].toString().split('.').last;
                              SmartDialog.showLoading(msg: 'loooad');
                              await ctr!.onRefresh();
                              SmartDialog.dismiss();
                            },
                          ),
                        ]
                      ],
                    )),
              )),
              const VerticalDivider(indent: 7, endIndent: 8),
              const SizedBox(width: 3),
              SizedBox(
                width: 32,
                height: 32,
                child: IconButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_list_outlined,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomFilterChip extends StatelessWidget {
  const CustomFilterChip({
    super.key,
    this.label,
    this.type,
    this.selectedType,
    this.callFn,
  });

  final String? label;
  final ArchiveFilterType? type;
  final ArchiveFilterType? selectedType;
  final Function? callFn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: FilterChip(
        padding: const EdgeInsets.only(left: 11, right: 11),
        labelPadding: EdgeInsets.zero,
        label: Text(
          label!,
          style: const TextStyle(fontSize: 13),
        ),
        labelStyle: TextStyle(
            color: type == selectedType
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline),
        selected: type == selectedType,
        showCheckmark: false,
        onSelected: (bool selected) => callFn!(selected),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide.none,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class VideoPanelController extends GetxController {
  RxList<Map> filterList = [{}].obs;
  Rx<ArchiveFilterType> selectedType = ArchiveFilterType.values.first.obs;

  @override
  void onInit() {
    super.onInit();
    List<Map<String, dynamic>> list = ArchiveFilterType.values
        .map((type) => {
              'label': type.description,
              'type': type,
            })
        .toList();
    filterList.value = list;
  }
}
