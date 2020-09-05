import 'dart:io';

import 'package:camel_up/models/profile.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class UserRepo {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loginUser(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createNewUser(Profile profile) {
    return _firebaseAuth
        .createUserWithEmailAndPassword(
            email: profile.email, password: profile.password).catchError((error)=> throw error)
        .then((value) {
      _firestore.collection("users").add(profile.toMap()).catchError((error)=> throw error);
    });
  }

  Future<void> logoutUser() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<void> updateUserAbout({String about}) async{
    final String email = (_firebaseAuth.currentUser.email);
    final snapshot = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    final doc = snapshot.docs[0];
    await doc.reference.set({"about" : about}, SetOptions(merge: true));
  }

  Future<void> updateUserProfilePic() async{
    final String email = _firebaseAuth.currentUser.email;
    final String currentUserId = _firebaseAuth.currentUser.uid;
    final snapshot = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    final doc = snapshot.docs[0];
    
    final pickedFile = await chooseImageFromGallery();
    final file = File(pickedFile.path);
    final storageReference = FirebaseStorage.instance.ref().child("profile_images/$currentUserId/${basename(pickedFile.path)}");
    final uploadtask = storageReference.putFile(file);
    await uploadtask.onComplete;
    final downloadUrl = await storageReference.getDownloadURL();
    doc.reference.set({"profileImage" : downloadUrl.toString()}, SetOptions(merge: true));
  }

   Future<void> updateUserOnlineStatus({String status}) async{
    String email = _firebaseAuth.currentUser.email;
    final snapshot = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    final doc = snapshot.docs[0];
    await doc.reference.set({"onlineStatus" : status}, SetOptions(merge: true));
  }

  Future<Profile> getCurrentUserProfile() async {
    String email = _firebaseAuth.currentUser.email;
    final snapshot = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    final doc = snapshot.docs[0];
    return Profile.fromMap(doc.data());
  }

  Stream<QuerySnapshot> getUserAsStream(String email) {
    return _firestore.collection("users")
                     .where("email", isEqualTo: email)
                     .snapshots();
  }

  Future<User> getCurrentUser() async{
    try{
      return _firebaseAuth.currentUser; 
    }catch(error){
      throw error;
    }
  }

  Future<Profile> getUserProfile(String email) async {
    try{
      final future = await _firestore.collection("users").where("email", isEqualTo: email).get();
      final profile = future.docs.map((snapshot) => Profile.fromMap(snapshot.data())).toList()[0];
      return profile;
    }catch(error){
      throw error;
    }
        
  }

  Future<QuerySnapshot> getUserProfileSnapshot(String email) async {

    try{
      return _firestore.collection("users")
        .where("email", isEqualTo: email)
        .get();  
    }catch(error){
      throw error;
    }
        
  }

  // Future<List<Profile>> getUsersFromList(List<String> emails){
  //   emails.forEach((element) { })
  // }

  Future<QuerySnapshot> getUserProfiles(){
    return _firestore.collection("users").getDocuments();
  }

  Future<String> getCurrentUserEmail() async {
    return _firebaseAuth.currentUser.email;
  }
}
