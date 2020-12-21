import 'package:src/models/photo_entity.dart';

class Photo {
  final String title;
  final String id;
  final String photoUrl;
  final String userId;

  Photo(this.title, {String id, this.photoUrl, this.userId}): this.id = id;

  Photo copyWith({String title, String id, String photoUrl, String userId}) {
    return Photo(
        title ?? this.title,
        id: id ?? this.id,
        photoUrl: photoUrl ?? this.photoUrl,
        userId: userId ?? this.userId);
  }

  @override
  // TODO: implement hashCode
  int get hashCode => title.hashCode ^ id.hashCode ^ photoUrl.hashCode ^ userId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Photo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          photoUrl == other.photoUrl &&
          userId == other.userId;
  PhotoEntity toEntity() {
    return PhotoEntity(title, id, photoUrl, userId);
  }

  Photo.fromEntity(PhotoEntity entity)
      : title = entity.title,
        id = entity.id,
        photoUrl = entity.photoUrl,
        userId = entity.userId;

  @override
  String toString() {
    // TODO: implement toString
    return 'Photo:{id: $id, title: $title }';
  }
  
}
