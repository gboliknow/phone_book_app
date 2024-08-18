import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_book_app/presentation/views/contact_view.dart';
import 'package:phone_book_app/presentation/vm/theme_vm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(414, 896),
        minTextAdapt: true,
        builder: (context, child) {
      
          return ProviderScope(
            child: Consumer(builder: (context, ref, child) {
              final themeNotifier = ref.watch(themeNotifierProvider);

              return MaterialApp(
                title: 'Flutter Demo',
                theme: themeNotifier.currentTheme,
                home: const ContactHomeView(),
              );
            }),
          );
        });
  }
}
