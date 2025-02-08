import 'package:billit_now/apps/helper/event_status.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/core/localization/layout_direction.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventItem extends BaseStatefulWidget {
  final double itemHeight;
  final double itemWidth;
  final MainAxisAlignment itemMainAlign;
  final CrossAxisAlignment itemCrossAlign;
  final EventStatus status;
  final bool isLiked;
  final String image;
  final double imageHeight;
  final String title;
  final String date;
  final String location;
  final String price;
  final bool isBWImage;
  final Function() onTap;
  final Function() onTapLike;

  const EventItem._internal({
    super.key,
    required this.itemHeight,
    required this.itemWidth,
    required this.itemMainAlign,
    required this.itemCrossAlign,
    required this.status,
    this.isLiked = false,
    required this.image,
    required this.imageHeight,
    required this.title,
    required this.date,
    required this.location,
    required this.price,
    this.isBWImage = false,
    required this.onTap,
    required this.onTapLike,
  });

  factory EventItem.def({
    required EventStatus status,
    double? itemHeight,
    double? itemWidth,
    bool isLiked = false,
    required String image,
    double? imageHeight,
    required String title,
    required String date,
    required String location,
    required String price,
    required Function() onTap,
    required Function() onTapLike,
  }) =>
      EventItem._internal(
        itemHeight: itemHeight ?? 230,
        itemWidth: itemWidth ?? 248,
        imageHeight: imageHeight ?? 140,
        itemMainAlign: MainAxisAlignment.start,
        itemCrossAlign: CrossAxisAlignment.start,
        status: status,
        isLiked: isLiked,
        image: image,
        title: title,
        date: date,
        location: location,
        price: price,
        onTap: onTap,
        onTapLike: onTapLike,
      );
  factory EventItem.expanded({
    required EventStatus status,
    bool isLiked = false,
    required String image,
    required String title,
    required String date,
    required String location,
    required String price,
    bool isBWImage = false,
    required Function() onTap,
    required Function() onTapLike,
  }) =>
      EventItem._internal(
        itemMainAlign: MainAxisAlignment.center,
        itemCrossAlign: CrossAxisAlignment.center,
        itemHeight: 462,
        itemWidth: 248,
        status: status,
        isLiked: isLiked,
        image: image,
        imageHeight: 372,
        title: title,
        date: date,
        location: location,
        price: price,
        isBWImage: isBWImage,
        onTap: onTap,
        onTapLike: onTapLike,
      );

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends BaseWidgetState<EventItem> {
  bool? isLiked;
  @override
  Widget body(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: widget.itemWidth,
        height: widget.itemHeight,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: widget.itemCrossAlign,
          children: [
            // header image
            Expanded(
              child: SizedBox(
                height: widget.imageHeight,
                child: Stack(
                  children: [
                    // image
                    LayoutBuilder(builder: (context, constraint) {
                      return ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        child: widget.isBWImage
                            ? ColorFiltered(
                                colorFilter: Theme.of(context)
                                    .appDimensions
                                    .blackAndWhiteFilter,
                                child: Skeleton.ignore(child: Image.network(
                                  widget.image,
                                  height: constraint.maxHeight,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover,
                                )))
                            : Skeleton.ignore(
                                child: Image.network(
                                widget.image,
                                height: constraint.maxHeight,
                                width: double.infinity,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              )),
                      );
                    }),
                    // like btn
                    Align(
                      alignment: getLayoutDirection() == LayoutDirection.ltr
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 44,
                        height: 44,
                        child: AppButton.buttonIcon(
                            isLiked == null
                                ? widget.isLiked
                                    ? AppIconName.ueb3aHeartRed
                                    : AppIconName.ueb3aHeart
                                : isLiked!
                                    ? AppIconName.ueb3aHeartRed
                                    : AppIconName.ueb3aHeart,
                            bgColor: Colors.transparent,
                            bgHoverColor: Colors.transparent,
                            textColor: Theme.of(context).appColors.fgPrimary900,
                            iconSize: 24,
                            context: context, onTap: () {
                          setState(() {
                            isLiked = isLiked ?? false;
                            isLiked = !isLiked!;
                            widget.onTapLike();
                          });
                        }),
                      ),
                    ),
                    // status btn
                    Align(
                      alignment: getLayoutDirection() == LayoutDirection.ltr
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        width: (getString(widget.status.key)).length * 10.5,
                        height: 34,
                        child: AppButton.buttonTertiary(
                            context: context,
                            text: getString(widget.status.key),
                            textStyle: Theme.of(context).appTexts.textSmMedium,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 2),
                            bgColor: Theme.of(context).appColors.bgPrimary,
                            bgHoverColor: Theme.of(context).appColors.bgPrimary,
                            border: Border.all(
                                color:
                                    Theme.of(context).appColors.borderPrimary,
                                width: 1),
                            onTap: widget.onTap),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // title
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                      color: Theme.of(context).appColors.textPrimary900)),
            ),
            // date and location
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '${widget.date}, ${widget.location}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).appTexts.textMdRegular.copyWith(
                    color: Theme.of(context).appColors.textTeritory600),
              ),
            ),
            // price
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                getString("from_[placeholder]").replaceFirst("[placeholder]", "\$${widget.price}"),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                    color: Theme.of(context).appColors.textPrimary900),
              ),
            )
          ],
        ),
      ),
    );
  }
}
