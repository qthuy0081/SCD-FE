import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/blocs/photos/photos_bloc.dart';
import 'package:src/views/add_edit/add_edit.dart';

class DetailsPage extends StatelessWidget {
  final String id;
  const DetailsPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        final photo = (state as PhotosLoaded)
            .photos
            .firstWhere((element) => element.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Details'),
            actions: [
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    BlocProvider.of<PhotosBloc>(context)
                        .add(DeletePhoto(photo));
                    Navigator.pop(context);
                  })
            ],
          ),
          body: photo == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Hero(
                                tag: '${photo.id}__heroTag',
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 16.0,
                                  ),
                                  child: Text(
                                    photo.title,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                              Text(photo.photoUrl,
                                  style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ))
                        ],
                      )
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: photo == null
                ? null
                : () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddEditScreen(
                        onSave: (title, photoUrl, userId) {
                          BlocProvider.of<PhotosBloc>(context).add(UpdatePhoto(
                              photo.copyWith(
                                  title: title, photoUrl: photoUrl,userId: userId)));
                        },
                        isEditing: true,
                        photo: photo,
                      );
                    }));
                  },
          ),
        );
      },
    );
  }
}
