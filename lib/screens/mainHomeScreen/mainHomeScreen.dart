import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:geolocator/geolocator.dart';
import '../PayjetUPI/PayjetDashboard.dart';
import '../PharmaDashboard.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => HomeMainScreenState();
}

class HomeMainScreenState extends State<HomeMainScreen> {
  NetworkStatus networkStatus = NetworkStatus.online;

  @override
  void dispose() {
    context
        .read<HomeMainScreenProvider>()
        .scrollController[0]
        .removeListener(() {});
    context
        .read<HomeMainScreenProvider>()
        .scrollController[1]
        .removeListener(() {});
    context
        .read<HomeMainScreenProvider>()
        .scrollController[2]
        .removeListener(() {});
    context
        .read<HomeMainScreenProvider>()
        .scrollController[3]
        .removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    if (mounted) {
      context.read<HomeMainScreenProvider>().setPages();
    }
    Future.delayed(
      Duration.zero,
      () async {
        if (!Constant.session.isUserLoggedIn()) {
          Map<String, String> params = {
            ApiAndParams.fcmToken:
                Constant.session.getData(SessionManager.keyFCMToken),
            ApiAndParams.platform: Platform.isAndroid ? "android" : "ios"
          };
          registerFcmKey(context: context, params: params);
        }

        LocationPermission permission;
        permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        } else if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }

        if ((Constant.session.getData(SessionManager.keyLatitude) == "" &&
                Constant.session.getData(SessionManager.keyLongitude) == "") ||
            (Constant.session.getData(SessionManager.keyLatitude) == "0" &&
                Constant.session.getData(SessionManager.keyLongitude) == "0")) {
          Navigator.pushNamed(context, confirmLocationScreen,
              arguments: [null, "location"]);
        } else {
          if (context.read<HomeMainScreenProvider>().getCurrentPage() == 0) {
            if (Constant.popupBannerEnabled) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog();
                },
              );
            }
          }

          if (Constant.session.isUserLoggedIn()) {
            await getAppNotificationSettingsRepository(
                    params: {}, context: context)
                .then(
              (value) async {
                if (value[ApiAndParams.status].toString() == "1") {
                  late AppNotificationSettings notificationSettings =
                      AppNotificationSettings.fromJson(value);
                  if (notificationSettings.data!.isEmpty) {
                    await updateAppNotificationSettingsRepository(params: {
                      ApiAndParams.statusIds: "1,2,3,4,5,6,7,8",
                      ApiAndParams.mobileStatuses: "0,1,1,1,1,1,1,1",
                      ApiAndParams.mailStatuses: "0,1,1,1,1,1,1,1"
                    }, context: context);
                  }
                }
              },
            );
          }
        }
      },
    ).then((value) {
      context.read<DeepLinkProvider>().getDeepLinkRedirection(context: context);
    });

    super.initState();
  }
  List<ScrollController> scrollController = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController()
  ];

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return Consumer<HomeMainScreenProvider>(
      builder: (context, homeMainScreenProvider, child) {
        return Scaffold(
          bottomNavigationBar: homeBottomNavigation(
            homeMainScreenProvider.getCurrentPage(),
            homeMainScreenProvider.selectBottomMenu,
            homeMainScreenProvider.getPages().length,
            context,
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Container(),
            leadingWidth: 0,
            title: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildTabButton('PayJet', 0,"assets/payjeyb.png"),
                    _buildTabButton('Grocery', 1,"assets/grocery.png"),
                    _buildTabButton('Pharma', 2,"assets/cap.png"),
                  ],
                ),
              ],
            ),
        ),
          body: networkStatus == NetworkStatus.online
              ?WillPopScope(
            onWillPop: () async {
              if (homeMainScreenProvider.currentPage == 0) {
                if (Platform.isAndroid) {
                  SystemNavigator.pop(); // For Android, exit the app
                } else if (Platform.isIOS) {
                  exit(0); // For iOS, exit the app
                }
                return false; // Returning false prevents the default back navigation behavior
              } else {
                setState(() {
                  homeMainScreenProvider.currentPage = 0; // Navigate to the main page
                });
                return false; // Returning false prevents the default back navigation behavior
              }
            },
                  child: IndexedStack(
                    index: homeMainScreenProvider.currentPage,
                    children: homeMainScreenProvider.getPages(),
                  ),
                )
              : Center(
                  child: CustomTextLabel(
                    jsonKey: "check_internet",
                  ),
                ),
        );
      },
    );
  }

  Widget _buildTabButton(String text, int index,String asset) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return InkResponse(
      onTap: (){
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComingSoonScreen()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeMainScreen()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComingSoonScreen()),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.only(right: 5),
        width: w*0.288,
        decoration: BoxDecoration(
          color:(text=="Grocery")?Color(0xff37B67D): Color(0xffEFF4F8),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset,
                width: 20, height: 15, fit: BoxFit.cover),
            SizedBox(width: w * 0.02),
            Text(text,
                style: TextStyle(
                    color:(text=="Grocery")?Colors.white: Color(0xff161531),
                    fontSize: 15,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
  homeBottomNavigation(int selectedIndex, Function selectBottomMenu,
      int totalPage, BuildContext context) {
    List lblHomeBottomMenu = [
      getTranslatedValue(
        context,
        "home_bottom_menu_home",
      ),
      getTranslatedValue(
        context,
        "home_bottom_menu_category",
      ),
      getTranslatedValue(
        context,
        "home_bottom_menu_wishlist",
      ),
      getTranslatedValue(
        context,
        "home_bottom_menu_profile",
      ),
    ];
    return BottomNavigationBar(
        items: List.generate(
          totalPage,
          (index) => BottomNavigationBarItem(
            backgroundColor: Theme.of(context).cardColor,
            icon: getHomeBottomNavigationBarIcons(
                isActive: selectedIndex == index)[index],
            label: lblHomeBottomMenu[index],
          ),
        ),
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        selectedItemColor: ColorsRes.mainTextColor,
        unselectedItemColor: Colors.transparent,
        onTap: (int ind) {
          selectBottomMenu(ind);
        },
        elevation: 5);
  }
}
