import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:src/models/user_model.dart';



class UserFireStoreServices {
  final CollectionReference _userCollectionReference = FirebaseFirestore.instance.collection('users');
  
  Future createUser (UserModel user) async {
    try {
        return _userCollectionReference.doc(user.id).set(user.toJson());
    } catch(e){
      return e.toString();
    }
  }

  Future<UserModel> getUser (String uid) async {
    try {
      var userData = await _userCollectionReference.doc(uid).get();
      return UserModel.fromData(userData.data());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}