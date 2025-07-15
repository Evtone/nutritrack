// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SnapToLogScreen extends StatefulWidget {
  const SnapToLogScreen({super.key});

  @override
  State<SnapToLogScreen> createState() => _SnapToLogScreenState();
}

class _SnapToLogScreenState extends State<SnapToLogScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![0], ResolutionPreset.high);
      await _controller!.initialize();
      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
      });
    } else {
      // Handle case where no cameras are available
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No cameras found on this device.')),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Snap to Log'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CameraPreview(_controller!),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: FloatingActionButton(
                onPressed: () async {
                  try {
                    final image = await _controller!.takePicture();

                    // TODO: Navigate to a new screen to display the image and analyze it

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Picture saved at ${image.path}')),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.camera, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
