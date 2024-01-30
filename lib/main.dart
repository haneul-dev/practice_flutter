// import 'dart:async';
// import 'dart:io';
// import 'camera.dart';

import "package:practice_flutter/camera_screen.dart";
import 'package:flutter/material.dart';
// flutter pub add camera
// import 'package:practice_flutter/camera.dart';


void main() {
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
              child: CameraScreen()
            ),
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
                  CameraScreen.of(context)?.switchCamera();
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
