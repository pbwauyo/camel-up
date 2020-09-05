import 'package:camel_up/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Profile extends Equatable {
  String email;
  String password;
  String firstName;
  String lastName;
  String profileImage;
  String about;
  String onlineStatus;
  String deviceId;

  Profile(
      {@required this.email,
      @required this.password,
      @required this.firstName,
      @required this.lastName,
      this.profileImage,
      this.about,
      this.onlineStatus,
      this.deviceId});

  @override
  List<Object> get props => [
        email,
      ];

  @override
  bool get stringify => true;  

  Map<String, String> toMap() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "profileImage": profileImage ?? "",
      "about" : about ?? "",
      "onlineStatus" : onlineStatus ?? OnlineStatus.OFFLINE,
      "deviceId" : deviceId ?? ""
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
        email: map["email"],
        password: map["password"],
        firstName: map["firstName"],
        lastName: map["lastName"],
        profileImage : map["profileImage"] ?? "",
        about : map["about"] ?? "",
        onlineStatus: map["onlineStatus"] ?? OnlineStatus.OFFLINE,
        deviceId: map["deviceId"] ?? "" 
      );
  }

  reset(){
    email = "";
    password = "";
    firstName = "";
    lastName = "";
    profileImage = "";
    about = "";
    onlineStatus = "";
  }
}
