class UserModel {
  String _name, _profilePic;

  UserModel(this._name, this._profilePic);

  String get name => _name;

  get profilePic => _profilePic;
}

List<UserModel> userCards = [
  UserModel("Anna", "assets/images/users/anna.jpeg"),
  UserModel("Gillian", "assets/images/users/gillian.jpeg"),
  UserModel("Judith", "assets/images/users/judith.jpeg"),
];
