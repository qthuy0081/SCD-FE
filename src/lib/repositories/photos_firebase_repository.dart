import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:src/models/photo.dart';
import 'package:src/models/photo_entity.dart';
import 'package:src/repositories/photos_repository.dart';

class PhotoFirebaseRepository implements PhotoRepository {
  final photoCollection = FirebaseFirestore.instance.collection('photos');
  @override
  Future<void> addNewPhoto(Photo photo) {
    // TODO: implement addNewPhoto
    return photoCollection.add(photo.toEntity().toJson());
  }

  @override
  Future<void> deletePhoto(Photo photo) async {
    // TODO: implement deletePhotos
    return photoCollection.doc(photo.id).delete();
  }

  @override
  Stream<List<Photo>> photos() {
    // TODO: implement photos
    return photoCollection.snapshots().map((snap) {
      return snap.docs
          .map((e) => Photo.fromEntity(PhotoEntity.fromSnapShot(e)))
          .toList();
    });
  }

  @override
  Future<void> updatePhoto(Photo photo) {
    // TODO: implement updatePhotos
    return photoCollection.doc(photo.id).update(photo.toEntity().toJson());
  }
}
