class UserModel {
  String uid;
  String name;
  String email;
  String creationData;

  UserModel({this.uid, this.name, this.email, this.creationData});

  /*  static final UserModel _dbHelper = UserModel._internal();

  UserModel._internal();

  factory UserModel() => _dbHelper; */
}
