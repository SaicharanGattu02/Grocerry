import 'package:egrocer/helper/utils/generalImports.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;

  const HomeScreen({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, List<OfferImages>> map = {};

  @override
  void initState() {
    super.initState();
    //fetch productList from api
    Future.delayed(Duration.zero).then((value) async {
        await getAppSettings(context: context);

        Map<String, String> params = await Constant.getProductsDefaultParams();
        print("Params:${params}");
        await context.read<HomeScreenProvider>().getHomeScreenApiProvider(context: context, params: params);

        if (Constant.session.isUserLoggedIn()) {
          await context
              .read<CartListProvider>()
              .getAllCartItems(context: context);

          await getUserDetail(context: context).then(
            (value) {
              if (value[ApiAndParams.status].toString() == "1") {
                context
                    .read<UserProfileProvider>()
                    .updateUserDataInSession(value, context);
              }
            },
          );
        } else {
          // if (Constant.guestCartOptionIsOn == "1") {
          context.read<CartListProvider>().setGuestCartItems();
          // }
        }
      },
    );
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: DeliveryAddressWidget(),
        centerTitle: false,
        actions: [
          setNotificationIcon(context: context),
          setCartCounter(context: context),
        ],
        showBackButton: false,
      ),
      body: Column(
        children: [
          getSearchWidget(
            context: context,
          ),
          Expanded(
            child: setRefreshIndicator(
              refreshCallback: () async {
                context.read<CartListProvider>().getAllCartItems(context: context);
                Map<String, String> params =
                    await Constant.getProductsDefaultParams();
                return await context
                    .read<HomeScreenProvider>()
                    .getHomeScreenApiProvider(context: context, params: params);
              },
              child: SingleChildScrollView(
                controller: widget.scrollController,
                child: Consumer<HomeScreenProvider>(
                  builder: (context, homeScreenProvider, _) {
                    map = homeScreenProvider.homeOfferImagesMap;
                    if (homeScreenProvider.homeScreenState ==
                        HomeScreenState.loaded) {
                      for (int i = 0;
                          i < homeScreenProvider.homeScreenData.sliders!.length;
                          i++) {
                        precacheImage(
                          NetworkImage(homeScreenProvider
                                  .homeScreenData.sliders?[i].imageUrl ??
                              ""),
                          context,
                        );
                      }
                      return Column(
                        children: [
                          //top offer images
                          if (map.containsKey("top"))
                            OfferImagesWidget(
                              offerImages: map["top"]!.toList(),
                            ),
                          ChangeNotifierProvider<SliderImagesProvider>(
                            create: (context) => SliderImagesProvider(),
                            child: SliderImageWidget(
                              sliders:
                                  homeScreenProvider.homeScreenData.sliders ??
                                      [],
                            ),
                          ),
                          //below slider offer images
                          if (map.containsKey("below_slider"))
                            OfferImagesWidget(
                              offerImages: map["below_slider"]!.toList(),
                            ),
                          if (homeScreenProvider.homeScreenData.categories !=
                                  null &&
                              homeScreenProvider
                                  .homeScreenData.categories!.isNotEmpty)
                            CategoryWidget(
                                categories: homeScreenProvider
                                    .homeScreenData.categories),
                          //below category offer images
                          if (map.containsKey("below_category"))
                            OfferImagesWidget(
                              offerImages: map["below_category"]!.toList(),
                            ),
                          if (homeScreenProvider.homeScreenData.brands !=
                                  null &&
                              homeScreenProvider
                                  .homeScreenData.brands!.isNotEmpty)
                            BrandWidget(
                                brands:
                                    homeScreenProvider.homeScreenData.brands),
                          if (homeScreenProvider.homeScreenData.sellers !=
                                  null &&
                              homeScreenProvider
                                  .homeScreenData.sellers!.isNotEmpty)
                            SellerWidget(
                                sellers:
                                    homeScreenProvider.homeScreenData.sellers),
                          if (homeScreenProvider.homeScreenData.countries !=
                                  null &&
                              homeScreenProvider
                                  .homeScreenData.countries!.isNotEmpty)
                            CountryOfOriginWidget(
                                countries: homeScreenProvider
                                    .homeScreenData.countries),
                          if (homeScreenProvider.homeScreenData.sections !=
                                  null &&
                              homeScreenProvider
                                  .homeScreenData.sections!.isNotEmpty)
                            SectionWidget(
                                sections:
                                    homeScreenProvider.homeScreenData.sections)
                        ],
                      );
                    } else if (homeScreenProvider.homeScreenState ==
                            HomeScreenState.loading ||
                        homeScreenProvider.homeScreenState ==
                            HomeScreenState.initial) {
                      return getHomeScreenShimmer(context);
                    } else {
                      return NoInternetConnectionScreen(
                        height: context.height * 0.65,
                        message: homeScreenProvider.message,
                        callback: () async {
                          Map<String, String> params =
                              await Constant.getProductsDefaultParams();
                          await context
                              .read<HomeScreenProvider>()
                              .getHomeScreenApiProvider(
                                  context: context, params: params);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
