import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:map_test/src/features/location/data/models/building_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class GlobalMapPage extends StatefulWidget {
  final List<Building> buildings;
  const GlobalMapPage({super.key, required this.buildings});

  @override
  State<GlobalMapPage> createState() => _GlobalMapPageState();
}

class _GlobalMapPageState extends State<GlobalMapPage> {
  late YandexMapController _mapController;
  ClusterizedPlacemarkCollection? _clusterCollection;
  double _mapZoom = 10.0;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yandex Mapkit Demo')),
      body: YandexMap(
        onMapCreated: _onMapCreated,
        onMapTap: (_) {
          log(widget.buildings.first.lat.toString());
          log(widget.buildings.first.lon.toString());
        },
        onCameraPositionChanged: (position, _, __) {
          setState(() => _mapZoom = position.zoom);
        },
        mapObjects: _clusterCollection != null ? [_clusterCollection!] : [],
      ),
    );
  }

  Future<void> _onMapCreated(YandexMapController controller) async {
    _mapController = controller;

    if (widget.buildings.isNotEmpty) {
      final avgLat =
          widget.buildings.map((b) => b.lat ?? 0).reduce((a, b) => a + b) /
              widget.buildings.length;
      final avgLon =
          widget.buildings.map((b) => b.lon ?? 0).reduce((a, b) => a + b) /
              widget.buildings.length;

      await _mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(latitude: avgLat, longitude: avgLon),
            zoom: 10,
          ),
        ),
      );
    } else {
      await _mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          const CameraPosition(
            target: Point(latitude: 43.238949, longitude: 76.889709),
            zoom: 10,
          ),
        ),
      );
    }

    final placemarks = _createPlacemarks(widget.buildings);

    setState(
      () {
        _clusterCollection = ClusterizedPlacemarkCollection(
          mapId: const MapObjectId('clusterized-1'),
          placemarks: placemarks,
          radius: 100,
          minZoom: 12,
          onClusterAdded: (self, cluster) async {
            final image = await _drawClusterCircle(cluster.size);
            return cluster.copyWith(
              appearance: cluster.appearance.copyWith(
                opacity: 1.0,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromBytes(image),
                    scale: 1,
                  ),
                ),
              ),
            );
          },
          onClusterTap: (self, cluster) async {
            await _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: cluster.placemarks.first.point,
                  zoom: _mapZoom + 2.0,
                ),
              ),
              animation: const MapAnimation(
                type: MapAnimationType.smooth,
                duration: 0.3,
              ),
            );
          },
        );
      },
    );
  }

  Future<Uint8List> _drawClusterCircle(int count) async {
    const size = Size(120, 120);
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final center = Offset(size.width / 2, size.height / 2);

    final fillPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(center, size.width / 2.5, fillPaint);
    canvas.drawCircle(center, size.width / 2.5, strokePaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 38,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2,
          center.dy - textPainter.height / 2),
    );

    final image = await recorder.endRecording().toImage(
          size.width.toInt(),
          size.height.toInt(),
        );
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);
    return pngBytes!.buffer.asUint8List();
  }

  List<PlacemarkMapObject> _createPlacemarks(List<Building> buildings) {
    return buildings.map((b) {
      final id = b.id ?? UniqueKey().toString();
      return PlacemarkMapObject(
        mapId: MapObjectId('MapObject_$id'),
        point: Point(latitude: b.lat ?? 0.0, longitude: b.lon ?? 0.0),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/marker.png'),
            scale: 2,
          ),
        ),
      );
    }).toList();
  }
}

extension FirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
