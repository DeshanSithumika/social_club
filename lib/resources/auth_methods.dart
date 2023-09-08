import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_club/models/user.dart' as model;
import 'package:social_club/resources/storage_methods.dart';
import 'package:social_club/screens/login_screen.dart';
import 'package:social_club/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //===get users data

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(snapshot);
  }

  //==sign up user

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List? file,
      required BuildContext context}) async {
    String res = "Some error occurred";

    //====register user
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String photoUrl = await StorageMethods()
          .uploadImageToStorage("profilePics", file!, false);

      //==== add user to database

      model.User user = model.User(
        username: username,
        uid: credential.user!.uid,
        email: email,
        bio: bio,
        followers: [],
        following: [],
        photoUrl: photoUrl,
      );

      _firestore
          .collection("users")
          .doc(credential.user!.uid)
          .set(user.toJson());

      res = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Weak PAssword',
          desc: 'The password provided is too weak.........',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Wrong Email',
          desc: 'The account already exists for that email.',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

//=====login in user
  Future<String> signInUser({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) async {
    String res = "some error occured";
    try {
      if (emailAddress.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: emailAddress, password: password);
        res = "success";
      }

      //==get user data from firebase firestore
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: ' Null user',
          desc: 'No user found for that email.',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: ' wrong password ',
          desc: 'Wrong password provided for that user.',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    }
    return res;
  }

//=====sign out user
  Future<void> signOutUser(BuildContext context) async {
    await _auth.signOut();

    NavigateFunctions.navigateTo(context, LoginScreen());
  }
}
