import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/models/mainpage_post_model.dart';
import 'package:flutterfirebasecrud/models/post_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Future registerUser(String uid, String email, String name) async {
    try {
      return await collection.doc(uid).set({
        "email": email,
        "name": name,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp()
      });
    } catch (e) {
      print("Hata oluştu" + e.toString());
    }
  }

  Future createPost(String uid, String title, String content) async {
    try {
      await collection.doc(uid).collection('posts').doc().set({
        "title": title,
        "content": content,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });
      Get.rawSnackbar(
          title: "Başarılı",
          message: "Post kaydı başarılı bir şekilde oluşturuldu.",
          icon: Icon(Icons.check, color: Colors.greenAccent));

      return uid;
    } catch (e) {
      Get.rawSnackbar(
          icon: Icon(
            Icons.remove,
            color: Colors.redAccent,
          ),
          title: "Hata",
          message: e.toString());
    }
  }

  List<MainPost> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MainPost.fromFireStore(doc);
    }).toList();
  }

  // get all posts
  Stream<List<MainPost>> get posts {
    return FirebaseFirestore.instance
        .collectionGroup('users')
        .snapshots()
        .map(_postListFromSnapshot);
  }

  // get individual user posts
  /*  Stream<List<Post>> get individualPosts {
    return collection
        .document(uid)
        .collection('posts')
        .snapshots()
        .map(_postListFromSnapshot);
  } */

}
