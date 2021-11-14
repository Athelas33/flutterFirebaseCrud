import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String creationData;

  UserModel({this.uid, this.name, this.email, this.creationData});

  /*  static final UserModel _dbHelper = UserModel._internal();

  UserModel._internal();

  factory UserModel() => _dbHelper; */
  UserModel.fromFireStore(DocumentSnapshot document)
      : uid = document.id,
        name = document['name'],
        email = document['email'],
        creationData = document['creationData'];
}
