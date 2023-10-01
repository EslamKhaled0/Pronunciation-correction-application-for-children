import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/module/settings/story1.dart';

class Stories extends StatelessWidget {

  List<String> storyNames = [
    'الفأر الطماع',
    'الأسد الجريح',
    'الثعلب الجائع و الأرنب الصغير',
    'الذئب المحتال',
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text(
            'القصص',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 30.0),
            itemCount: storyNames.length,
            itemBuilder: (context, index){
              final storyName = storyNames[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryOne(
                          numOfPage: index,
                        ),
                      ),
                    );
                  },
                  minWidth: double.infinity,
                  height: 60.0,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      storyName,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              );
            },
        )
      ),
    );
  }
}
