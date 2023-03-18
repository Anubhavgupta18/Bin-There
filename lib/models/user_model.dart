// To parse this JSON data, do
//
//     final user = userFromJson(jsonString?);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String? userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.message,
    this.token,
    this.user,
  });

  String? message;
  String? token;
  UserClass? user;

  factory User.fromJson(Map<String?, dynamic> json) => User(
        message: json["message"],
        token: json["token"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String?, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user?.toJson(),
      };
}

class UserClass {
  UserClass({
    this.name,
    this.email,
    this.address,
    this.id,
    this.isVerified,
  });

  String? name;
  String? email;
  Address? address;
  String? id;
  bool? isVerified;

  factory UserClass.fromJson(Map<String?, dynamic> json) => UserClass(
        name: json["name"],
        email: json["email"],
        address: Address.fromJson(json["address"]),
        id: json["_id"],
        isVerified: json["isVerified"],
      );

  Map<String?, dynamic> toJson() => {
        "name": name,
        "email": email,
        "address": address?.toJson(),
        "_id": id,
        "isVerified": isVerified,
      };
}

class Address {
  Address({
    this.city,
    this.state,
    this.pincode,
    this.flatNo,
    this.street,
    this.lat,
    this.lon,
  });

  String? city;
  String? state;
  String? pincode;
  String? flatNo;
  String? street;
  String? lat;
  String? lon;

  factory Address.fromJson(Map<String?, dynamic> json) => Address(
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        flatNo: json["flatNo"],
        street: json["street"],
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String?, dynamic> toJson() => {
        "city": city,
        "state": state,
        "pincode": pincode,
        "flatNo": flatNo,
        "street": street,
        "lat": lat,
        "lon": lon,
      };
}
