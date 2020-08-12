import 'package:camel_up/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  Future<void> loginUser(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createNewUser(Profile profile) {
    return _firebaseAuth
        .createUserWithEmailAndPassword(
            email: profile.email, password: profile.password)
        .then((value) {
      _firestore.collection("users").add(profile.toMap());
    });
  }

  Future<void> logoutUser() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<void> getCurrentUserProfile() async {
    String email = (await _firebaseAuth.currentUser()).email;
    return _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  Future<FirebaseUser> getCurrentUser() async{
    try{
      return (await _firebaseAuth.currentUser()); 
    }catch(error){
      throw error;
    }
  }

  Future<Profile> getUserProfile(String email) async {
    try{
      final future = await _firestore.collection("users").where("email", isEqualTo: email).getDocuments();
      final profile = future.documents.map((snapshot) => Profile.fromMap(snapshot.data)).toList()[0];
      return profile;
    }catch(error){
      throw error;
    }
        
  }

  Future<String> getCurrentUserEmail() async {
    return (await _firebaseAuth.currentUser()).email;
  }
}
