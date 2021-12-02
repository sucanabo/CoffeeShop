import 'dart:convert';

VietmapLocationSuggestion locationSuggestionFromJson(String str) =>
    VietmapLocationSuggestion.fromJson(json.decode(str));

String locationSuggestionToJson(VietmapLocationSuggestion data) =>
    json.encode(data.toJson());

class VietmapLocationSuggestion {
  VietmapLocationSuggestion({
    this.type,
    this.geometry,
    this.properties,
    this.bbox,
    this.id,
  });

  final String type;
  final Geometry geometry;
  final Properties properties;
  final List<double> bbox;
  final String id;

  factory VietmapLocationSuggestion.fromJson(Map<String, dynamic> json) =>
      VietmapLocationSuggestion(
        type: json["type"] == null ? null : json["type"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
        bbox: json["bbox"] == null
            ? null
            : List<double>.from(json["bbox"].map((x) => x.toDouble())),
        id: json["Id"] == null ? null : json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "geometry": geometry == null ? null : geometry.toJson(),
        "properties": properties == null ? null : properties.toJson(),
        "bbox": bbox == null ? null : List<dynamic>.from(bbox.map((x) => x)),
        "Id": id == null ? null : id,
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  Properties({
    this.layer,
    this.name,
    this.housenumber,
    this.street,
    this.distance,
    this.accuracy,
    this.region,
    this.regionGid,
    this.county,
    this.countyGid,
    this.locality,
    this.localityGid,
    this.label,
    this.address,
    this.addendum,
    this.block,
    this.floor,
  });

  final String layer;
  final String name;
  final String housenumber;
  final String street;
  final int distance;
  final String accuracy;
  final String region;
  final String regionGid;
  final String county;
  final String countyGid;
  final String locality;
  final String localityGid;
  final String label;
  final String address;
  final Addendum addendum;
  final dynamic block;
  final dynamic floor;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        layer: json["layer"] == null ? null : json["layer"],
        name: json["name"] == null ? null : json["name"],
        housenumber: json["housenumber"] == null ? null : json["housenumber"],
        street: json["street"] == null ? null : json["street"],
        distance: json["distance"] == null ? null : json["distance"],
        accuracy: json["accuracy"] == null ? null : json["accuracy"],
        region: json["region"] == null ? null : json["region"],
        regionGid: json["region_gid"] == null ? null : json["region_gid"],
        county: json["county"] == null ? null : json["county"],
        countyGid: json["county_gid"] == null ? null : json["county_gid"],
        locality: json["locality"] == null ? null : json["locality"],
        localityGid: json["locality_gid"] == null ? null : json["locality_gid"],
        label: json["label"] == null ? null : json["label"],
        address: json["address"] == null ? null : json["address"],
        addendum: json["addendum"] == null
            ? null
            : Addendum.fromJson(json["addendum"]),
        block: json["block"],
        floor: json["floor"],
      );

  Map<String, dynamic> toJson() => {
        "layer": layer == null ? null : layer,
        "name": name == null ? null : name,
        "housenumber": housenumber == null ? null : housenumber,
        "street": street == null ? null : street,
        "distance": distance == null ? null : distance,
        "accuracy": accuracy == null ? null : accuracy,
        "region": region == null ? null : region,
        "region_gid": regionGid == null ? null : regionGid,
        "county": county == null ? null : county,
        "county_gid": countyGid == null ? null : countyGid,
        "locality": locality == null ? null : locality,
        "locality_gid": localityGid == null ? null : localityGid,
        "label": label == null ? null : label,
        "address": address == null ? null : address,
        "addendum": addendum == null ? null : addendum.toJson(),
        "block": block,
        "floor": floor,
      };
}

class Addendum {
  Addendum({
    this.imageId,
  });

  final dynamic imageId;

  factory Addendum.fromJson(Map<String, dynamic> json) => Addendum(
        imageId: json["imageId"],
      );

  Map<String, dynamic> toJson() => {
        "imageId": imageId,
      };
}
