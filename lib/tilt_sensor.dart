import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorApp extends StatefulWidget {
  const SensorApp({Key? key}) : super(key: key);

  @override
  State<SensorApp> createState() => _SensorAppState();
}

class _SensorAppState extends State<SensorApp> {
  @override
  Widget build(BuildContext context) {

    //기로모드 고정
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    final centerX = MediaQuery.of(context).size.width / 2 - 50;
    final centerY = MediaQuery.of(context).size.height / 2 - 50;

    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<AccelerometerEvent>(
            stream: accelerometerEvents,
            builder: (context, snapshot) {
              if (!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final event = snapshot.data!;
              List<double> accelometerValues = [event.x, event.y, event.z];
              print(accelometerValues);

              return Positioned(
                left: centerX,
                top: centerY,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  width: 100,
                  height: 100,
                ),
              );
            }
          )
        ],
      ),
    );
  }
}
