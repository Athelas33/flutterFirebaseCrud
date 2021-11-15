import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterfirebasecrud/functions.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoDemo extends StatefulWidget {
  final String title, url;

  const VideoDemo({Key key, this.title, this.url}) : super(key: key);

  @override
  VideoDemoState createState() => VideoDemoState();
}

class VideoDemoState extends State<VideoDemo> {
  //
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url);
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            AppBar().preferredSize.height,
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Video Oynatıcı",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: size.height * 0.024,
                        fontWeight: FontWeight.w400),
                  ),
                  leading: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_left,
                      color: Colors.black87,
                    ),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(50, 50)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white70),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side:
                                BorderSide(color: Colors.black87, width: 1)))),
                  )))),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            );
          } else {
            return Center(
              child: SpinKitFadingFour(
                color: Colors.blue[700],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
