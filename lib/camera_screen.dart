import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// 카메라 미리 보기

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  // Initialize camera with desired camera and resolution settings
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _controller!.initialize();
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
