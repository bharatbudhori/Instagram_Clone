import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          email: email,
          username: username,
          bio: bio,
          photoUrl: photoUrl,
          uid: cred.user!.uid,
          followers: [],
          following: [],
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        /*await _firestore.collection('users').add({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
        });
        */

        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      //print(e.message);
      if (e.code == 'invalid-email') {
        res = 'Invalid email';
      } else if (e.code == 'weak-password') {
        res = 'Weak password';
      } else if (e.code == 'email-already-in-use') {
        res = 'Email already in use';
      } else if (e.code == 'user-not-found') {
        res = 'User not found';
      } else if (e.code == 'user-disabled') {
        res = 'User disabled';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password';
      } else {
        res = 'Some error occured';
      }
    } catch (err) {
      print(err.toString());
    }
    return res;
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      //print(e.message);
      if (e.code == 'invalid-email') {
        res = 'Invalid email';
      } else if (e.code == 'user-not-found') {
        res = 'User not found';
      } else if (e.code == 'user-disabled') {
        res = 'User disabled';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password';
      } else {
        res = 'Some error occured';
      }
    } catch (err) {
      print(err.toString());
    }
    return res;
  }
}
