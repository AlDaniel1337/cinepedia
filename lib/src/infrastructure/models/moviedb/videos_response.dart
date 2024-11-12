import 'dart:convert';

class VideosResponse {
    final int? id;
    final List<MovieTheMovieDB>? results;

    VideosResponse({
        this.id,
        this.results,
    });

    factory VideosResponse.fromJson(String str) => VideosResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory VideosResponse.fromMap(Map<String, dynamic> json) => VideosResponse(
        id: json["id"],
        results: json["results"] == null ? [] : List<MovieTheMovieDB>.from(json["results"]!.map((x) => MovieTheMovieDB.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toMap())),
    };
}

class MovieTheMovieDB {
    final String? iso6391;
    final String? iso31661;
    final String? name;
    final String? key;
    final String? site;
    final int? size;
    final String? type;
    final bool? official;
    final DateTime? publishedAt;
    final String? id;

    MovieTheMovieDB({
        this.iso6391,
        this.iso31661,
        this.name,
        this.key,
        this.site,
        this.size,
        this.type,
        this.official,
        this.publishedAt,
        this.id,
    });

    factory MovieTheMovieDB.fromJson(String str) => MovieTheMovieDB.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovieTheMovieDB.fromMap(Map<String, dynamic> json) => MovieTheMovieDB(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt?.toIso8601String(),
        "id": id,
    };
}
