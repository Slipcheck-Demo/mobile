import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/slip/slip_screen.dart';
import 'src/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // .env is gitignored — copy it from .env.example first (see README).
  await dotenv.load();
  runApp(const ProviderScope(child: SlipcheckApp()));
}

class SlipcheckApp extends StatelessWidget {
  const SlipcheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slipcheck',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const SlipScreen(),
    );
  }
}
