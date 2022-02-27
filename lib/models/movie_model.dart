// To parse this JSON data, do
//
//     final movies = moviesFromJson(jsonString);

import 'dart:convert';


// ███╗░░░███╗░█████╗░██╗░░░██╗██╗███████╗░██████╗
// ████╗░████║██╔══██╗██║░░░██║██║██╔════╝██╔════╝
// ██╔████╔██║██║░░██║╚██╗░██╔╝██║█████╗░░╚█████╗░
// ██║╚██╔╝██║██║░░██║░╚████╔╝░██║██╔══╝░░░╚═══██╗
// ██║░╚═╝░██║╚█████╔╝░░╚██╔╝░░██║███████╗██████╔╝
// ╚═╝░░░░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝╚══════╝╚═════╝░

// ███╗░░░███╗░█████╗░██████╗░███████╗██╗░░░░░
// ████╗░████║██╔══██╗██╔══██╗██╔════╝██║░░░░░
// ██╔████╔██║██║░░██║██║░░██║█████╗░░██║░░░░░
// ██║╚██╔╝██║██║░░██║██║░░██║██╔══╝░░██║░░░░░
// ██║░╚═╝░██║╚█████╔╝██████╔╝███████╗███████╗
// ╚═╝░░░░░╚═╝░╚════╝░╚═════╝░╚══════╝╚══════╝

Movies moviesFromJson(String str) => Movies.fromJson(json.decode(str));

String moviesToJson(Movies data) => json.encode(data.toJson());

class Movies {
  Dates dates;
  int page;
  List<MovieResults> results;
  int totalPages;
  int totalResults;
  Movies({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        dates: Dates.fromJson(json["dates"]),
        page: json["page"],
        results: List<MovieResults>.from(
            json["results"].map((x) => MovieResults.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  DateTime maximum;
  DateTime minimum;
  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}

class MovieResults {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  MovieResults({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieResults.fromJson(Map<String, dynamic> json) => MovieResults(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
