part of 'photos_bloc.dart';

@immutable
abstract class PhotosState extends Equatable {
  const PhotosState();
  @override
  List<Object> get props => [];
}

class PhotosLoading extends PhotosState {}

class PhotosLoaded extends PhotosState {
  final List<Photo> photos;

  const PhotosLoaded([this.photos = const []]);

  @override
  List<Object> get props => [photos];
}

class PhotoNotLoaded extends PhotosState {}
