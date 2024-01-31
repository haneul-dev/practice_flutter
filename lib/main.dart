// import 'dart:async';
// import 'dart:io';
// import 'camera.dart';

import 'package:camera/camera.dart';
import "package:practice_flutter/camera_screen.dart";
import 'package:flutter/material.dart';

// flutter pub add camera
// import 'package:practice_flutter/camera.dart';

late final List<CameraDescription> _availableCameras; // 사용 가능한 카메라 목록

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _availableCameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isFront = false;

  Future<void> setCamera(bool isFront) async {
    _controller = CameraController(
        isFront ? _availableCameras.last : _availableCameras.first,
        ResolutionPreset.max,
        enableAudio: false);
    try {
      _initializeControllerFuture =  _controller.initialize();
    } catch (e) {
      print("CameraController Error: $e");
      // 초기화 오류 처리
      return;
    }

    // 카메라가 작동되지 않을 경우
    if (!this.mounted) {
      print("이니셜라이즈 실패");
      return;
    }

    // 카메라가 작동될 경우
    setState(() {
      // 컨트롤러가 초기화된 후 실행할 코드
    });

    /*_controller!.initialize().then((_) {
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
    });*/
  }

  @override
  void initState() {
    super.initState();
    //setCamera(isFront);
  }

  @override
  void dispose() {
    super.dispose();
  }

  var _index = 0; // 페이지 인덱스 0, 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50, // 원하는 세로 길이로 설정
        leading: Padding(
          padding: EdgeInsets.only(left: 0.0, top: 00.0, bottom: 0),
          child: IconButton(
            icon: Icon(Icons.close),
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            }, // 예를 들어, 현재 화면을 닫는 코드
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Center(
              child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // _controller가 초기화된 경우에만 CameraPreview을 반환
                return CameraScreen(_controller);
              } else if (snapshot.hasError) {
                // 에러 처리
                return Text("Error: ${snapshot.error}");
              } else {
                // 로딩 중
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
          SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //SizedBox(width: 15), // 여백 추가
              IconButton(
                icon: Image.asset('assets/images/flash.png',
                    width: 50, height: 50),
                onPressed: () {
                  // 플래쉬 코드
                },
              ),
              //SizedBox(width: 75), // 여백 추가
              IconButton(
                icon: Image.asset('assets/images/camera_shutter.png',
                    width: 70, height: 70),
                onPressed: () {
                  // 사진 촬영 코드
                },
              ),
              //SizedBox(width: 75), // 여백 추가
              IconButton(
                icon: Image.asset('assets/images/turn_around.png',
                    width: 50, height: 50),
                onPressed: () {
                  //CameraScreen.of(context)?._switchCamera();
                  isFront = !isFront;
                  setCamera(isFront);
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  '사진앨범',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  '카메라',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
