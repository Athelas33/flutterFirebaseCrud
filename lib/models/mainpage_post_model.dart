import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MainPost {
  final String id;
  final String icon;
  final String image;
  final String title;
  final String content;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  MainPost(
      {this.id,
      this.title,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.icon,
      this.image});

  MainPost.fromFireStore(DocumentSnapshot document)
      : id = document.id,
        icon = document['icon'],
        title = document['title'],
        content = document['content'],
        createdAt = document['createdAt'],
        updatedAt = document['updatedAt'],
        image = document['image'];
}

class DescpPosts {
  final String id;
  final Icon icon;
  final String maintitle;
  final String description;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  DescpPosts(
      {this.id,
      this.maintitle,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.icon});

  DescpPosts.fromFireStore(DocumentSnapshot document)
      : id = document.id,
        icon = document['icon'],
        maintitle = document['maintitle'],
        description = document['description'],
        createdAt = document['createdAt'],
        updatedAt = document['updatedAt'];
}
