// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'data/services/auth_service.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://uwhffinagjquhkvcchpa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3aGZmaW5hZ2pxdWhrdmNjaHBhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzNDczNzUsImV4cCI6MjA1MTkyMzM3NX0.QwnsXTaierGGW2p7GT1yylISsXtePuZWZSLNqQioHKc',
  );
  
  await Get.putAsync(() => AuthService().init());

  runApp(const NekoFindApp());
}

class NekoFindApp extends StatelessWidget {
  const NekoFindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Neko Find',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/main',
      getPages: AppPages.pages,
    );
  }
}