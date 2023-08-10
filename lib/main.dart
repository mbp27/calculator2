import 'package:calculator2/config.dart';
import 'package:calculator2/logic/cubits/history/history_cubit.dart';
import 'package:calculator2/logic/cubits/theme/theme_cubit.dart';
import 'package:calculator2/presentation/designs/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'presentation/components/custom_scroll_behavior.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HistoryCubit>(
          create: (context) => HistoryCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final themeMode = context.select((ThemeCubit cubit) => cubit.state);

          return MaterialApp(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            title: Config.appName,
            onGenerateRoute: AppRouter().onGenerateRoute,
            builder: (context, child) => ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: child ?? Container(),
            ),
          );
        },
      ),
    );
  }
}
