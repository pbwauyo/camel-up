import 'package:camel_up/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tests {
  static final _firestore = Firestore.instance;
  static final _profiles = [
    Profile(email: "pbwauyo@gmail.com", password: "", firstName: "Wauyo", lastName: "Peter"),
    Profile(email: "pbwauyo@gmail.com", password: "", firstName: "Wauyo", lastName: "Peter"),
    Profile(email: "pbwauyo@gmail.com", password: "", firstName: "Wauyo", lastName: "Peter"),
    Profile(email: "pbwauyo@gmail.com", password: "", firstName: "Wauyo", lastName: "Peter"),
    Profile(email: "pbwauyo@gmail.com", password: "", firstName: "Wauyo", lastName: "Peter")
  ];
  static uploadMockProfiles(){
    _profiles.forEach((profile) {
        _firestore.collection("users").add(profile.toMap());
     });
  }
}