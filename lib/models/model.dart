import 'dart:convert';

class AuthModel {
  String? uid;
  String? email;
  String? phoneNumber;

  AuthModel({
    this.uid,
    this.email,
    this.phoneNumber,
  });
  AuthModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = <String, dynamic>{};
    user['uid'] = uid;
    user['email'] = email;
    user['phoneNumber'] = phoneNumber;

    return user;
  }
}

// ! profile model => address
class AddressModel {
  final String streetName;
  final String buildingName;
  final String cityName;

  AddressModel(
      {required this.streetName,
      required this.buildingName,
      required this.cityName});

  Map<String, dynamic> toMap() {
    return {
      'streetName': streetName,
      'buildingName': buildingName,
      'cityName': cityName,
    };
  }

  AddressModel.fromMap(Map<String, dynamic> addressMap)
      : streetName = addressMap["streetName"],
        buildingName = addressMap["buildingName"],
        cityName = addressMap["cityName"];
}

// ! profile model => user data
class UserModel {
  String? name;
  String? username;
  String? bio;
  String? dob;
  String? gender;

  String? profilePic;
  AddressModel? address;
  DateTime? lastActive;
  bool? online;

  UserModel({
    this.address,
    this.name,
    this.username,
    this.bio,
    this.dob,
    this.gender,
    this.profilePic,
    this.lastActive,
    this.online = false,
  });

  UserModel.fromMap(Map<String, dynamic> json, this.address) {
    name = json['name'];
    username = json['username'];
    bio = json['bio'];

    dob = json['dob'];
    gender = json['gender'];
    profilePic = json['profilePic'];
    address = AddressModel.fromMap(json['address']);
    online = json['online'];
    lastActive = json['lastActive'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> user = <String, dynamic>{};
    user['name'] = name;
    user['username'] = username;
    user['bio'] = bio;

    user['dob'] = dob;
    user['gender'] = gender;
    user['profilePic'] = profilePic;
    user[jsonEncode(address?.toMap())] = address;
    user['online'] = online;
    user['lastActive'] = lastActive;

    return user;
  }
}
