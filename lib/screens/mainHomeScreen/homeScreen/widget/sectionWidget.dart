import 'package:egrocer/helper/utils/generalImports.dart';

class SectionWidget extends StatelessWidget {
  final List<Sections>? sections;

  SectionWidget({super.key, this.sections});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(sections?.length ?? 0, (index) {
        Sections? section = sections?[index];
        return section!.products!.isNotEmpty
            ? Column(
                children: [
                  Container(
                    decoration: DesignConfig.boxDecoration(
                      Theme.of(context).cardColor,
                      5,
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: Constant.size10, vertical: Constant.size5),
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
                                  text: section.title,
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
                                  text: section.shortDescription,
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
                              Navigator.pushNamed(context, productListScreen,
                                  arguments: [
                                    "sections",
                                    section.id.toString(),
                                    section.title
                                  ]);
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
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: ColorsRes.appColor,
                                    ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: context.width),
                      alignment: AlignmentDirectional.centerStart,
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 5),
                      child: Row(
                        children: List.generate(section.products?.length ?? 0,
                            (index) {
                          ProductListItem product = section.products![index];
                          return HomeScreenProductListItem(
                            product: product,
                            position: index,
                          );
                        }),
                      ),
                    ),
                  ),
                  //below section offer images
                  if (context
                      .read<HomeScreenProvider>()
                      .homeOfferImagesMap
                      .containsKey("below_section-${section.id}"))
                    OfferImagesWidget(
                      offerImages: context
                          .read<HomeScreenProvider>()
                          .homeOfferImagesMap["below_section-${section.id}"]
                          ?.toList(),
                    ),
                ],
              )
            : Container();
      }),
    );
  }
}
