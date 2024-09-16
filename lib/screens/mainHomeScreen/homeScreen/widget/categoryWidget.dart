import 'package:egrocer/helper/utils/generalImports.dart';

class CategoryWidget extends StatelessWidget {
  final List<CategoryItem>? categories;

  CategoryWidget({super.key, this.categories});

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
                        jsonKey: "categories",
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
                        jsonKey: "shop_by_categories",
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
                    context.read<HomeMainScreenProvider>().selectBottomMenu(1);
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
          itemCount: categories?.length,
          padding: EdgeInsets.symmetric(
              horizontal: Constant.size10, vertical: Constant.size10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            CategoryItem category = categories![index];
            return CategoryItemContainer(
                category: category,
                voidCallBack: () {
                  if (category.hasChild!) {
                    Navigator.pushNamed(context, categoryListScreen,
                        arguments: [
                          ScrollController(),
                          category.name,
                          category.id.toString()
                        ]);
                  } else {
                    Navigator.pushNamed(context, productListScreen, arguments: [
                      "category",
                      category.id.toString(),
                      category.name
                    ]);
                  }
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
