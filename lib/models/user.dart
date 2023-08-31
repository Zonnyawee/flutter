// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    int? id;
    String? fullname;
    String? email;
    String? password;
    String? gender;

    User({
        this.id,
        this.fullname,
        this.email,
        this.password,
        this.gender,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "password": password,
        "gender": gender,
    };
}
