import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:gp_project/module/settings/themes/cubit/matrial_app_cubit.dart';
import 'package:gp_project/shared/components/components.dart';
import 'package:gp_project/module/level/cubit/cubit.dart';
import 'package:gp_project/module/level/cubit/states.dart';
import 'package:gp_project/users/userPrefrences/current_user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class TheLessonLevel1 extends StatefulWidget {
  int index;
  int numOfLevel;

  TheLessonLevel1({Key? key, required this.index, required this.numOfLevel})
      : super(key: key);

  @override
  State<TheLessonLevel1> createState() => _TheLessonLevel1State();
}

class _TheLessonLevel1State extends State<TheLessonLevel1> {
  late AppCubitLevel1 _cubit;
  final AudioPlayer audioPlayer = AudioPlayer();
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  FlutterSoundPlayer _player = FlutterSoundPlayer();
  String _recordingPath = '';
  bool _isRecording = false;
  CurrentUser _currentUser = Get.put(CurrentUser());
  double? parsingResult;
  // late int theLessons;

  @override
  void initState() {
    super.initState();
    _cubit = AppCubitLevel1.get(context);

    _initialize();
    webViewMethod();
    // theLessons = _cubit.locks1[0]['level${widget.numOfLevel}'];
    // readData();
  }

  Future webViewMethod() async {
    print('In Microphone permission method');

    await Permission.microphone.request();
  }

  void _initialize() async {
    await _recorder.openAudioSession();
    await _player.openAudioSession();
    Directory tempDir = await getTemporaryDirectory();
    _recordingPath = '${tempDir.path}/voice_recording.wav';
  }

  @override
  void dispose() {
    _recorder.closeAudioSession();
    _player.closeAudioSession();
    super.dispose();
  }

  void _startRecording() async {
    if (!_isRecording) {
      await _recorder.startRecorder(
          toFile: _recordingPath, codec: Codec.pcm16WAV);
      setState(() {
        _isRecording = true;
      });
    }
  }

  void _stopRecording() async {
    if (_isRecording) {
      await _recorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    }
  }

