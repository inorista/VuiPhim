import 'package:vuiphim/data/hive_database/hive_entities/category_entity/category_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/created_entity/created_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/imdb_entity/imdb_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/kkmovie_movie_entity/kkmovie_movie_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/kkmovie_source_entity/kkmovie_source_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/tmdb_entity/tmdb_entity.dart';

class KkMovieSourceDto {
  KkMovieSourceDto({
    required this.status,
    required this.msg,
    required this.movie,
    required this.episodes,
  });

  final bool? status;
  final String? msg;
  final Movie? movie;
  final List<EpisodeDto> episodes;

  KkMovieSourceDto copyWith({
    bool? status,
    String? msg,
    Movie? movie,
    List<EpisodeDto>? episodes,
  }) {
    return KkMovieSourceDto(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      movie: movie ?? this.movie,
      episodes: episodes ?? this.episodes,
    );
  }

  factory KkMovieSourceDto.fromJson(Map<String, dynamic> json) {
    return KkMovieSourceDto(
      status: json["status"],
      msg: json["msg"],
      movie: json["movie"] == null ? null : Movie.fromJson(json["movie"]),
      episodes: json["episodes"] == null
          ? []
          : List<EpisodeDto>.from(
              json["episodes"]!.map((x) => EpisodeDto.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "movie": movie?.toJson(),
    "episodes": episodes.map((x) => x.toJson()).toList(),
  };

  KkMovieSourceEntity toEntity() => KkMovieSourceEntity(
    status: status,
    msg: msg,
    movie: movie?.toEntity(),
    episodes: episodes.map((e) => e.toEntity()).toList(),
  );
}

class EpisodeDto {
  EpisodeDto({required this.serverName, required this.serverData});

  final String? serverName;
  final List<ServerData> serverData;

  EpisodeDto copyWith({String? serverName, List<ServerData>? serverData}) {
    return EpisodeDto(
      serverName: serverName ?? this.serverName,
      serverData: serverData ?? this.serverData,
    );
  }

  factory EpisodeDto.fromJson(Map<String, dynamic> json) {
    return EpisodeDto(
      serverName: json["server_name"],
      serverData: json["server_data"] == null
          ? []
          : List<ServerData>.from(
              json["server_data"]!.map((x) => ServerData.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "server_name": serverName,
    "server_data": serverData.map((x) => x.toJson()).toList(),
  };

  EpisodeEntity toEntity() => EpisodeEntity(
    serverName: serverName,
    serverData: serverData.map((e) => e.toEntity()).toList(),
  );
}

class ServerData {
  ServerData({
    required this.name,
    required this.slug,
    required this.filename,
    required this.linkEmbed,
    required this.linkM3U8,
  });

  final String? name;
  final String? slug;
  final String? filename;
  final String? linkEmbed;
  final String? linkM3U8;

  ServerData copyWith({
    String? name,
    String? slug,
    String? filename,
    String? linkEmbed,
    String? linkM3U8,
  }) {
    return ServerData(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      filename: filename ?? this.filename,
      linkEmbed: linkEmbed ?? this.linkEmbed,
      linkM3U8: linkM3U8 ?? this.linkM3U8,
    );
  }

  factory ServerData.fromJson(Map<String, dynamic> json) {
    return ServerData(
      name: json["name"],
      slug: json["slug"],
      filename: json["filename"],
      linkEmbed: json["link_embed"],
      linkM3U8: json["link_m3u8"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "filename": filename,
    "link_embed": linkEmbed,
    "link_m3u8": linkM3U8,
  };

  ServerDataEntity toEntity() => ServerDataEntity(
    name: name,
    slug: slug,
    filename: filename,
    linkEmbed: linkEmbed,
    linkM3U8: linkM3U8,
  );
}

class Movie {
  Movie({
    required this.tmdb,
    required this.imdb,
    required this.created,
    required this.modified,
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.content,
    required this.type,
    required this.status,
    required this.posterUrl,
    required this.thumbUrl,
    required this.isCopyright,
    required this.subDocquyen,
    required this.chieurap,
    required this.trailerUrl,
    required this.time,
    required this.episodeCurrent,
    required this.episodeTotal,
    required this.quality,
    required this.lang,
    required this.notify,
    required this.showtimes,
    required this.year,
    required this.view,
    required this.actor,
    required this.director,
    required this.category,
    required this.country,
  });

  final Tmdb? tmdb;
  final Imdb? imdb;
  final Created? created;
  final Created? modified;
  final String? id;
  final String? name;
  final String? slug;
  final String? originName;
  final String? content;
  final String? type;
  final String? status;
  final String? posterUrl;
  final String? thumbUrl;
  final bool? isCopyright;
  final bool? subDocquyen;
  final bool? chieurap;
  final String? trailerUrl;
  final String? time;
  final String? episodeCurrent;
  final String? episodeTotal;
  final String? quality;
  final String? lang;
  final String? notify;
  final String? showtimes;
  final int? year;
  final int? view;
  final List<String> actor;
  final List<String> director;
  final List<Category> category;
  final List<Category> country;

  Movie copyWith({
    Tmdb? tmdb,
    Imdb? imdb,
    Created? created,
    Created? modified,
    String? id,
    String? name,
    String? slug,
    String? originName,
    String? content,
    String? type,
    String? status,
    String? posterUrl,
    String? thumbUrl,
    bool? isCopyright,
    bool? subDocquyen,
    bool? chieurap,
    String? trailerUrl,
    String? time,
    String? episodeCurrent,
    String? episodeTotal,
    String? quality,
    String? lang,
    String? notify,
    String? showtimes,
    int? year,
    int? view,
    List<String>? actor,
    List<String>? director,
    List<Category>? category,
    List<Category>? country,
  }) {
    return Movie(
      tmdb: tmdb ?? this.tmdb,
      imdb: imdb ?? this.imdb,
      created: created ?? this.created,
      modified: modified ?? this.modified,
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      originName: originName ?? this.originName,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      posterUrl: posterUrl ?? this.posterUrl,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      isCopyright: isCopyright ?? this.isCopyright,
      subDocquyen: subDocquyen ?? this.subDocquyen,
      chieurap: chieurap ?? this.chieurap,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      time: time ?? this.time,
      episodeCurrent: episodeCurrent ?? this.episodeCurrent,
      episodeTotal: episodeTotal ?? this.episodeTotal,
      quality: quality ?? this.quality,
      lang: lang ?? this.lang,
      notify: notify ?? this.notify,
      showtimes: showtimes ?? this.showtimes,
      year: year ?? this.year,
      view: view ?? this.view,
      actor: actor ?? this.actor,
      director: director ?? this.director,
      category: category ?? this.category,
      country: country ?? this.country,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      tmdb: json["tmdb"] == null ? null : Tmdb.fromJson(json["tmdb"]),
      imdb: json["imdb"] == null ? null : Imdb.fromJson(json["imdb"]),
      created: json["created"] == null
          ? null
          : Created.fromJson(json["created"]),
      modified: json["modified"] == null
          ? null
          : Created.fromJson(json["modified"]),
      id: json["_id"],
      name: json["name"],
      slug: json["slug"],
      originName: json["origin_name"],
      content: json["content"],
      type: json["type"],
      status: json["status"],
      posterUrl: json["poster_url"],
      thumbUrl: json["thumb_url"],
      isCopyright: json["is_copyright"],
      subDocquyen: json["sub_docquyen"],
      chieurap: json["chieurap"],
      trailerUrl: json["trailer_url"],
      time: json["time"],
      episodeCurrent: json["episode_current"],
      episodeTotal: json["episode_total"],
      quality: json["quality"],
      lang: json["lang"],
      notify: json["notify"],
      showtimes: json["showtimes"],
      year: json["year"],
      view: json["view"],
      actor: json["actor"] == null
          ? []
          : List<String>.from(json["actor"]!.map((x) => x)),
      director: json["director"] == null
          ? []
          : List<String>.from(json["director"]!.map((x) => x)),
      category: json["category"] == null
          ? []
          : List<Category>.from(
              json["category"]!.map((x) => Category.fromJson(x)),
            ),
      country: json["country"] == null
          ? []
          : List<Category>.from(
              json["country"]!.map((x) => Category.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "tmdb": tmdb?.toJson(),
    "imdb": imdb?.toJson(),
    "created": created?.toJson(),
    "modified": modified?.toJson(),
    "_id": id,
    "name": name,
    "slug": slug,
    "origin_name": originName,
    "content": content,
    "type": type,
    "status": status,
    "poster_url": posterUrl,
    "thumb_url": thumbUrl,
    "is_copyright": isCopyright,
    "sub_docquyen": subDocquyen,
    "chieurap": chieurap,
    "trailer_url": trailerUrl,
    "time": time,
    "episode_current": episodeCurrent,
    "episode_total": episodeTotal,
    "quality": quality,
    "lang": lang,
    "notify": notify,
    "showtimes": showtimes,
    "year": year,
    "view": view,
    "actor": actor.map((x) => x).toList(),
    "director": director.map((x) => x).toList(),
    "category": category.map((x) => x.toJson()).toList(),
    "country": country.map((x) => x.toJson()).toList(),
  };

  KkMovieMovieEntity toEntity() => KkMovieMovieEntity(
    tmdb: tmdb?.toEntity(),
    imdb: imdb?.toEntity(),
    created: created?.toEntity(),
    modified: modified?.toEntity(),
    id: id,
    name: name,
    slug: slug,
    originName: originName,
    content: content,
    type: type,
    status: status,
    posterUrl: posterUrl,
    thumbUrl: thumbUrl,
    isCopyright: isCopyright,
    subDocquyen: subDocquyen,
    chieurap: chieurap,
    trailerUrl: trailerUrl,
    time: time,
    episodeCurrent: episodeCurrent,
    episodeTotal: episodeTotal,
    quality: quality,
    lang: lang,
    notify: notify,
    showtimes: showtimes,
    year: year,
    view: view,
    actor: actor,
    director: director,
    category: category.map((e) => e.toEntity()).toList(),
    country: country.map((e) => e.toEntity()).toList(),
  );
}

class Category {
  Category({required this.id, required this.name, required this.slug});

  final String? id;
  final String? name;
  final String? slug;

  Category copyWith({String? id, String? name, String? slug}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json["id"], name: json["name"], slug: json["slug"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "slug": slug};

  CategoryEntity toEntity() => CategoryEntity(id: id, name: name, slug: slug);
}

class Created {
  Created({required this.time});

  final DateTime? time;

  Created copyWith({DateTime? time}) {
    return Created(time: time ?? this.time);
  }

  factory Created.fromJson(Map<String, dynamic> json) {
    return Created(time: DateTime.tryParse(json["time"] ?? ""));
  }

  Map<String, dynamic> toJson() => {"time": time?.toIso8601String()};

  CreatedEntity toEntity() => CreatedEntity(time: time);
}

class Imdb {
  Imdb({required this.id});

  final dynamic id;

  Imdb copyWith({dynamic id}) {
    return Imdb(id: id ?? this.id);
  }

  factory Imdb.fromJson(Map<String, dynamic> json) {
    return Imdb(id: json["id"]);
  }

  Map<String, dynamic> toJson() => {"id": id};

  ImdbEntity toEntity() => ImdbEntity(id: id);
}

class Tmdb {
  Tmdb({
    required this.type,
    required this.id,
    required this.season,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? type;
  final String? id;
  final dynamic season;
  final double? voteAverage;
  final int? voteCount;

  Tmdb copyWith({
    String? type,
    String? id,
    dynamic season,
    double? voteAverage,
    int? voteCount,
  }) {
    return Tmdb(
      type: type ?? this.type,
      id: id ?? this.id,
      season: season ?? this.season,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  factory Tmdb.fromJson(Map<String, dynamic> json) {
    return Tmdb(
      type: json["type"],
      id: json["id"],
      season: json["season"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "season": season,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  TmdbEntity toEntity() => TmdbEntity(
    type: type,
    id: id,
    season: season,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );
}
