// To parse this JSON data, do
//
//     final allReports = allReportsFromJson(jsonString);

import 'dart:convert';

List<AllReports> allReportsFromJson(String str) => List<AllReports>.from(json.decode(str).map((x) => AllReports.fromJson(x)));

String allReportsToJson(List<AllReports> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllReports {
    AllReports({
        this.image,
        this.id,
        this.user,
        this.description,
        this.lat,
        this.lon,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.status,
    });

    Image? image;
    String? id;
    String? user;
    String? description;
    String? lat;
    String? lon;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? status;

    factory AllReports.fromJson(Map<String, dynamic> json) => AllReports(
        image: Image.fromJson(json["image"]),
        id: json["_id"],
        user: json["user"],
        description: json["description"],
        lat: json["lat"],
        lon: json["lon"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "image": image?.toJson(),
        "_id": id,
        "user": user,
        "description": description,
        "lat": lat,
        "lon": lon,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "status": status,
    };
}

class Image {
    Image({
        this.url,
        this.publicId,
    });

    String? url;
    String? publicId;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
        publicId: json["public_id"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "public_id": publicId,
    };
}
