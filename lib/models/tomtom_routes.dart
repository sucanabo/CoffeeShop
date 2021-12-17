// To parse this JSON data, do
//
//     final tomtomRoutes = tomtomRoutesFromJson(jsonString);

part of models;

TomtomRoutes tomtomRoutesFromJson(String str) => TomtomRoutes.fromJson(json.decode(str));

String tomtomRoutesToJson(TomtomRoutes data) => json.encode(data.toJson());

class TomtomRoutes {
    TomtomRoutes({
        this.routes,
    });

    final List<Route> routes;

    factory TomtomRoutes.fromJson(Map<String, dynamic> json) => TomtomRoutes(
        routes: json["routes"] == null ? null : List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "routes": routes == null ? null : List<dynamic>.from(routes.map((x) => x.toJson())),
    };
}

class Route {
    Route({
        this.summary,
        this.legs,
        this.sections,
    });

    final Summary summary;
    final List<Leg> legs;
    final List<Section> sections;

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        legs: json["legs"] == null ? null : List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        sections: json["sections"] == null ? null : List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "summary": summary == null ? null : summary.toJson(),
        "legs": legs == null ? null : List<dynamic>.from(legs.map((x) => x.toJson())),
        "sections": sections == null ? null : List<dynamic>.from(sections.map((x) => x.toJson())),
    };
}

class Leg {
    Leg({
        this.summary,
        this.points,
    });

    final Summary summary;
    final List<Point> points;

    factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        points: json["points"] == null ? null : List<Point>.from(json["points"].map((x) => Point.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "summary": summary == null ? null : summary.toJson(),
        "points": points == null ? null : List<dynamic>.from(points.map((x) => x.toJson())),
    };
}

class Point {
    Point({
        this.latitude,
        this.longitude,
    });

    final double latitude;
    final double longitude;

    factory Point.fromJson(Map<String, dynamic> json) => Point(
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
    };
}

class Summary {
    Summary({
        this.lengthInMeters,
        this.travelTimeInSeconds,
        this.trafficDelayInSeconds,
        this.trafficLengthInMeters,
        this.departureTime,
        this.arrivalTime,
    });

    final int lengthInMeters;
    final int travelTimeInSeconds;
    final int trafficDelayInSeconds;
    final int trafficLengthInMeters;
    final DateTime departureTime;
    final DateTime arrivalTime;

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        lengthInMeters: json["lengthInMeters"] == null ? null : json["lengthInMeters"],
        travelTimeInSeconds: json["travelTimeInSeconds"] == null ? null : json["travelTimeInSeconds"],
        trafficDelayInSeconds: json["trafficDelayInSeconds"] == null ? null : json["trafficDelayInSeconds"],
        trafficLengthInMeters: json["trafficLengthInMeters"] == null ? null : json["trafficLengthInMeters"],
        departureTime: json["departureTime"] == null ? null : DateTime.parse(json["departureTime"]),
        arrivalTime: json["arrivalTime"] == null ? null : DateTime.parse(json["arrivalTime"]),
    );

    Map<String, dynamic> toJson() => {
        "lengthInMeters": lengthInMeters == null ? null : lengthInMeters,
        "travelTimeInSeconds": travelTimeInSeconds == null ? null : travelTimeInSeconds,
        "trafficDelayInSeconds": trafficDelayInSeconds == null ? null : trafficDelayInSeconds,
        "trafficLengthInMeters": trafficLengthInMeters == null ? null : trafficLengthInMeters,
        "departureTime": departureTime == null ? null : departureTime.toIso8601String(),
        "arrivalTime": arrivalTime == null ? null : arrivalTime.toIso8601String(),
    };
}

class Section {
    Section({
        this.startPointIndex,
        this.endPointIndex,
        this.sectionType,
        this.travelMode,
    });

    final int startPointIndex;
    final int endPointIndex;
    final String sectionType;
    final String travelMode;

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        startPointIndex: json["startPointIndex"] == null ? null : json["startPointIndex"],
        endPointIndex: json["endPointIndex"] == null ? null : json["endPointIndex"],
        sectionType: json["sectionType"] == null ? null : json["sectionType"],
        travelMode: json["travelMode"] == null ? null : json["travelMode"],
    );

    Map<String, dynamic> toJson() => {
        "startPointIndex": startPointIndex == null ? null : startPointIndex,
        "endPointIndex": endPointIndex == null ? null : endPointIndex,
        "sectionType": sectionType == null ? null : sectionType,
        "travelMode": travelMode == null ? null : travelMode,
    };
}
