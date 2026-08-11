import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/ai_chat/presentation/pages/chat_page.dart';import 'features/home/presentation/pages/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: AITeacherAssistantApp(),
    ),
  );
}

class AITeacherAssistantApp extends StatelessWidget {
  const AITeacherAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المساعد الذكي للمعلم',
      debugShowCheckedModeBanner: false,
      
      // إعدادات اللغة العربية والاتجاه (RTL)
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      // الصفحة الرئيسية
      home: const HomePage(),

    );
  }
}

