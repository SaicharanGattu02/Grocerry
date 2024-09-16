import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late final SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  try {
    Platform.isAndroid
        ? await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC8OXXVmzmgtnuZ0GqPO6niXj774LutKkA",
        appId: "1:964965168805:android:45fc5d1b4017a363cbff4c",
        messagingSenderId: "964965168805",
        projectId: "payjet-bc921",
      ),
    )
        : await Firebase.initializeApp();

    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  } catch (_) {}

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DeepLinkProvider>(
          create: (context) {
            return DeepLinkProvider();
          },
        ),
        ChangeNotifierProvider<HomeMainScreenProvider>(
          create: (context) {
            return HomeMainScreenProvider();
          },
        ),
        ChangeNotifierProvider<CategoryListProvider>(
          create: (context) {
            return CategoryListProvider();
          },
        ),
        ChangeNotifierProvider<CityByLatLongProvider>(
          create: (context) {
            return CityByLatLongProvider();
          },
        ),
        ChangeNotifierProvider<HomeScreenProvider>(
          create: (context) {
            return HomeScreenProvider();
          },
        ),
        ChangeNotifierProvider<ProductChangeListingTypeProvider>(
          create: (context) {
            return ProductChangeListingTypeProvider();
          },
        ),
        ChangeNotifierProvider<FaqProvider>(
          create: (context) {
            return FaqProvider();
          },
        ),
        ChangeNotifierProvider<ProductWishListProvider>(
          create: (context) {
            return ProductWishListProvider();
          },
        ),
        ChangeNotifierProvider<ProductAddOrRemoveFavoriteProvider>(
          create: (context) {
            return ProductAddOrRemoveFavoriteProvider();
          },
        ),
        ChangeNotifierProvider<UserProfileProvider>(
          create: (context) {
            return UserProfileProvider();
          },
        ),
        ChangeNotifierProvider<CartListProvider>(
          create: (context) {
            return CartListProvider();
          },
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) {
            return LanguageProvider();
          },
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) {
            return ThemeProvider();
          },
        ),
        ChangeNotifierProvider<AppSettingsProvider>(
          create: (context) {
            return AppSettingsProvider();
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class GlobalScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionManager>(
      create: (_) => SessionManager(prefs: prefs),
      child: Consumer<SessionManager>(
        builder: (context, SessionManager sessionNotifier, child) {
          Constant.session =
              Provider.of<SessionManager>(context, listen: false);

          if (Constant.session
              .getData(SessionManager.appThemeName)
              .toString()
              .isEmpty) {
            Constant.session.setData(
                SessionManager.appThemeName, Constant.themeList[0], false);
            Constant.session.setBoolData(
                SessionManager.isDarkTheme,
                PlatformDispatcher.instance.platformBrightness ==
                    Brightness.dark,
                false);
          }

          // This callback is called every time the brightness changes from the device.
          PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
            if (Constant.session.getData(SessionManager.appThemeName) ==
                Constant.themeList[0]) {
              Constant.session.setBoolData(
                  SessionManager.isDarkTheme,
                  PlatformDispatcher.instance.platformBrightness ==
                      Brightness.dark,
                  true);
            }
          };

          return Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              if (Constant.session
                  .getData(SessionManager.appThemeName)
                  .toString()
                  .isEmpty) {
                Constant.session.setData(
                    SessionManager.appThemeName, Constant.themeList[0], false);
                Constant.session.setBoolData(
                    SessionManager.isDarkTheme,
                    PlatformDispatcher.instance.platformBrightness ==
                        Brightness.dark,
                    false);
              }

              // This callback is called every time the brightness changes from the device.
              PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
                if (Constant.session.getData(SessionManager.appThemeName) ==
                    Constant.themeList[0]) {
                  Constant.session.setBoolData(
                      SessionManager.isDarkTheme,
                      PlatformDispatcher.instance.platformBrightness ==
                          Brightness.dark,
                      true);
                }
              };

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: MaterialApp(
                  builder: (context, child) {
                    return ScrollConfiguration(
                      behavior: GlobalScrollBehavior(),
                      child: Center(
                        child: Directionality(
                          textDirection: languageProvider.languageDirection
                                      .toLowerCase() ==
                                  "rtl"
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          child: child!,
                        ),
                      ),
                    );
                  },
                  navigatorKey: Constant.navigatorKay,
                  onGenerateRoute: RouteGenerator.generateRoute,
                  initialRoute: "/",
                  scrollBehavior: ScrollGlowBehavior(),
                  debugShowCheckedModeBanner: false,
                  title: "Payjet",
                  theme: ThemeData(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    scaffoldBackgroundColor: Colors.white,
                    dialogBackgroundColor: Colors.white,
                    cardColor: Colors.white,
                    searchBarTheme: const SearchBarThemeData(),
                    tabBarTheme: const TabBarTheme(),
                    dialogTheme: const DialogTheme(
                      shadowColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0)), // Set the border radius of the dialog
                      ),
                    ),
                    buttonTheme: const ButtonThemeData(),
                    popupMenuTheme: const PopupMenuThemeData(
                        color: Colors.white, shadowColor: Colors.white),
                    appBarTheme: const AppBarTheme(
                      surfaceTintColor: Colors.white,
                    ),
                    cardTheme: const CardTheme(
                      shadowColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                    ),

                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        // overlayColor: MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                    bottomSheetTheme: const BottomSheetThemeData(
                        surfaceTintColor: Colors.white, backgroundColor: Colors.white),
                    colorScheme: const ColorScheme.light(background: Colors.white)
                        .copyWith(background: Colors.white),
                    textTheme: GoogleFonts.latoTextTheme(
                      Theme.of(context).textTheme,
                    ),
                  ),
                  localizationsDelegates: [
                    CountryLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  home: SplashScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
