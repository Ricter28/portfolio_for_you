import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/modules/data/datasource/card_local.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
//
import 'package:flutter_template/common/utils/file.utils.dart';
import 'package:flutter_template/common/helpers/size_config.dart';
import 'package:flutter_template/common/constants/keys/hive_keys.dart';
import 'package:flutter_template/modules/presentation/auth/login_bloc/login_bloc.dart';
import 'package:flutter_template/common/helpers/error/hive/hive.helper.dart';
import 'package:flutter_template/modules/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_template/common/constants/locales.dart';
import 'package:flutter_template/common/theme/app_theme.dart';
import 'package:flutter_template/router/app_router.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/flavors.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> mainApp(Flavor flavor) async {
  AppFlavor.appFlavor = flavor;
  WidgetsFlutterBinding.ensureInitialized();
  LocalDatabase().initializeDatabase();
  tz.initializeTimeZones();
  await initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [AppLocales.en, AppLocales.vi],
      path: AppLocales.path,
      fallbackLocale: AppLocales.en,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(create: (context) => getIt<AuthBloc>()..add(CheckAuthEvent())),
      BlocProvider(create: (context) => getIt<LoginBloc>()),
    ],
      child: Listener(
        onPointerDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              getIt<AppRouter>().replaceAll([const OnboardingRoute()]);
            }
            if (state is UnauthenticatedState) {
              getIt<AppRouter>().replaceAll([const IntroFacebookRoute()]);
            }
          },
          child: MaterialApp.router(
            title: 'Flutter master App',
            theme: AppThemeData.lightThemeData,
            darkTheme: AppThemeData.darkThemeData,
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter.config(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: (context, child) {
              SizeConfig.init(context);
              return child ?? const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

Future<void> initializeApp() async {
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await FileUtil.getApplicationDir();
  await HiveHelper.openBox(HiveKeys.authBox);
  EasyLocalization.logger.enableBuildModes = [];
  configureDependencies();
  // If you want auto log debug, please uncoment this line below.
  // Bloc.observer = AppGlobalObserver();
}
