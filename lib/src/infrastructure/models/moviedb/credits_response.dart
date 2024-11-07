//===========================================================
//* RESPUESTA ORIGINAL DE THE MOVIE DB
//? Cuando se solicita el cast
//===========================================================*/

import 'dart:convert';

class CreditsResponse {
    final int? id;
    final List<Cast>? cast;
    final List<Cast>? crew;

    CreditsResponse({
        this.id,
        this.cast,
        this.crew,
    });

    factory CreditsResponse.fromJson(String str) => CreditsResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: json["cast"] == null ? [] : List<Cast>.from(json["cast"]!.map((x) => Cast.fromMap(x))),
        crew: json["crew"] == null ? [] : List<Cast>.from(json["crew"]!.map((x) => Cast.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "cast": cast == null ? [] : List<dynamic>.from(cast!.map((x) => x.toMap())),
        "crew": crew == null ? [] : List<dynamic>.from(crew!.map((x) => x.toMap())),
    };
}

class Cast {
    final bool? adult;
    final int? gender;
    final int? id;
    final String? knownForDepartment;
    final String? name;
    final String? originalName;
    final double? popularity;
    final String? profilePath;
    final int? castId;
    final String? character;
    final String? creditId;
    final int? order;
    final String? department;
    final String? job;

    Cast({
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
        this.order,
        this.department,
        this.job,
    });

    factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"]!,
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["known_for_department"]!,
        job: json["job"],
    );

    Map<String, dynamic> toMap() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": department,
        "job": job,
    };
}

