import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// 카메라 미리 보기

class CameraScreen extends StatefulWidget {
  late CameraController cameraController;
  CameraScreen(this.cameraController, {Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();

  static of(BuildContext context) {}
}

class _CameraScreenState extends State<CameraScreen> {
  //CameraController? _controller;
  late Future<void> _initializeControllerFuture; // 카메라 컨트롤러 초기화
  //late List<CameraDescription> _availableCameras; // 사용 가능한 카메라 목록

  @override
  void initState() {
    super.initState();
    //_initializeCamera();
    //setCamera(isFront);
  }

  /*Future<void> setCamera (bool isFront)async{
    _availableCameras = await availableCameras();
    _controller = CameraController(isFront ? _availableCameras.last: _availableCameras.first, ResolutionPreset.max, enableAudio: false);
    _controller!.initialize().then((_) {
      // 카메라가 작동되지 않을 경우
      if (!this.mounted) {
        print("이니셜라이즈 실패");
        return;
      }
      // 카메라가 작동될 경우
      setState(() {
        // 코드 작성
      });
    })
    // 카메라 오류 시
        .catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("CameraController Error : CameraAccessDenied");
            // Handle access errors here.
            break;
          default:
            print("CameraController Error");
            // Handle other errors here.
            break;
        }
      }
    });
  }*/

  /*Future<void> _initializeCamera() async {
    _availableCameras = await availableCameras();
    final firstCamera = _availableCameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize();
  }*/

  /*Future<void> _switchCamera() async {
    isFront = !isFront;
    setCamera(isFront);
  }*/

  @override
  void dispose() {
    //_controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 330,
      child: CameraPreview(widget.cameraController)
      /*FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // _controller가 초기화된 경우에만 CameraPreview을 반환
            return CameraPreview(widget.cameraController);
          } else if (snapshot.hasError) {
            // 에러 처리
            return Text("Error: ${snapshot.error}");
          } else {
            // 로딩 중
            return Center(child: CircularProgressIndicator());
          }
        },
      )*/
    );
  }
}
