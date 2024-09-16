import 'package:egrocer/helper/utils/generalImports.dart';

class BrandWidget extends StatelessWidget {
  final List<BrandItem>? brands;

  const BrandWidget({super.key, this.brands});

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
                        jsonKey: "brands",
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
                        jsonKey: "shop_by_brands",
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
                      brandListScreen,
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
          itemCount: brands?.length,
          padding: EdgeInsets.symmetric(
              horizontal: Constant.size10, vertical: Constant.size10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            BrandItem? brand = brands?[index];
            return BrandItemContainer(
                brand: brand,
                voidCallBack: () {
                  Navigator.pushNamed(context, productListScreen,
                      arguments: ["brand", brand?.id.toString(), brand?.name]);
                });
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
