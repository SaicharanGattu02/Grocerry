import 'package:egrocer/helper/utils/generalImports.dart';

class CountryOfOriginWidget extends StatelessWidget {
  final List<CountryItem>? countries;

  CountryOfOriginWidget({super.key, this.countries});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsetsDirectional.only(
            start: Constant.size10,
            end: Constant.size10,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constant.size5, vertical: Constant.size5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextLabel(
                        jsonKey: "country_of_origin",
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            color: ColorsRes.appColor,
                            fontWeight: FontWeight.w500),
                      ),
                      getSizedBox(
                        height: Constant.size5,
                      ),
                      CustomTextLabel(
                        jsonKey: "shop_by_country_of_origin",
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: ColorsRes.subTitleMainTextColor),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      countryListScreen,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: DesignConfig.boxDecoration(
                      ColorsRes.appColorLightHalfTransparent,
                      5,
                      bordercolor: ColorsRes.appColor,
                      isboarder: true,
                      borderwidth: 1,
                    ),
                    child: CustomTextLabel(
                      jsonKey: "see_all",
                      softWrap: true,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: ColorsRes.appColor,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        GridView.builder(
          itemCount: countries?.length,
          padding: EdgeInsets.symmetric(
              horizontal: Constant.size10, vertical: Constant.size10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            CountryItem? country = countries?[index];
            return CountryItemContainer(
              country: country,
              voidCallBack: () {
                Navigator.pushNamed(context, productListScreen, arguments: [
                  "country",
                  country?.id.toString(),
                  country?.name
                ]);
              },
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        )
      ],
    );
  }
}
