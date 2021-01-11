import 'package:flutter/material.dart';
import 'package:src/models/photo.dart';

class PhotoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Photo photo;

  const PhotoItem(
      {Key key,
      @required this.onDismissed,
      @required this.onTap,
      @required this.photo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key('__photo_item_${photo.id}'),
        onDismissed: onDismissed,
        child: Card(
          child: ListTile(
            onTap: onTap,
            title: Hero(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  photo.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              tag: '${photo.id}__heroTag',
            ),
            leading: photo.benignRate > photo.malignantRate ? Icon(
              Icons.mood_rounded,
              color: Colors.green,
            ): Icon(Icons.mood_bad),
          ),
        ));
  }
}
