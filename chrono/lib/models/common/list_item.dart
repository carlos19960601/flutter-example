import 'package:chrono/models/common/json.dart';

abstract class ListItem extends JsonSerializable {
  int get id;
}

abstract class CustomizableListItem extends ListItem {
  
}
