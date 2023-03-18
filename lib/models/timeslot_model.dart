// To parse this JSON data, do
//
//     final timeSlots = timeSlotsFromJson(jsonString);

import 'dart:convert';

TimeSlots timeSlotsFromJson(String str) => TimeSlots.fromJson(json.decode(str));

String timeSlotsToJson(TimeSlots data) => json.encode(data.toJson());

class TimeSlots {
    TimeSlots({
        required this.address,
        required this.id,
        required this.name,
        required this.email,
        this.otp,
        required this.isVerified,
        required this.timeslots,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.pickupPoints,
    });

    Address address;
    String id;
    String name;
    String email;
    dynamic otp;
    bool isVerified;
    List<String> timeslots;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String pickupPoints;

    factory TimeSlots.fromJson(Map<String, dynamic> json) => TimeSlots(
        address: Address.fromJson(json["address"]),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        otp: json["otp"],
        isVerified: json["isVerified"],
        timeslots: List<String>.from(json["timeslots"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        pickupPoints: json["pickupPoints"],
    );

    Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "_id": id,
        "name": name,
        "email": email,
        "otp": otp,
        "isVerified": isVerified,
        "timeslots": List<dynamic>.from(timeslots.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "pickupPoints": pickupPoints,
    };
}

class Address {
    Address({
        required this.city,
        required this.state,
        required this.pincode,
        required this.flatNo,
        required this.street,
        required this.lat,
        required this.lon,
    });

    String city;
    String state;
    String pincode;
    String flatNo;
    String street;
    String lat;
    String lon;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        flatNo: json["flatNo"],
        street: json["street"],
        lat: json["lat"],
        lon: json["lon"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "pincode": pincode,
        "flatNo": flatNo,
        "street": street,
        "lat": lat,
        "lon": lon,
    };
}
