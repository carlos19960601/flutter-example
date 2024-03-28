import 'package:apidash/common/widgets/checkbox.dart';
import 'package:apidash/consts.dart';
import 'package:apidash/models/name_value_model.dart';
import 'package:apidash/pages/home/widgets/collection/controller.dart';
import 'package:davi/davi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditRequestURLParams extends StatefulWidget {
  const EditRequestURLParams({super.key});

  @override
  State<EditRequestURLParams> createState() => _EditRequestURLParamsState();
}

class _EditRequestURLParamsState extends State<EditRequestURLParams> {
  late List<NameValueModel> paramRows;
  late List<bool> isRowEnabledList;
  final CollectionController collectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isParamsEmpty = false;
    if (collectionController.activeRequestModel.value!.requestParams == null) {
      isParamsEmpty = true;
    } else {
      isParamsEmpty =
          collectionController.activeRequestModel.value!.requestParams!.isEmpty;
    }
    List<NameValueModel> rows = (isParamsEmpty)
        ? [
            kNameValueEmptyModel,
          ]
        : collectionController.activeRequestModel.value!.requestParams!;

    paramRows = isParamsEmpty ? rows : rows + [kNameValueEmptyModel];
    isRowEnabledList =
        collectionController.activeRequestModel.value?.isParamEnabledList ??
            List.filled(
                collectionController
                        .activeRequestModel.value?.requestParams?.length ??
                    0,
                true,
                growable: true);
    isRowEnabledList.add(false);

    DaviModel<NameValueModel> model = DaviModel<NameValueModel>(
      rows: paramRows,
      columns: [
        DaviColumn(
          name: "Checkbox",
          width: 30,
          cellBuilder: (context, row) {
            int idx = row.index;
            return CheckBox(
              value: isRowEnabledList[idx],
              onChanged: (bool? value) {},
              colorSchema: Theme.of(context).colorScheme,
            );
          },
        ),
        DaviColumn(
          name: 'URL Parameter',
          width: 30,
          cellBuilder: (context, row) {
            int idx = row.index;
            return CheckBox(
              value: isRowEnabledList[idx],
              onChanged: (bool? value) {},
              colorSchema: Theme.of(context).colorScheme,
            );
          },
        ),
      ],
    );

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            children: [
              Expanded(
                child: DaviTheme(
                  data: kTableThemeData,
                  child: Davi(model),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
