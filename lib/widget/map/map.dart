import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'map_widget.dart';

class MapPicker extends StatefulWidget {
  const MapPicker({Key? key}) : super(key: key);
  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //修改颜色
        ),
        title: const Text(
          'Map Picker',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: LocationPicker(
        requestPermission: () {
          return Permission.location.request().then((it) => it.isGranted);
        },
        zoomGesturesEnabled: true,
        poiItemBuilder: (poi, selected) {
          return ListTile(
            leading:
                selected ? const Icon(Icons.check) : const SizedBox.shrink(),
            title: Transform(
              transform: Matrix4.translationValues(-16, 0.0, 0.0),
              child: Text(
                poi.title!,
                style: TextStyle(color: selected ? Colors.blue : Colors.black),
              ),
            ),
            subtitle: Transform(
                transform: Matrix4.translationValues(-16, 0.0, 0.0),
                child: Text(poi.address!)),
            trailing: Text(
              '${poi.distance!}m',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
