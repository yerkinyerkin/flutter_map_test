import 'package:flutter/material.dart';
import 'package:map_test/src/features/location/data/models/building_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapController {
  late YandexMapController _controller;
  final List<MapObject> _mapObjects = [];

  List<MapObject> get mapObjects => _mapObjects;

  void setController(YandexMapController controller) {
    _controller = controller;
  }

  Future<void> moveTo(Point point, {double zoom = 20}) async {
    await _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: zoom),
      ),
    );
  }

  void addMarker({
    required String id,
    required Point point,
    required GeometryObject? geometry,
    required BuildContext context,
    required String address,
    required String description,
    required VoidCallback onPolygonTap,
    double scale = 1.0,
  }) {
    // if (geometry == null) return;

    final marker = PlacemarkMapObject(
      text: PlacemarkText(
          text: address,
          style:
              const PlacemarkTextStyle(placement: TextStylePlacement.bottom)),
      mapId: MapObjectId(id),
      point: point,
      opacity: 1,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/marker.png'),
          scale: scale,
        ),
      ),
      onTap: (_, __) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey.shade200,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Описание',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );

    addPolygonFromGeometry(id: id, geometry: geometry);
    _mapObjects.add(marker);
  }

  void addPolygonFromGeometry({
    required String id,
    required GeometryObject? geometry,
    Color color = Colors.blue,
    double strokeWidth = 2,
  }) {
    if (geometry == null) return;

    if (geometry.type == 'MultiPolygon') {
      final coordinates = geometry.coordinates[0][0];

      const staticPoints = [
        Point(latitude: 43.222745, longitude: 76.884019),
        Point(latitude: 43.222854, longitude: 76.884494),
        Point(latitude: 43.222595, longitude: 76.884605),
        Point(latitude: 43.222485, longitude: 76.884130),
        Point(latitude: 43.222745, longitude: 76.884019),
      ];

      final points = coordinates.map<Point>((coord) {
        return Point(latitude: coord[1], longitude: coord[0]);
      }).toList();

      final polygon = PolygonMapObject(
        mapId: MapObjectId('polygon_$id'),
        polygon: const Polygon(
          outerRing: LinearRing(points: staticPoints),
          innerRings: [],
        ),
        strokeColor: color,
        fillColor: color.withOpacity(0.2),
        strokeWidth: strokeWidth,
      );
      _mapObjects.add(polygon);
    }
  }

  Future<void> zoomIn() async {
    final position = await _controller.getCameraPosition();
    await _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position.target,
          zoom: position.zoom + 1,
        ),
      ),
      animation:
          const MapAnimation(type: MapAnimationType.smooth, duration: 0.3),
    );
  }

  Future<void> zoomOut() async {
    final position = await _controller.getCameraPosition();
    await _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position.target,
          zoom: position.zoom - 1,
        ),
      ),
      animation:
          const MapAnimation(type: MapAnimationType.smooth, duration: 0.3),
    );
  }
}
