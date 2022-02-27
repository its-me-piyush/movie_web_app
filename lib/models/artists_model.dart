// To parse this JSON data, do
//
//     final artists = artistsFromJson(jsonString);

import 'dart:convert';

// ░█████╗░██████╗░████████╗██╗░██████╗██╗░██████╗
// ██╔══██╗██╔══██╗╚══██╔══╝██║██╔════╝██║██╔════╝
// ███████║██████╔╝░░░██║░░░██║╚█████╗░██║╚█████╗░
// ██╔══██║██╔══██╗░░░██║░░░██║░╚═══██╗██║░╚═══██╗
// ██║░░██║██║░░██║░░░██║░░░██║██████╔╝██║██████╔╝
// ╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝╚═════╝░╚═╝╚═════╝░

// ███╗░░░███╗░█████╗░██████╗░███████╗██╗░░░░░
// ████╗░████║██╔══██╗██╔══██╗██╔════╝██║░░░░░
// ██╔████╔██║██║░░██║██║░░██║█████╗░░██║░░░░░
// ██║╚██╔╝██║██║░░██║██║░░██║██╔══╝░░██║░░░░░
// ██║░╚═╝░██║╚█████╔╝██████╔╝███████╗███████╗
// ╚═╝░░░░░╚═╝░╚════╝░╚═════╝░╚══════╝╚══════╝

Artists artistsFromJson(String str) => Artists.fromJson(json.decode(str));

String artistsToJson(Artists data) => json.encode(data.toJson());

class Artists {
  List<Cast> cast;

  Artists({
    required this.cast,
  });

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
      };
}

class Cast {
  String name;
  String originalName;
  String? charecter;
  String? profilePath;

  Cast({
    required this.name,
    required this.originalName,
    required this.charecter,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        name: json["name"],
        charecter: json["character"],
        originalName: json["original_name"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "original_name": originalName,
        "populatiry": charecter ?? '',
        "profile_path": profilePath ?? '',
      };
}
