import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// 카메라 미리 보기

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();

  static of(BuildContext context) {}
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  late Future<void> _initializeControllerFuture; // 카메라 컨트롤러 초기화
  late List<CameraDescription> _availableCameras; // 사용 가능한 카메라 목록

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _availableCameras = await availableCameras();
    final firstCamera = _availableCameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize();
  }

  Future<void> _switchCamera() async {
    if (_controller != null) {
      final currentCameraDescription = _controller!.description;
      final newCameraDescription = _availableCameras.firstWhere(
            (camera) => camera.lensDirection != currentCameraDescription.lensDirection,
      );

      await _controller!.dispose();
      _controller = CameraController(newCameraDescription, ResolutionPreset.medium);
      _initializeControllerFuture = _controller!.initialize();

      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 375,
      child: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // _controller가 초기화된 경우에만 CameraPreview을 반환
            return _controller != null ? CameraPreview(_controller!) : Container();
          } else if (snapshot.hasError) {
            // 에러 처리
            return Text("Error: ${snapshot.error}");
          } else {
            // 로딩 중
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
