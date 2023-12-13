import 'package:apidash/models/request_model.dart';
import 'package:apidash/utils/uuid.dart';
import 'package:get/get.dart';

class CollectionController extends GetxController {
  RxList<String> ids = <String>[].obs;
  RxMap<String, RequestModel> requestItems = <String, RequestModel>{}.obs;
  RxString activeId = "".obs;
  RxString editRequestId = "".obs;

  addCollection() {
    final id = UUID.v1();
    ids.add(id);

    final newRequestModel = RequestModel(id: id);
    requestItems.putIfAbsent(id, () => newRequestModel);

    activeId.value = id;
  }
}
