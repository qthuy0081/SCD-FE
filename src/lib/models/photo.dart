import 'package:src/models/photo_entity.dart';

class Photo {
  final String title;
  final String id;
  final String descript;
  final String userId;
  final String photoUrl;
  final double benignRate;
  final double malignantRate;

  Photo(this.title,
      {String id,
      this.descript,
      this.userId,
      this.photoUrl,
      this.benignRate,
      this.malignantRate})
      : this.id = id;

  Photo copyWith(
      {String title,
      String id,
      String descript,
      String userId,
      String photoUrl,
      double benignRate,
      double malignantRate}) {
    return Photo(title ?? this.title,
        id: id ?? this.id,
        descript: descript ?? this.descript,
        userId: userId ?? this.userId,
        photoUrl: photoUrl ?? this.photoUrl,
        benignRate: benignRate ?? this.benignRate,
        malignantRate: malignantRate ?? this.malignantRate);
  }

  @override
  // TODO: implement hashCode
  int get hashCode =>
      title.hashCode ^ id.hashCode ^ descript.hashCode ^ userId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Photo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          descript == other.descript &&
          userId == other.userId;
  PhotoEntity toEntity() {
    return PhotoEntity(title, id, descript, userId, photoUrl,benignRate,malignantRate);
  }

  Photo.fromEntity(PhotoEntity entity)
      : title = entity.title,
        id = entity.id,
        descript = entity.descript,
        userId = entity.userId,
        photoUrl = entity.photoUrl,
        benignRate = entity.benignRate,
        malignantRate = entity.malignantRate;

  @override
  String toString() {
    // TODO: implement toString
    return 'Photo:{id: $id, title: $title }';
  }
}
