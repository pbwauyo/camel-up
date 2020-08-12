import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Profile extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String profileImage;

  Profile(
      {@required this.email,
      @required this.password,
      @required this.firstName,
      @required this.lastName,
      @required this.profileImage});

  @override
  List<Object> get props => [
        email,
      ];

  Map<String, String> toMap() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "profileImage": profileImage
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
        email: map["email"],
        password: map["password"],
        firstName: map["firstName"],
        lastName: map["lastName"],
        profileImage: map["profileImage"]);
  }
}
