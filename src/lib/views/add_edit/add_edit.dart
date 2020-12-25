import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:src/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/models/photo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tflite/tflite.dart';

typedef OnSaveCallback = Function(String title, String descript, String userId,
    String photoUrl, double benignRate, double malignantRate);

class AddEditScreen extends StatefulWidget {
  final OnSaveCallback onSave;
  final bool isEditing;
  final Photo photo;

  AddEditScreen(
      {Key key, @required this.onSave, @required this.isEditing, this.photo})
      : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}
final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);
class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title;
  String _descript;
  File _imageFile;
  FirebaseStorage storage = FirebaseStorage.instance;
  ProgressDialog progressDialog;
  double _beConfidence = 0;
  double _maConfidence = 0;
  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  loadTfliteModel() async {
    var res = await Tflite.loadModel(
        model: 'assets/converted_tflite/model_unquant.tflite',
        labels: 'assets/converted_tflite/labels.txt');

    print('\n Load Model Result: $res');
  }

  @override
  void initState() {
    super.initState();
    loadTfliteModel();
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(path: _imageFile.path);
    setState(() {
      _beConfidence = res[0]["confidence"] * 100;
      _maConfidence = res[1]["confidence"] * 100;
    });

    print('Predict Result: $res');
  }

  bool get isEditing => widget.isEditing;
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: 'Uploading...');
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        elevation: 0.0,
        bottomOpacity: 0.0,

      ),
      body: Stack(
        children: [
          Container(
            height: 260,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [orange, orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('Choose Your Image',style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,letterSpacing: 2),),
          ),
          
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 80,),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 10.0, bottom: 30),
                    child: ClipRRect(
                        child: _imageFile != null
                            ? Image.file(_imageFile)
                            : FlatButton(
                                onPressed: pickImage,
                                child: Icon(Icons.add_a_photo))),
                    width: 200,
                    height: 200,
                  ),
                  Visibility(
                      child: FlatButton(
                        onPressed: pickImage,
                        child: Text('Change Image'),
                      ),
                      visible: _imageFile != null ? true : false),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Title"),
                    initialValue: isEditing ? widget.photo.title : '',
                    autofocus: !isEditing,
                    style: textTheme.headline5,
                    validator: (val) {
                      return val.trim().isEmpty ? 'Please enter some text' : null;
                    },
                    onSaved: (value) => _title = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Description"),
                    initialValue: isEditing ? widget.photo.descript : '',
                    style: textTheme.subtitle1,
                    onSaved: (value) => _descript = value,
                  ),
                  Visibility(
                    child: Column(
                      children: [
                        Text('Benign: ${_beConfidence.toStringAsFixed(2)}'),
                        Text('Malgnant: ${_maConfidence.toStringAsFixed(2)}'),
                        RaisedButton(
                          onPressed: () {
                            if (_imageFile != null) {
                              applyModelOnImage(_imageFile);
                            }
                          },
                          child: Text('Predict'),
                        )
                      ],
                    ),
                    visible: !isEditing,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'Save changes' : 'Add Photo',
        backgroundColor: orange,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () async {
          if (_formKey.currentState.validate() && _imageFile != null) {
            _formKey.currentState.save();
            String path = 'images/${user.id}/$_title';
            await storage.ref(path).putFile(_imageFile).then((e) {
              print('Debug firestorage: ' + e.toString());
            }).catchError((e) {
              return;
            });
            String downloadURL =
                await storage.ref(path).getDownloadURL().catchError((e) {
              return;
            });
            widget.onSave(_title, _descript, user.id, downloadURL,
                _beConfidence, _maConfidence);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
