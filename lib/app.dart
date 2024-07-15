
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:nomishop/bindings/general_bindings.dart';
import 'package:nomishop/util/constants/colors.dart';
import 'package:nomishop/util/theme/theme.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: NAppTheme.lightTheme,
      darkTheme: NAppTheme.darkTheme,
      initialBinding: GeneralBindings(),

      home: const Scaffold(
        backgroundColor: NColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white,),),
      ),
    );
  }
}

