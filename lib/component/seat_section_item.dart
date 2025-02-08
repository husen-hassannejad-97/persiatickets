import 'package:billit_now/apps/helper/theme/app_colors_theme.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:flutter/material.dart';

class SeatSectionItem extends StatefulWidget {
  const SeatSectionItem(
      {super.key,
      required this.image,
      required this.score,
      required this.price,
      required this.currency,
      required this.row,
      required this.seatNumber,
      required this.onTap});

  final String image;
  final int score;
  final String price;
  final String currency;
  final String row;
  final int seatNumber;
  final Function() onTap;

  @override
  State<SeatSectionItem> createState() => _SeatSectionItemState();
}

class _SeatSectionItemState extends State<SeatSectionItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 6.0),
          decoration: BoxDecoration(
            color: _isHovered ? Theme.of(context).appColors.bgSecondary : null,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            children: [
              //image
              widget.image.contains('assets')
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: Image.asset(
                        widget.image,
                        height: 76.0,
                        width: 112.0,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: Image.network(
                        widget.image,
                        height: 76.0,
                        width: 112.0,
                        fit: BoxFit.cover,
                      ),
                    ),
              // info
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // score
                    _dealScore(context, widget.score),
                    // price
                    RichText(
                        text: TextSpan(
                            text: widget.currency + widget.price,
                            style: Theme.of(context)
                                .appTexts
                                .textMdSemiBold
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textPrimary900),
                            children: [
                          TextSpan(
                            text: ' total incl. fees',
                            style: Theme.of(context)
                                .appTexts
                                .textMdRegular
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textQuaternary500),
                          )
                        ])),
                    // row and seats
                    RichText(
                        text: TextSpan(
                            text: 'Row ${widget.row} ',
                            style: Theme.of(context)
                                .appTexts
                                .textMdRegular
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textQuaternary500),
                            children: [
                          WidgetSpan(
                              child: Container(
                            height: 20,
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: VerticalDivider(
                              color:
                                  Theme.of(context).appColors.borderSecondary,
                            ),
                          )),
                          TextSpan(
                            text: 'Seat ${widget.seatNumber}',
                            style: Theme.of(context)
                                .appTexts
                                .textMdRegular
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textQuaternary500),
                          )
                        ])),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _dealScore(BuildContext context, int score) {
    AppColorsTheme baseColor = Theme.of(context).appColors;
    late Color color;
    late String scoreTitle;

    switch (score) {
      case >= 9:
        color = baseColor.utilitySuccess700;
        scoreTitle = 'Amazing Deal';
        break;
      case >= 7:
        color = baseColor.utilitySuccess600;
        scoreTitle = 'Great Deal';
        break;
      case >= 5:
        color = baseColor.utilitySuccess500;
        scoreTitle = 'Good Deal';
        break;
      case >= 4:
        color = baseColor.utilityWarning600;
        scoreTitle = 'Okay Deal';
        break;
      case >= 3:
        color = baseColor.utilityWarning700;
        scoreTitle = 'Moderate Price';
        break;
      case >= 1:
        color = baseColor.utilityError500;
        scoreTitle = 'Deluxe Price';
        break;
      default:
        color = baseColor.fgSecondary700;
        scoreTitle = 'Deluxe Price';
    }

    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(4.0)),
          child: Center(
            child: Text(score.toString(),
                style: Theme.of(context)
                    .appTexts
                    .textXsMedium
                    .copyWith(color: Theme.of(context).appColors.textWhite)),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 6.0),
            child: Text(scoreTitle,
                style: Theme.of(context)
                    .appTexts
                    .textSmMedium
                    .copyWith(color: color)))
      ],
    );
  }
}
