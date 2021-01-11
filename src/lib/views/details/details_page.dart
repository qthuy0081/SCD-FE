import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/blocs/photos/photos_bloc.dart';
import 'package:src/views/add_edit/add_edit.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailsPage extends StatelessWidget {
  final String id;
  const DetailsPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        double percent = 0;
        final photo = (state as PhotosLoaded)
            .photos
            .firstWhere((element) => element.id == id, orElse: () => null);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: orange,
            elevation: 0.0,
            bottomOpacity: 0.0,
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
                                FadeInImage.assetNetwork(
                                  image: photo.photoUrl,
                                  placeholder: 'assets/loading.gif',
                                ),
                                // Text(photo.descript,
                                //     style: Theme.of(context).textTheme.subtitle1),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        new CircularPercentIndicator(
                                          radius: 130.0,
                                          animation: true,
                                          animationDuration: 1200,
                                          lineWidth: 15.0,
                                          percent: photo.malignantRate / 100,
                                          center: new Text(
                                            '${photo.malignantRate.toStringAsFixed(1)}',
                                            style: new TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          ),
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          backgroundColor: Colors.green[600],
                                          progressColor: Colors.red[700],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            new LinearPercentIndicator(
                                              width: 60.0,
                                              lineHeight: 8.0,
                                              percent: 1,
                                              trailing: const Text('benign'),
                                              progressColor: Colors.green[600],
                                            ),
                                            new LinearPercentIndicator(
                                              width: 60.0,
                                              lineHeight: 8.0,
                                              percent: 1,
                                              trailing: const Text('malignant'),
                                              progressColor: Colors.red[700],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
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
                        onSave: (title, descript, userId, photoUrl, bel, mal) {
                          BlocProvider.of<PhotosBloc>(context)
                              .add(UpdatePhoto(photo.copyWith(
                            title: title,
                            descript: descript,
                            benignRate: bel,
                            malignantRate: mal,
                          )));
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
