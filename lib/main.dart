import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:idea_chat/screens/chat.dart';
import 'package:openapi/api.dart';
import 'package:idea_chat/screens/auth.dart';

void main() {
  print("RUN!");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var api = DefaultApi();

    return MaterialApp(
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        return deviceLocale;
      },
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Provider Demo',
      initialRoute: '/chat',
      routes: {
        '/': (context) => AuthForm(api),
        '/chat': (context) => Chat(api),
      },
    );
  }
}
