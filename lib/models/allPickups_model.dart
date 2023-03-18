// To parse this JSON data, do
//
//     final allPickups = allPickupsFromJson(jsonString);

import 'dart:convert';

List<AllPickups> allPickupsFromJson(String str) => List<AllPickups>.from(json.decode(str).map((x) => AllPickups.fromJson(x)));

String allPickupsToJson(List<AllPickups> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllPickups {
    AllPickups({
        this.id,
        this.user,
        this.timeslot,
        this.agent,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String? id;
    String? user;
    String? timeslot;
    String? agent;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory AllPickups.fromJson(Map<String?, dynamic> json) => AllPickups(
        id: json["_id"],
        user: json["user"],
        timeslot: json["timeslot"],
        agent: json["agent"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "timeslot": timeslot,
        "agent": agent,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
