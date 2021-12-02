// To parse this JSON data, do
//
//     final locationSuggestion = locationSuggestionFromJson(jsonString);

import 'dart:convert';

List<TomtomLocationSuggestion> locationSuggestionFromJson(String str) => List<TomtomLocationSuggestion>.from(json.decode(str).map((x) => TomtomLocationSuggestion.fromJson(x)));

String locationSuggestionToJson(List<TomtomLocationSuggestion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TomtomLocationSuggestion {
    TomtomLocationSuggestion({
        this.type,
        this.id,
        this.score,
        this.entityType,
        this.address,
        this.position,
        this.viewport,
        this.boundingBox,
        this.dataSources,
        this.info,
        this.poi,
        this.entryPoints,
    });

    final String type;
    final String id;
    final double score;
    final String entityType;
    final Address address;
    final LatLngPosition position;
    final BoundingBox viewport;
    final BoundingBox boundingBox;
    final DataSources dataSources;
    final String info;
    final Poi poi;
    final List<EntryPoint> entryPoints;

    factory TomtomLocationSuggestion.fromJson(Map<String, dynamic> json) => TomtomLocationSuggestion(
        type: json["type"] == null ? null : json["type"],
        id: json["id"] == null ? null : json["id"],
        score: json["score"] == null ? null : json["score"].toDouble(),
        entityType: json["entityType"] == null ? null : json["entityType"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        position: json["position"] == null ? null : LatLngPosition.fromJson(json["position"]),
        viewport: json["viewport"] == null ? null : BoundingBox.fromJson(json["viewport"]),
        boundingBox: json["boundingBox"] == null ? null : BoundingBox.fromJson(json["boundingBox"]),
        dataSources: json["dataSources"] == null ? null : DataSources.fromJson(json["dataSources"]),
        info: json["info"] == null ? null : json["info"],
        poi: json["poi"] == null ? null : Poi.fromJson(json["poi"]),
        entryPoints: json["entryPoints"] == null ? null : List<EntryPoint>.from(json["entryPoints"].map((x) => EntryPoint.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "id": id == null ? null : id,
        "score": score == null ? null : score,
        "entityType": entityType == null ? null : entityType,
        "address": address == null ? null : address.toJson(),
        "position": position == null ? null : position.toJson(),
        "viewport": viewport == null ? null : viewport.toJson(),
        "boundingBox": boundingBox == null ? null : boundingBox.toJson(),
        "dataSources": dataSources == null ? null : dataSources.toJson(),
        "info": info == null ? null : info,
        "poi": poi == null ? null : poi.toJson(),
        "entryPoints": entryPoints == null ? null : List<dynamic>.from(entryPoints.map((x) => x.toJson())),
    };
}

class Address {
    Address({
        this.municipalitySubdivision,
        this.municipality,
        this.countrySecondarySubdivision,
        this.countrySubdivision,
        this.countryCode,
        this.country,
        this.countryCodeIso3,
        this.freeformAddress,
        this.streetName,
        this.localName,
        this.streetNumber,
        this.postalCode,
    });

    final String municipalitySubdivision;
    final String municipality;
    final String countrySecondarySubdivision;
    final String countrySubdivision;
    final String countryCode;
    final String country;
    final String countryCodeIso3;
    final String freeformAddress;
    final String streetName;
    final String localName;
    final String streetNumber;
    final String postalCode;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        municipalitySubdivision: json["municipalitySubdivision"] == null ? null : json["municipalitySubdivision"],
        municipality: json["municipality"] == null ? null : json["municipality"],
        countrySecondarySubdivision: json["countrySecondarySubdivision"] == null ? null : json["countrySecondarySubdivision"],
        countrySubdivision: json["countrySubdivision"] == null ? null : json["countrySubdivision"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
        country: json["country"] == null ? null : json["country"],
        countryCodeIso3: json["countryCodeISO3"] == null ? null : json["countryCodeISO3"],
        freeformAddress: json["freeformAddress"] == null ? null : json["freeformAddress"],
        streetName: json["streetName"] == null ? null : json["streetName"],
        localName: json["localName"] == null ? null : json["localName"],
        streetNumber: json["streetNumber"] == null ? null : json["streetNumber"],
        postalCode: json["postalCode"] == null ? null : json["postalCode"],
    );

    Map<String, dynamic> toJson() => {
        "municipalitySubdivision": municipalitySubdivision == null ? null : municipalitySubdivision,
        "municipality": municipality == null ? null : municipality,
        "countrySecondarySubdivision": countrySecondarySubdivision == null ? null : countrySecondarySubdivision,
        "countrySubdivision": countrySubdivision == null ? null : countrySubdivision,
        "countryCode": countryCode == null ? null : countryCode,
        "country": country == null ? null : country,
        "countryCodeISO3": countryCodeIso3 == null ? null : countryCodeIso3,
        "freeformAddress": freeformAddress == null ? null : freeformAddress,
        "streetName": streetName == null ? null : streetName,
        "localName": localName == null ? null : localName,
        "streetNumber": streetNumber == null ? null : streetNumber,
        "postalCode": postalCode == null ? null : postalCode,
    };
}

class BoundingBox {
    BoundingBox({
        this.topLeftPoint,
        this.btmRightPoint,
    });

    final LatLngPosition topLeftPoint;
    final LatLngPosition btmRightPoint;

    factory BoundingBox.fromJson(Map<String, dynamic> json) => BoundingBox(
        topLeftPoint: json["topLeftPoint"] == null ? null : LatLngPosition.fromJson(json["topLeftPoint"]),
        btmRightPoint: json["btmRightPoint"] == null ? null : LatLngPosition.fromJson(json["btmRightPoint"]),
    );

    Map<String, dynamic> toJson() => {
        "topLeftPoint": topLeftPoint == null ? null : topLeftPoint.toJson(),
        "btmRightPoint": btmRightPoint == null ? null : btmRightPoint.toJson(),
    };
}

class LatLngPosition {
    LatLngPosition({
        this.lat,
        this.lon,
    });

    final double lat;
    final double lon;

    factory LatLngPosition.fromJson(Map<String, dynamic> json) => LatLngPosition(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
    };
}

class DataSources {
    DataSources({
        this.geometry,
    });

    final Geometry geometry;

    factory DataSources.fromJson(Map<String, dynamic> json) => DataSources(
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    );

    Map<String, dynamic> toJson() => {
        "geometry": geometry == null ? null : geometry.toJson(),
    };
}

class Geometry {
    Geometry({
        this.id,
    });

    final String id;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
    };
}

class EntryPoint {
    EntryPoint({
        this.type,
        this.position,
    });

    final String type;
    final LatLngPosition position;

    factory EntryPoint.fromJson(Map<String, dynamic> json) => EntryPoint(
        type: json["type"] == null ? null : json["type"],
        position: json["position"] == null ? null : LatLngPosition.fromJson(json["position"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "position": position == null ? null : position.toJson(),
    };
}

class Poi {
    Poi({
        this.name,
        this.categorySet,
        this.categories,
        this.classifications,
    });

    final String name;
    final List<CategorySet> categorySet;
    final List<String> categories;
    final List<Classification> classifications;

    factory Poi.fromJson(Map<String, dynamic> json) => Poi(
        name: json["name"] == null ? null : json["name"],
        categorySet: json["categorySet"] == null ? null : List<CategorySet>.from(json["categorySet"].map((x) => CategorySet.fromJson(x))),
        categories: json["categories"] == null ? null : List<String>.from(json["categories"].map((x) => x)),
        classifications: json["classifications"] == null ? null : List<Classification>.from(json["classifications"].map((x) => Classification.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "categorySet": categorySet == null ? null : List<dynamic>.from(categorySet.map((x) => x.toJson())),
        "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x)),
        "classifications": classifications == null ? null : List<dynamic>.from(classifications.map((x) => x.toJson())),
    };
}

class CategorySet {
    CategorySet({
        this.id,
    });

    final int id;

    factory CategorySet.fromJson(Map<String, dynamic> json) => CategorySet(
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
    };
}

class Classification {
    Classification({
        this.code,
        this.names,
    });

    final String code;
    final List<Name> names;

    factory Classification.fromJson(Map<String, dynamic> json) => Classification(
        code: json["code"] == null ? null : json["code"],
        names: json["names"] == null ? null : List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "names": names == null ? null : List<dynamic>.from(names.map((x) => x.toJson())),
    };
}

class Name {
    Name({
        this.nameLocale,
        this.name,
    });

    final String nameLocale;
    final String name;

    factory Name.fromJson(Map<String, dynamic> json) => Name(
        nameLocale: json["nameLocale"] == null ? null : json["nameLocale"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "nameLocale": nameLocale == null ? null : nameLocale,
        "name": name == null ? null : name,
    };
}
