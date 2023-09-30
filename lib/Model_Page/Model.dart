// class ItemModel{
//   final String name;
//   final String place;
//   final String Email;
//   final String Password;
//
// //<editor-fold desc="Data Methods">
//
//
//   const ItemModel({
//     required this.name,
//     required this.place,
//     required this.Email,
//     required this.Password,
//   });
//
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           (other is ItemModel &&
//               runtimeType == other.runtimeType &&
//               name == other.name &&
//               place == other.place &&
//               Email == other.Email &&
//               Password == other.Password
//           );
//
//
//   @override
//   int get hashCode =>
//       name.hashCode ^
//       place.hashCode ^
//       Email.hashCode ^
//       Password.hashCode;
//
//
//   @override
//   String toString() {
//     return 'itemModel{' +
//         ' name: $name,' +
//         ' place: $place,' +
//         ' Email: $Email,' +
//         ' Password: $Password,' +
//         '}';
//   }
//
//
//   ItemModel copyWith({
//     String? name,
//     String? place,
//     String? Email,
//     String? Password,
//   }) {
//     return ItemModel(
//       name: name ?? this.name,
//       place: place ?? this.place,
//       Email: Email ?? this.Email,
//       Password: Password ?? this.Password,
//     );
//   }
//
//
//   Map<String, dynamic> toMap() {
//     return {
//       'name': this.name,
//       'place': this.place,
//       'Email': this.Email,
//       'Password': this.Password,
//     };
//   }
//
//   factory ItemModel.fromMap(Map<String, dynamic> map) {
//     return ItemModel(
//       name: map['name'].toString() ,
//       place: map['place'].toString() ,
//       Email: map['Email'].toString() ,
//       Password: map['Password'].toString(),
//     );
//   }
//
//
// //</editor-fold>
// }

// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  String name;
  String password;
  String email;
  String place;
  String id;
  String image;


  ItemModel({
    required this.image,
    required this.name,
    required this.password,
    required this.email,
    required this.place,
    required this.id

  });

  ItemModel copyWith({
    String? name,
    String? password,
    String? email,
    String? place,
  }) =>
      ItemModel(
        image: image ??this.image,
        name: name ?? this.name,
        password: password ?? this.password,
        email: email ?? this.email,
        place: place ?? this.place,
        id: id
      );

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    image: json["image"],
    name: json["name"],
    password: json["Password"],
    email: json["Email"],
    place: json["place"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "image":image,
    "name": name,
    "Password": password,
    "Email": email,
    "place": place,
    "id":id,
  };
}
