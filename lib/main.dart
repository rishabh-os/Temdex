import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temdex/Temdex/TemList.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io' show Platform;
import 'package:temdex/Data/data_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Must add this line.
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    WindowOptions windowOptions = const WindowOptions(
      size: Size(400, 700),
      center: false,
      // ! Turn off when in production
      alwaysOnTop: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      var y = ref.watch(colorProvider);
      return MaterialApp(
        // showPerformanceOverlay: true,
        title: 'Temdex',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: y[1], brightness: y[0]),
          // brightness: y[0],
        ),
        home: const TemList(),
      );
    });
  }
}
