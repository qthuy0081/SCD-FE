import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:src/models/models.dart';
import 'package:src/repositories/user_firestore_services.dart';

class SignUpFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {}

class LogInWithGoogleFailure implements Exception {}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      UserFireStoreServices userFireStoreServices})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? UserModel.empty : firebaseUser.toUserModel;
    });
  }

  Future<void> signUp(
      {@required String email, @required String password}) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on User {
  UserModel get toUserModel {
    return UserModel(
      email: email,
      id: uid,
      name: displayName,
      role: 'patient',
      avatar: photoURL,
    );
  }
}
