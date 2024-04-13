import 'package:chat_app/pages/chat.dart';
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MaterialApp(
    routes: {
      'Register':(context) => Register(),
      'chat' :(context) => chat(documentId: 'Ei8kYEVgZO3vDxXwUGQt',)
    },
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}