  Future<String> sendAudioFile(String word) async {
    String text = '';
    // Replace with the URL of your ngrok domain
    String apiUrl = "https://5f51-41-234-34-77.ngrok-free.app/transcribe";

    // Replace with the path to your audio file

    String audioFilePath = _recordingPath;

    // Replace with the target text for the audio file
    String targetText = word;

    // Prepare form data for the POST request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['target_text'] = targetText;
    request.files
        .add(await http.MultipartFile.fromPath('audio', audioFilePath));

    // Send the POST request to the API
    var response = await request.send();

    // Print the response from the API
    if (response.statusCode == 200) {
      text = await response.stream.bytesToString();
    } else {
      print('Failed to send audio file');
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubitLevel1, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        int timesOfPop = 0;
        List<List> textOfMaterials = [
          _cubit.materials1,
          _cubit.materials2,
          _cubit.materials3,
          _cubit.materials4,
          _cubit.materials5,
          _cubit.materials6,
          _cubit.materials7,
          _cubit.materials8,
          _cubit.materials9,
          _cubit.materials10,
          _cubit.materials11,
          _cubit.materials12,
        ];
        List<int> numOfLessons = [
          _cubit.materials1.length,
          _cubit.materials2.length,
          _cubit.materials3.length,
          _cubit.materials4.length,
          _cubit.materials5.length,
          _cubit.materials6.length,
          _cubit.materials7.length,
          _cubit.materials8.length,
          _cubit.materials9.length,
          _cubit.materials10.length,
          _cubit.materials11.length,
          _cubit.materials12.length
        ];

        Widget lottieAssets(parsingResult) {
          if (parsingResult >= 90) {
            if (_cubit.locks1[_currentUser.user.id - 1]
                        ['level${widget.numOfLevel}'] -
                    1 <
                widget.index + 1) {
              _cubit.updateDatabase1(
                  'locks1',
                  {
                    'level${widget.numOfLevel}':
                        _cubit.locks1[_currentUser.user.id - 1]
                                ['level${widget.numOfLevel}'] +
                            1
                  },
                  'id = ${_currentUser.user.id}');
              // readData();
            } else {
              null;
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets/95635-happy-boy.json'),
                Text(
                  'ممتاز',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else if (parsingResult >= 80) {
            if (_cubit.locks1[_currentUser.user.id - 1]
                        ['level${widget.numOfLevel}'] -
                    1 <
                widget.index + 1) {
              _cubit.updateDatabase1(
                  'locks1',
                  {
                    'level${widget.numOfLevel}':
                        _cubit.locks1[_currentUser.user.id - 1]
                                ['level${widget.numOfLevel}'] +
                            1
                  },
                  'id = ${_currentUser.user.id}');
              // readData();
            } else {
              null;
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets/95636-boy-waiting.json'),
                Text(
                  'جيد',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets/95640-boy-looking-error.json'),
                Text(
                  'حاول مرة أخرى',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }
        }

        Future<dynamic> showResultDialog() async {
          timesOfPop++;
          String result = await sendAudioFile(
              textOfMaterials[widget.numOfLevel - 1][widget.index]);

          // parsingResult = double.parse(result
          //     .replaceAll('{"pronunciation_percentage":', "")
          //     .replaceAll("}", ""));

          parsingResult = 90;

          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.of(context).pop(true);
                });
                return AlertDialog(
                  title: Align(
                      child: Text(
                    'النتيجة',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  content: lottieAssets(parsingResult),
                );
              });
        }

        print(_cubit.locks1);

        return Scaffold(
          appBar: AppBar(
            title: Align(
              child: Text(
                'الدرس ${widget.index + 1}',
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: Align(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                        'assets/images/images_level${widget.numOfLevel}/layer_${widget.index + 1}.png'),
                    height: 200.0,
                    width: 200.0,
                    // fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${textOfMaterials[widget.numOfLevel - 1][widget.index]}',
                          textDirection: TextDirection.rtl,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final bytes = await rootBundle.load(
                                'assets/voices/voices_level${widget.numOfLevel}/layer_${widget.index + 1}.mp3');
                            await audioPlayer
                                .playBytes(bytes.buffer.asUint8List());
                          },
                          child: const Icon(
                            Icons.volume_up_sharp,
                            size: 50.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  defaultButton(
                    width: 150.0,
                    background: MatrialAppCubit.get(context).buttonColor,
                    radius: 10.0,
                    function: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          Future.delayed(const Duration(seconds: 10), () async {
                            if (timesOfPop == 0) {
                              Navigator.of(_).pop(true);
                              _stopRecording();
                              showResultDialog();
                            }
                          });
                          return AlertDialog(
                            title: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'ردد الكلمة',
                                  style: TextStyle(
                                    color: MatrialAppCubit.get(context)
                                        .buttonColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            content: Lottie.asset(
                                'assets/28852-recording-voice-on-a-microphone-animation-recording-microphone.json'),
                            actions: [
                              TextButton(
                                child: const Text(
                                  'أوقف التسجيل',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                                onPressed: () async {
                                  if (timesOfPop == 0) {
                                    _stopRecording();
                                    Navigator.pop(_);
                                    showResultDialog();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                      _startRecording();
                    },
                    text: 'تحقق',
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (widget.index != 0)
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () {
                      setState(() {
                        widget.index = widget.index - 1;
                      });
                    },
                    tooltip: 'السابق',
                    child: const Icon(Icons.navigate_before_outlined),
                  ),
                Expanded(child: Container()),
                if (_cubit.locks1.isNotEmpty)
                  if (_cubit.locks1[_currentUser.user.id - 1]
                                  ['level${widget.numOfLevel}'] -
                              1 >
                          widget.index &&
                      widget.index + 1 != numOfLessons[widget.numOfLevel - 1])
                    FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: () {
                        print(widget.index);
                        setState(() {
                          widget.index = widget.index + 1;
                        });
                        print(widget.index);
                      },
                      tooltip: 'التالي',
                      child: const Icon(Icons.navigate_next_outlined),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
