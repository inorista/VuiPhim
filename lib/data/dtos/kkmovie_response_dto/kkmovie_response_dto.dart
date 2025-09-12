class KkMovieResponseDto {
  KkMovieResponseDto({
    required this.status,
    required this.msg,
    required this.data,
  });

  final String? status;
  final String? msg;
  final Data? data;

  KkMovieResponseDto copyWith({String? status, String? msg, Data? data}) {
    return KkMovieResponseDto(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }

  factory KkMovieResponseDto.fromJson(Map<String, dynamic> json) {
    return KkMovieResponseDto(
      status: json["status"],
      msg: json["msg"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    required this.seoOnPage,
    required this.breadCrumb,
    required this.titlePage,
    required this.items,
    required this.params,
    required this.typeList,
    required this.appDomainFrontend,
    required this.appDomainCdnImage,
  });

  final SeoOnPage? seoOnPage;
  final List<BreadCrumb> breadCrumb;
  final String? titlePage;
  final List<Item> items;
  final Params? params;
  final String? typeList;
  final String? appDomainFrontend;
  final String? appDomainCdnImage;

  Data copyWith({
    SeoOnPage? seoOnPage,
    List<BreadCrumb>? breadCrumb,
    String? titlePage,
    List<Item>? items,
    Params? params,
    String? typeList,
    String? appDomainFrontend,
    String? appDomainCdnImage,
  }) {
    return Data(
      seoOnPage: seoOnPage ?? this.seoOnPage,
      breadCrumb: breadCrumb ?? this.breadCrumb,
      titlePage: titlePage ?? this.titlePage,
      items: items ?? this.items,
      params: params ?? this.params,
      typeList: typeList ?? this.typeList,
      appDomainFrontend: appDomainFrontend ?? this.appDomainFrontend,
      appDomainCdnImage: appDomainCdnImage ?? this.appDomainCdnImage,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      seoOnPage: json["seoOnPage"] == null
          ? null
          : SeoOnPage.fromJson(json["seoOnPage"]),
      breadCrumb: json["breadCrumb"] == null
          ? []
          : List<BreadCrumb>.from(
              json["breadCrumb"]!.map((x) => BreadCrumb.fromJson(x)),
            ),
      titlePage: json["titlePage"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      params: json["params"] == null ? null : Params.fromJson(json["params"]),
      typeList: json["type_list"],
      appDomainFrontend: json["APP_DOMAIN_FRONTEND"],
      appDomainCdnImage: json["APP_DOMAIN_CDN_IMAGE"],
    );
  }

  Map<String, dynamic> toJson() => {
    "seoOnPage": seoOnPage?.toJson(),
    "breadCrumb": breadCrumb.map((x) => x.toJson()).toList(),
    "titlePage": titlePage,
    "items": items.map((x) => x.toJson()).toList(),
    "params": params?.toJson(),
    "type_list": typeList,
    "APP_DOMAIN_FRONTEND": appDomainFrontend,
    "APP_DOMAIN_CDN_IMAGE": appDomainCdnImage,
  };
}

class BreadCrumb {
  BreadCrumb({
    required this.name,
    required this.isCurrent,
    required this.position,
  });

  final String? name;
  final bool? isCurrent;
  final int? position;

  BreadCrumb copyWith({String? name, bool? isCurrent, int? position}) {
    return BreadCrumb(
      name: name ?? this.name,
      isCurrent: isCurrent ?? this.isCurrent,
      position: position ?? this.position,
    );
  }

  factory BreadCrumb.fromJson(Map<String, dynamic> json) {
    return BreadCrumb(
      name: json["name"],
      isCurrent: json["isCurrent"],
      position: json["position"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "isCurrent": isCurrent,
    "position": position,
  };
}

class Item {
  Item({
    required this.tmdb,
    required this.imdb,
    required this.created,
    required this.modified,
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.type,
    required this.posterUrl,
    required this.thumbUrl,
    required this.subDocquyen,
    required this.chieurap,
    required this.time,
    required this.episodeCurrent,
    required this.quality,
    required this.lang,
    required this.year,
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
  final String? type;
  final String? posterUrl;
  final String? thumbUrl;
  final bool? subDocquyen;
  final bool? chieurap;
  final String? time;
  final String? episodeCurrent;
  final String? quality;
  final String? lang;
  final int? year;
  final List<Category> category;
  final List<Category> country;

  Item copyWith({
    Tmdb? tmdb,
    Imdb? imdb,
    Created? created,
    Created? modified,
    String? id,
    String? name,
    String? slug,
    String? originName,
    String? type,
    String? posterUrl,
    String? thumbUrl,
    bool? subDocquyen,
    bool? chieurap,
    String? time,
    String? episodeCurrent,
    String? quality,
    String? lang,
    int? year,
    List<Category>? category,
    List<Category>? country,
  }) {
    return Item(
      tmdb: tmdb ?? this.tmdb,
      imdb: imdb ?? this.imdb,
      created: created ?? this.created,
      modified: modified ?? this.modified,
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      originName: originName ?? this.originName,
      type: type ?? this.type,
      posterUrl: posterUrl ?? this.posterUrl,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      subDocquyen: subDocquyen ?? this.subDocquyen,
      chieurap: chieurap ?? this.chieurap,
      time: time ?? this.time,
      episodeCurrent: episodeCurrent ?? this.episodeCurrent,
      quality: quality ?? this.quality,
      lang: lang ?? this.lang,
      year: year ?? this.year,
      category: category ?? this.category,
      country: country ?? this.country,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
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
      type: json["type"],
      posterUrl: json["poster_url"],
      thumbUrl: json["thumb_url"],
      subDocquyen: json["sub_docquyen"],
      chieurap: json["chieurap"],
      time: json["time"],
      episodeCurrent: json["episode_current"],
      quality: json["quality"],
      lang: json["lang"],
      year: json["year"],
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
    "type": type,
    "poster_url": posterUrl,
    "thumb_url": thumbUrl,
    "sub_docquyen": subDocquyen,
    "chieurap": chieurap,
    "time": time,
    "episode_current": episodeCurrent,
    "quality": quality,
    "lang": lang,
    "year": year,
    "category": category.map((x) => x.toJson()).toList(),
    "country": country.map((x) => x.toJson()).toList(),
  };
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
  final int? season;
  final double? voteAverage;
  final int? voteCount;

  Tmdb copyWith({
    String? type,
    String? id,
    int? season,
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
}

class Params {
  Params({
    required this.typeSlug,
    required this.keyword,
    required this.filterCategory,
    required this.filterCountry,
    required this.filterYear,
    required this.filterType,
    required this.sortField,
    required this.sortType,
    required this.pagination,
  });

  final String? typeSlug;
  final String? keyword;
  final List<String> filterCategory;
  final List<String> filterCountry;
  final List<String> filterYear;
  final List<String> filterType;
  final String? sortField;
  final String? sortType;
  final Pagination? pagination;

  Params copyWith({
    String? typeSlug,
    String? keyword,
    List<String>? filterCategory,
    List<String>? filterCountry,
    List<String>? filterYear,
    List<String>? filterType,
    String? sortField,
    String? sortType,
    Pagination? pagination,
  }) {
    return Params(
      typeSlug: typeSlug ?? this.typeSlug,
      keyword: keyword ?? this.keyword,
      filterCategory: filterCategory ?? this.filterCategory,
      filterCountry: filterCountry ?? this.filterCountry,
      filterYear: filterYear ?? this.filterYear,
      filterType: filterType ?? this.filterType,
      sortField: sortField ?? this.sortField,
      sortType: sortType ?? this.sortType,
      pagination: pagination ?? this.pagination,
    );
  }

  factory Params.fromJson(Map<String, dynamic> json) {
    return Params(
      typeSlug: json["type_slug"],
      keyword: json["keyword"],
      filterCategory: json["filterCategory"] == null
          ? []
          : List<String>.from(json["filterCategory"]!.map((x) => x)),
      filterCountry: json["filterCountry"] == null
          ? []
          : List<String>.from(json["filterCountry"]!.map((x) => x)),
      filterYear: json["filterYear"] == null
          ? []
          : List<String>.from(json["filterYear"]!.map((x) => x)),
      filterType: json["filterType"] == null
          ? []
          : List<String>.from(json["filterType"]!.map((x) => x)),
      sortField: json["sortField"],
      sortType: json["sortType"],
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "type_slug": typeSlug,
    "keyword": keyword,
    "filterCategory": filterCategory.map((x) => x).toList(),
    "filterCountry": filterCountry.map((x) => x).toList(),
    "filterYear": filterYear.map((x) => x).toList(),
    "filterType": filterType.map((x) => x).toList(),
    "sortField": sortField,
    "sortType": sortType,
    "pagination": pagination?.toJson(),
  };
}

class Pagination {
  Pagination({
    required this.totalItems,
    required this.totalItemsPerPage,
    required this.currentPage,
    required this.totalPages,
  });

  final int? totalItems;
  final int? totalItemsPerPage;
  final int? currentPage;
  final int? totalPages;

  Pagination copyWith({
    int? totalItems,
    int? totalItemsPerPage,
    int? currentPage,
    int? totalPages,
  }) {
    return Pagination(
      totalItems: totalItems ?? this.totalItems,
      totalItemsPerPage: totalItemsPerPage ?? this.totalItemsPerPage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalItems: json["totalItems"],
      totalItemsPerPage: json["totalItemsPerPage"],
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
    );
  }

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems,
    "totalItemsPerPage": totalItemsPerPage,
    "currentPage": currentPage,
    "totalPages": totalPages,
  };
}

class SeoOnPage {
  SeoOnPage({
    required this.ogType,
    required this.titleHead,
    required this.descriptionHead,
    required this.ogImage,
    required this.ogUrl,
  });

  final String? ogType;
  final String? titleHead;
  final String? descriptionHead;
  final List<String> ogImage;
  final String? ogUrl;

  SeoOnPage copyWith({
    String? ogType,
    String? titleHead,
    String? descriptionHead,
    List<String>? ogImage,
    String? ogUrl,
  }) {
    return SeoOnPage(
      ogType: ogType ?? this.ogType,
      titleHead: titleHead ?? this.titleHead,
      descriptionHead: descriptionHead ?? this.descriptionHead,
      ogImage: ogImage ?? this.ogImage,
      ogUrl: ogUrl ?? this.ogUrl,
    );
  }

  factory SeoOnPage.fromJson(Map<String, dynamic> json) {
    return SeoOnPage(
      ogType: json["og_type"],
      titleHead: json["titleHead"],
      descriptionHead: json["descriptionHead"],
      ogImage: json["og_image"] == null
          ? []
          : List<String>.from(json["og_image"]!.map((x) => x)),
      ogUrl: json["og_url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "og_type": ogType,
    "titleHead": titleHead,
    "descriptionHead": descriptionHead,
    "og_image": ogImage.map((x) => x).toList(),
    "og_url": ogUrl,
  };
}
