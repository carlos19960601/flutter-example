import 'dart:developer';

import 'package:apidash/consts.dart';
import 'package:apidash/models/request_model.dart';
import 'package:apidash/utils/storage.dart';
import 'package:apidash/utils/uuid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CollectionController extends GetxController {
  Box dataBox = GStorage.data;
  RxList<String> ids = <String>[].obs;
  RxMap<String, RequestModel?> requestItems = <String, RequestModel>{}.obs;
  RxString activeId = "".obs;
  RxString sentRequestId = "".obs;
  RxString editRequestId = "".obs;
  FocusNode nameTextFieldFocusNode = FocusNode();
  RxBool savingData = false.obs;
  // activeRequestModel is "reactive", 但是内部的属性不是
  Rxn<RequestModel> activeRequestModel = Rxn<RequestModel>();
  RxBool codePaneVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    List<String> boxIds = dataBox.get(DataBoxKey.ids, defaultValue: <String>[]);
    for (String id in boxIds) {
      var jsonModel = dataBox.get(id);
      if (jsonModel != null) {
        RequestModel requestModel =
            RequestModel.fromJson(Map<String, dynamic>.from(jsonModel));
        requestItems.putIfAbsent(id, () => requestModel);
      }
    }

    ids.value = boxIds;
  }

  setActiveId(String id) {
    activeId.value = id;
    activeRequestModel.value = requestItems[id]!;
  }

  renameActiveRequest(String name) {
    activeRequestModel.value!.name = name;
    requestItems[activeId.value] = activeRequestModel.value!;
    activeRequestModel.refresh();
  }

  updateActiveRequest(String name, String url, HTTPVerb method) {
    log("${activeRequestModel.value?.name}");
  }

  updateRequest(String id, {HTTPVerb? method, String? url}) {
    RequestModel newModel = requestItems[id]!.copyWith(
      method: method,
      url: url,
    );
    if (activeId.value == id) {
      activeRequestModel.value = newModel;
    }

    requestItems[id] = newModel;
  }

  updateRequestTabIndex(int index) {
    activeRequestModel.value!.requestTabIndex = index;
    activeRequestModel.refresh();
  }

  add() {
    final id = UUID.v1();
    ids.add(id);

    final newRequestModel = RequestModel(id: id);
    requestItems.putIfAbsent(id, () => newRequestModel);

    activeId.value = id;
  }

  remove(String id) {
    int idx = ids.indexOf(id);
    ids.remove(id);

    String newId;
    if (idx == 0 && ids.isNotEmpty) {
      newId = ids[0];
    } else if (ids.length > 1) {
      newId = ids[idx - 1];
    } else {
      newId = "";
    }

    activeId.value = newId;
    requestItems.remove(id);
  }

  Future<void> saveData() async {
    savingData.value = true;
    dataBox.put(DataBoxKey.ids, ids);
    for (String id in ids) {
      dataBox.put(id, requestItems[id]!.toJson());
    }
    savingData.value = false;
  }

  reorder(int oldIndex, int newIndex) {
    var itemId = ids.removeAt(oldIndex);
    ids.insert(newIndex, itemId);
  }

  sendRequest() {
    sentRequestId.value = activeId.value;
    codePaneVisible.value = false;
  }
}
