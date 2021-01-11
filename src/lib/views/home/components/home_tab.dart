import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/blocs/photos/photos_bloc.dart';
import 'package:src/models/models.dart';
import 'package:src/views/details/details_page.dart';
import 'package:src/views/home/components/photo_item.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(builder: (context, state) {
      if (state is PhotosLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PhotosLoaded) {
        final photos = state.photos;
        return ListView.builder(
          itemCount: photos.length,
          itemBuilder: (context, index) {
            final photo = photos[index];
            return PhotoItem(
                onDismissed: (direction) {
                  BlocProvider.of<PhotosBloc>(context).add(DeletePhoto(photo));
                  Scaffold.of(context).showSnackBar(DeleteSnackBar(
                      photo: photo,
                      onUnDo: () => BlocProvider.of<PhotosBloc>(context)
                          .add(AddPhoto(photo))));
                },
                onTap: () async {
                  final remmovedPhoto = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return DetailsPage(id: photo.id);
                  }));
                  if (remmovedPhoto != null) {
                    Scaffold.of(context).showSnackBar(DeleteSnackBar(
                        photo: photo,
                        onUnDo: () => BlocProvider.of<PhotosBloc>(context)
                            .add(AddPhoto(photo))));
                  }
                },
                photo: photo);
          },
        );
      } else {
        return Container();
      }
    });
  }
}

class DeleteSnackBar extends SnackBar {
  DeleteSnackBar(
      {Key key, @required Photo photo, @required VoidCallback onUnDo})
      : super(
            key: key,
            content: Text(
              'Delete ${photo.title}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            duration: Duration(seconds: 3),
            action: SnackBarAction(label: 'Undo', onPressed: onUnDo));
}
