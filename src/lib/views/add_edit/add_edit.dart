import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:src/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/models/photo.dart';
import 'package:image_picker/image_picker.dart';

typedef OnSaveCallback = Function(String title, String photoUrl, String userId);

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

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title;
  String _photoUrl;
  File _imageFile;
  final picker = ImagePicker();
  Future pickImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedImage.path);
    });
  }

  bool get isEditing => widget.isEditing;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit' : 'Add'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 30),
                child: ClipRRect(
                    child: _imageFile != null
                        ? Image.file(_imageFile)
                        : FlatButton(
                            onPressed: pickImage,
                            child: Icon(Icons.add_a_photo))),
                width: 200,
                height: 200,
              ),
              Visibility(child: FlatButton(onPressed: pickImage,  child: Text('Change Image'), ),visible: _imageFile != null ? true: false),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Title"
                ),
                initialValue: isEditing ? widget.photo.title : '',
                autofocus: !isEditing,
                style: textTheme.headline5,
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter some text' : null;
                },
                onSaved: (value) => _title = value,
                
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Description"
                ),
                initialValue: isEditing ? widget.photo.photoUrl : '',
                style: textTheme.subtitle1,
                onSaved: (value) => _photoUrl = value,
              ),
              
              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'Save changes' : 'Add Photo',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_title, _photoUrl, user.id);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
