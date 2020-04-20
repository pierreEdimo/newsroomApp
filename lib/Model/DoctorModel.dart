import 'package:flutter/foundation.dart';

class Doctor {
  final int id;
  final String name;
  final String specialisation;
  final String location;
  final String city;
  final String country;
  final String description;
  final String number;
  final String email;
  final String opening;
  final String closing;

  Doctor(
      {@required this.id,
      @required this.name,
      @required this.specialisation,
      @required this.location,
      @required this.city,
      @required this.country,
      @required this.description,
      @required this.number,
      @required this.email,
      @required this.opening,
      @required this.closing});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
        id: json['id'] as int,
        name: json['name'] as String,
        specialisation: json['specialisation'] as String,
        location: json['location'] as String,
        city: json['city'] as String,
        country: json['country'] as String,
        description: json['description'] as String,
        number: json['number'] as String,
        email: json['email'] as String,
        opening: json['opening'] as String,
        closing: json['closing'] as String);
  }
}
