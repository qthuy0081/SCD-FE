import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final String title;
  final String id;
  final String descript;
  final String userId;
  final String photoUrl;
  final double benignRate;
  final double malignantRate;

  PhotoEntity(this.title, this.id, this.descript, this.userId, this.photoUrl, this.benignRate, this.malignantRate);
  @override
  List<Object> get props => [title, id, descript, userId, photoUrl];

  PhotoEntity.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        descript = data['descript'],
        userId = data['userId'],
        photoUrl = data['photoUrl'],
        benignRate = data['benignRate'],
        malignantRate = data['malignantRate'];

  PhotoEntity.fromSnapShot(DocumentSnapshot snap)
      : title = snap.data()['title'],
        id = snap.id,
        descript = snap.data()['descript'],
        userId = snap.data()['userId'],
        photoUrl = snap.data()['photoUrl'],
        benignRate = snap.data()['benignRate'],
        malignantRate = snap.data()['malignantRate'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'descript': descript,
      'userId': userId,
      'photoUrl': photoUrl,
      'benignRate': benignRate,
      'malignantRate': malignantRate
    };
  }
}
