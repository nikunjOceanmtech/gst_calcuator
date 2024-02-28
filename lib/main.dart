import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/di/get_it.dart';
import 'package:gst_calcuator/features/dash_board/presentation/pages/dash_board_screen.dart';
import 'package:gst_calcuator/features/gst_calculator/data/models/data_history_model.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/pages/gst_calculator_screen.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/widgets/tax_slab_screen.dart';
import 'package:gst_calcuator/global.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(init());

  await getApplicationDocumentsDirectory().then(
    (dir) async {
      Hive.init(dir.path);

      Hive.registerAdapter<DataHistoryModel>(DataHistoryModelAdapter());

      gstHistoryBox = await Hive.openBox(HiveBoxConstants.GST_BOX);
      listOfHistory = await gstHistoryBox.get(HiveConstants.GST_HISTORY, defaultValue: []);
      gstPlusSlabList = await gstHistoryBox.get(
        HiveConstants.GST_PLUS_SLAB,
        defaultValue: ["+3", "+5", "+12", "+18", "+28"],
      );
      gstMinusSlabList = await gstHistoryBox.get(
        HiveConstants.GST_MINUS_SLAB,
        defaultValue: ["-3", "-5", "-12", "-18", "-28"],
      );
      isSoundOn = await gstHistoryBox.get(HiveConstants.IS_SOUND_ON, defaultValue: true);
      isVibrationOn = await gstHistoryBox.get(HiveConstants.IS_VIBRATION_ON, defaultValue: false);
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(414, 896),
      rebuildFactor: (old, data) => RebuildFactors.orientation(old, data),
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const DashBoardScreen(),
          '/gst_cal': (context) => const GstCalculatorScreen(),
          '/tax_slab_screen': (context) => const TaxSlabScreen(),
        },
      ),
    );
  }
}
