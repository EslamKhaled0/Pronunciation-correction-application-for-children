import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class StoryOne extends StatefulWidget {
  int numOfPage;

  StoryOne({super.key, required this.numOfPage});
  @override
  State<StoryOne> createState() => _StoryOneState();
}

class _StoryOneState extends State<StoryOne> {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  String textFromFile = 'empty';

  getData() async {
    String response;
    response = await rootBundle
        .loadString('assets/text_files/stories_asset/story${widget.numOfPage + 1}.txt');
    setState(() {
      textFromFile = response;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<String> storyName = [
    'الفأر الطماع',
    'الأسد الجريح',
    'الثعلب الجائع و الأرنب الصغير',
    'الذئب المحتال',
  ];

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await audioPlayer.pause();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  audioPlayer.pause();
                },
              );
            },
          ),
          title: Align(
            child: Text(
              '${storyName[widget.numOfPage]}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (isPlaying == false) {
              final bytes = await rootBundle
                  .load('assets/voices/stories/story${widget.numOfPage + 1}.mp3');
              await audioPlayer.playBytes(bytes.buffer.asUint8List());
            } else {
              await audioPlayer.pause();
            }
            setState(() {
              isPlaying = !isPlaying;
            });
          },
          child: Icon(
            isPlaying == true ? Icons.volume_up : Icons.volume_off,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        textFromFile,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}