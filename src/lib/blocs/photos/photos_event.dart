part of 'photos_bloc.dart';

@immutable
abstract class PhotosEvent extends Equatable {
  const PhotosEvent();

  @override
  List<Object> get props => [];
}

class LoadPhotos extends PhotosEvent {
  
}

class AddPhoto extends PhotosEvent {
  final Photo photo;

  const AddPhoto(this.photo);

  @override
  List<Object> get props => [photo];

}

class UpdatePhoto extends PhotosEvent {
  final Photo photo;

  const UpdatePhoto(this.photo);

  @override
  List<Object> get props => [photo];

}

class DeletePhoto extends PhotosEvent {
  final Photo photo;

  const DeletePhoto(this.photo);

  @override
  List<Object> get props => [photo];

}

class PhotosUpdated extends PhotosEvent {
  final List<Photo> photos;

  const PhotosUpdated(this.photos);
  
  @override
  List<Object> get props => [photos];

}