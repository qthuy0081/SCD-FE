import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final String title;
  final String id;
  final String photoUrl;
  final String userId;

  PhotoEntity(this.title, this.id, this.photoUrl, this.userId);
  @override
  List<Object> get props => [title, id, photoUrl, userId];

  PhotoEntity.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        photoUrl = data['photoUrl'],
        userId = data['userId'];

  PhotoEntity.fromSnapShot(DocumentSnapshot snap)
      : title = snap.data()['title'],
        id = snap.id,
        photoUrl = snap.data()['photoUrl'],
        userId = snap.data()['userId'];

  Map<String, dynamic> toJson() {
    return {'title': title, 'photoUrl': photoUrl, 'userId': userId};
  }
}
