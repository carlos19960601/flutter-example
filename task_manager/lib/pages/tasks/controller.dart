import 'package:get/get.dart';
import 'package:task_manager/common/models/task_model.dart';

class TasksController extends GetxController {
   RxList<TaskModel> tasks = RxList.empty();
}
