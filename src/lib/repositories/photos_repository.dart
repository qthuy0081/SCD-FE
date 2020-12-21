import 'dart:async';
import 'package:src/models/photo.dart';

abstract class PhotoRepository {
  Future<void> addNewPhoto(Photo photo);

  Future<void> deletePhoto(Photo photo);

  Stream<List<Photo>> photos();

  Future<void> updatePhoto(Photo photo);
}
