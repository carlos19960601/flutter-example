class ListController<T> {
  List<T> Function()? _getItems;
  void Function(T item)? _addItem;

  ListController();

  setGetItems(List<T> Function() callback) {
    _getItems = callback;
  }

  void setAddItem(void Function(T item) callback) {
    _addItem = callback;
  }

  List<T> getItems() => _getItems?.call() ?? [];

  void addItem(T item) {
    _addItem?.call(item);
  }
}
