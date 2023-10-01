import 'package:flutter/material.dart';
class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text(
            'إتصل بنا',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Align(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'رقم الموبيل : 0123456789',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Text(
                'البريد الإلكترونى: abcd@gmail.com',
                textDirection: TextDirection.rtl,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}