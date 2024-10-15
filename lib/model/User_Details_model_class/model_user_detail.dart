// // ignore_for_file: non_constant_identifier_names
//
// import 'dart:convert';
//
// List<UserDetails> UserDetailsFromJson(String str) => List<UserDetails>.from(json.decode(str).map((x) => UserDetails.fromJson(x)));
//
// String UserDetailsToJson(List<UserDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class UserDetails {
//   String id;
//   double quantityLiter;
//   String dateAndTime;
//
//   UserDetails({
//     required this.id,
//     required this.quantityLiter,
//     required this.dateAndTime,
//   });
//
//   factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
//     id: json["Id "],
//     quantityLiter: json["Quantity (Liter)"].toDouble(),
//     dateAndTime: json["Date and Time"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Id ": id,
//     "Quantity (Liter)": quantityLiter,
//     "Date and Time": dateAndTime,
//   };
// }
import 'dart:convert';

List<UserDetails> userDetailsFromJson(String str) => List<UserDetails>.from(
    json.decode(str).map((x) => UserDetails.fromJson(x)));

class UserDetails {
  String id;
  double quantityLiter;
  DateTime dateAndTime;
  int newtime;

  UserDetails({
    required this.id,
    required this.quantityLiter,
    required this.dateAndTime,
    required this.newtime,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {

    DateTime time = DateTime.fromMillisecondsSinceEpoch(
        json["Date and Time"],isUtc:false);
    return UserDetails(
        id: json["Id "],
        quantityLiter: json["Quantity (Liter)"].toDouble(),
        dateAndTime: time,
        newtime: json["Date and Time"]
      );
  }
}
