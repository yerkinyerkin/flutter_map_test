class BuildingResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Building> buildings;

  BuildingResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.buildings,
  });

  factory BuildingResponse.fromJson(Map<String, dynamic> json) {
    final features = json['results']['features'] as List<dynamic>? ?? [];
    return BuildingResponse(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      buildings: features.map((e) => Building.fromJson(e)).toList(),
    );
  }
}

class Building {
  final int id;
  final String type;
  final String address;
  final String? houseNumber;
  final String? corpusNumber;
  final String? amountOfFloors;
  final String? yearOfFoundation;
  final String? cadastralNumber;
  final String? buildingName;
  final String? description;
  final String? postCode;

  final double? lat;
  final double? lon;

  final GeometryObject? geometry;

  Building({
    required this.id,
    required this.type,
    required this.address,
    this.houseNumber,
    this.corpusNumber,
    this.amountOfFloors,
    this.yearOfFoundation,
    this.cadastralNumber,
    this.buildingName,
    this.description,
    this.postCode,
    this.lat,
    this.lon,
    this.geometry,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    final props = json['properties'] ?? {};
    final marker = props['marker'];
    final coordinates = (marker != null && marker['coordinates'] != null)
        ? List<double>.from(marker['coordinates'])
        : [0.0, 0.0];

    final geometry = json['geometry'] != null
        ? GeometryObject.fromJson(json['geometry'])
        : null;

    return Building(
      id: json['id'],
      type: json['type'] ?? 'Feature',
      address: props['full_address'] ?? 'Нет адреса',
      houseNumber: props['house_number'],
      corpusNumber: props['corpus_number'],
      amountOfFloors: props['amount_of_floors'],
      yearOfFoundation: props['year_of_foundation'],
      cadastralNumber: props['cadastral_number'],
      buildingName: props['building_name'],
      description: props['description'],
      postCode: props['post_code'],
      lon: coordinates[0],
      lat: coordinates[1],
      geometry: geometry,
    );
  }
}

class GeometryObject {
  final String type;
  final List<List<List<List<dynamic>>>> coordinates;

  GeometryObject({
    required this.type,
    required this.coordinates,
  });

  factory GeometryObject.fromJson(Map<String, dynamic> json) {
    return GeometryObject(
      type: json['type'],
      coordinates: (json['coordinates'] as List)
          .map((poly) => (poly as List)
              .map((ring) => (ring as List)
                  .map((point) => (point as List)
                      .map((num) => num.toDouble())
                      .toList())
                  .toList())
              .toList())
          .toList(),
    );
  }
}

