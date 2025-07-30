import 'package:flutter/material.dart';
import 'package:map_test/src/features/location/data/models/building_model.dart';
import 'package:map_test/src/features/map/presentation/controller/map_controller.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:permission_handler/permission_handler.dart';

class YandexMapPage extends StatefulWidget {
  const YandexMapPage({super.key, required this.building});
  final Building building;

  @override
  State<YandexMapPage> createState() => _YandexMapPageState();
}

class _YandexMapPageState extends State<YandexMapPage> {
  final _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _requestPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _mapController.addMarker(
          id: '${widget.building.id}',
          point: Point(
            latitude: widget.building.lat ?? 0.0,
            longitude: widget.building.lon ?? 0.0,
          ),
          geometry: widget.building.geometry,
          context: context,
          address: widget.building.address,
          description: widget.building.description ?? 'Нет Данных',
          onPolygonTap: () {
            setState(() {});
          },
        );
      });
    });
  }

  Future<void> _requestPermission() async {
    await Permission.location.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 229),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          YandexMap(
            mapObjects: _mapController.mapObjects,
            onMapCreated: (YandexMapController controller) async {
              _mapController.setController(controller);
              await _mapController.moveTo(
                Point(
                  latitude: widget.building.lat ?? 0.0,
                  longitude: widget.building.lon ?? 0.0,
                ),
                zoom: 15,
              );
            },
          ),
          Positioned(
            right: 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _zoomButton(Icons.add, _mapController.zoomIn),
                const SizedBox(height: 10),
                _zoomButton(Icons.remove, _mapController.zoomOut),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _zoomButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: () => setState(onTap),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 3,
              spreadRadius: 3,
              offset: const Offset(1, 0.5),
            )
          ],
        ),
        child: Icon(icon),
      ),
    );
  }
}
