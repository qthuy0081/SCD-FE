import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:src/models/photo.dart';
import 'package:src/repositories/photos_repository.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotoRepository _photoRepository;
  StreamSubscription _photoSubscription;

  PhotosBloc({@required PhotoRepository photoRepository})
      :assert(photoRepository != null) ,_photoRepository = photoRepository,
        super(PhotosLoading());

  @override
  Stream<PhotosState> mapEventToState(
    PhotosEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadPhotos) {
      yield* _mapLoadPhotosToState();
    } else if (event is AddPhoto) {
      yield* _mapAddPhotoToState(event);
    } else if (event is UpdatePhoto) {
      yield* _mapUpdatePhotoToState(event);
    } else if (event is DeletePhoto) {
      yield* _mapDeletePhotoToState(event);
    } else if (event is PhotosUpdated) {
      yield* _mapPhotosUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _photoSubscription?.cancel();
    return super.close();
  }

  Stream<PhotosState> _mapLoadPhotosToState() async* {
    _photoSubscription?.cancel();
    _photoSubscription = _photoRepository
        .photos()
        .listen((photos) => add(PhotosUpdated(photos)));
  }

  Stream<PhotosState> _mapAddPhotoToState(AddPhoto event) async* {
    _photoRepository.addNewPhoto(event.photo);
  }

  Stream<PhotosState> _mapUpdatePhotoToState(UpdatePhoto event) async* {
    _photoRepository.updatePhoto(event.photo);
  }

  Stream<PhotosState> _mapDeletePhotoToState(DeletePhoto event) async* {
    _photoRepository.deletePhoto(event.photo);
  }

  Stream<PhotosState> _mapPhotosUpdatedToState(PhotosUpdated event) async* {
    yield PhotosLoaded(event.photos);
  }
}
