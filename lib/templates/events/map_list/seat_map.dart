import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/repositories/event_map/models/map_model.dart';
import 'package:billit_now/templates/events/map_list/svg_painter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

class SeatMap extends StatefulWidget {
  const SeatMap(
      {super.key,
      required this.offset,
      required this.scaleFactor,
      required this.currency,
      required this.svgPath,
      required this.availableSeats,
      required this.specialSeats,
      required this.minZoom,
      required this.maxZoom,
      required this.onTapSeat,
      required this.zoomToSeat,
      required this.selectedSeats,
      required this.zoomAtMouse,
      required this.onScaleUpdate});

  final Offset offset;
  final double scaleFactor;
  final String currency;
  final String svgPath;
  final List<MapSeatModel> availableSeats;
  final List<MapSpecialSeatModel> specialSeats;
  final double minZoom;
  final double maxZoom;
  final List<MapSeatModel> selectedSeats;
  final Function(MapSeatModel seat) onTapSeat;
  final Function(Offset seatPosition, double scaleChangeeats) zoomToSeat;
  final Function(Offset position, double scaleChange) zoomAtMouse;
  final Function(ScaleUpdateDetails details) onScaleUpdate;

  @override
  State<SeatMap> createState() => _SeatMapState();
}

class _SeatMapState extends State<SeatMap> {
  bool isLoading = true;
  late String svgContent;
  late XmlDocument document;
  List<MapSeatModel> allSeats = [];
  String hoveredSeatId = '';
  List<MapSeatModel> selectedSeats = [];

  String? hoveredId;
  OverlayEntry? _overlayEntry;
  String hoveredModalId = '';

  @override
  void initState() {
    super.initState();
    selectedSeats = widget.selectedSeats;
    loadSvgContent();
  }

  Future<void> loadSvgContent() async {
    try {
      final rawSvg = await rootBundle.loadString(widget.svgPath);
      setState(() {
        svgContent = rawSvg;
        document = XmlDocument.parse(svgContent);
        _parseSvgAndExtractAllSeats();
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load SVG: $e');
    }
  }

  void _parseSvgAndExtractAllSeats() {
    allSeats.clear();
    for (var element in document.findAllElements('circle')) {
      try {
        final cx = double.tryParse(element.getAttribute('cx') ?? '0') ?? 0.0;
        final cy = double.tryParse(element.getAttribute('cy') ?? '0') ?? 0.0;
        final r = double.tryParse(element.getAttribute('r') ?? '0') ?? 0.0;
        final id = element.getAttribute('id') ?? '';

        if (id.isNotEmpty) {
          allSeats.add(MapSeatModel(
              image: null,
              dealScore: null,
              price: null,
              row: null,
              seatNumber: null,
              sectionName: null,
              seatX: cx,
              seatY: cy,
              seatR: r,
              seatId: id));
        }
      } catch (e) {
        debugPrint('Error parsing seat element: $e');
      }
    }
  }

  void _showSeatModal(
      BuildContext context,
      Offset seatPosition,
      String seatId,
      String seatNumber,
      String rowNumber,
      String section,
      String currency,
      String price,
      double mapWidth,
      Function() onSelectSeat) {
    // reset previus modal
    _overlayEntry?.remove();
    _overlayEntry = null;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        // Calculate modal position to be above the seat
        final double modalWidth = 200;
        final double modalHeight = 100;
        final Size screenSize = MediaQuery.of(context).size;

        double left = seatPosition.dx - modalWidth / 2;
        double top = screenSize.width < 1100
            ? seatPosition.dy - modalHeight - 100
            : seatPosition.dy - modalHeight - 70;

        // Ensure the modal is within screen bounds
        if (left < 0) left = 0;
        if (left + modalWidth > mapWidth) {
          left = mapWidth - modalWidth;
        }
        if (top < 0) top = seatPosition.dy + 20;

        return Positioned(
          left: left,
          top: top,
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                hoveredModalId = seatId;
              });
            },
            onExit: (_) {
              setState(() {
                hoveredModalId = '';
              });
              _removeSeatModal(seatId);
            },
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => _overlayEntry?.remove(),
                child: Container(
                  width: modalWidth,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appColors.bgPrimary,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 5),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Seats info',
                            style: Theme.of(context)
                                .appTexts
                                .textMdSemiBold
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textPrimary900)),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Section: ',
                              style: Theme.of(context)
                                  .appTexts
                                  .textSmMedium
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .textTeritory600),
                              children: [
                                TextSpan(
                                  text: '$section\n',
                                  style: Theme.of(context)
                                      .appTexts
                                      .textSmMedium
                                      .copyWith(
                                          color: Theme.of(context)
                                              .appColors
                                              .textSecondary700),
                                ),
                                TextSpan(text: 'Row: '),
                                TextSpan(
                                  text: '$rowNumber, ',
                                  style: Theme.of(context)
                                      .appTexts
                                      .textSmMedium
                                      .copyWith(
                                          color: Theme.of(context)
                                              .appColors
                                              .textSecondary700),
                                ),
                                TextSpan(text: 'Seats: '),
                                TextSpan(
                                  text: '$seatNumber\n',
                                  style: Theme.of(context)
                                      .appTexts
                                      .textSmMedium
                                      .copyWith(
                                          color: Theme.of(context)
                                              .appColors
                                              .textSecondary700),
                                ),
                                TextSpan(text: 'Price (Incl. fees): '),
                                TextSpan(
                                  text: '$currency$price',
                                  style: Theme.of(context)
                                      .appTexts
                                      .textSmMedium
                                      .copyWith(
                                          color: Theme.of(context)
                                              .appColors
                                              .textSecondary700),
                                ),
                              ])
                        ])),
                        SizedBox(height: 8.0),
                        AppButton.buttonPrimary(
                            context: context,
                            text: 'Select seat',
                            padding: EdgeInsets.symmetric(vertical: 8),
                            onTap: () {
                              _overlayEntry?.remove();
                              _overlayEntry = null;

                              onSelectSeat();
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeSeatModal(String seatId) {
    if (hoveredModalId != seatId) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  MapSeatModel? _findSeatById(String id) {
    for (var seat in widget.availableSeats) {
      if (seat.seatId == id) {
        return seat;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return isLoading
          ? Container()
          : Stack(
              children: [
                GestureDetector(
                  onScaleUpdate: widget.onScaleUpdate,
                  child: Listener(
                      onPointerSignal: (event) {
                        if (event is PointerScrollEvent) {
                          widget.zoomAtMouse(event.localPosition,
                              event.scrollDelta.dy > 0 ? -0.05 : 0.05);
                        }
                      },
                      child: SvgPainter(
                          size:
                              Size(constraints.maxWidth, constraints.maxHeight),
                          context: context,
                          svgContent: svgContent,
                          hoveredId: hoveredId,
                          selectedSeats: selectedSeats,
                          scaleFactor: widget.scaleFactor,
                          offset: widget.offset,
                          availableSeats: widget.availableSeats,
                          specials: widget.specialSeats,
                          allSeats: allSeats)),
                ),
                ...allSeats.map((seat) {
                  final seatPosition = Offset(
                    seat.seatX * widget.scaleFactor + widget.offset.dx,
                    seat.seatY * widget.scaleFactor + widget.offset.dy - 15,
                  );

                  final MapSeatModel? avaiableSeat = _findSeatById(seat.seatId); // TODO

                  return Positioned(
                      left: seat.seatX * widget.scaleFactor +
                          widget.offset.dx -
                          seat.seatR * widget.scaleFactor,
                      top: seat.seatY * widget.scaleFactor +
                          widget.offset.dy -
                          seat.seatR * widget.scaleFactor,
                      width: seat.seatR * 2 * widget.scaleFactor,
                      height: seat.seatR * 2 * widget.scaleFactor,
                      child: avaiableSeat != null
                          ? MouseRegion(
                              onEnter: (event) {
                                setState(() {
                                  hoveredId = avaiableSeat.seatId;
                                });
                                String seatNumber =
                                    avaiableSeat.seatNumber.toString();
                                String rowNumber = avaiableSeat.row.toString();
                                String section = avaiableSeat.sectionName ?? '';
                                String price = avaiableSeat.price.toString();
                                String currency = widget.currency;

                                if (MediaQuery.of(context).size.width > 1100) {
                                  _showSeatModal(
                                      context,
                                      seatPosition,
                                      seat.seatId,
                                      seatNumber,
                                      rowNumber,
                                      section,
                                      currency,
                                      price,
                                      constraints.maxWidth, () {
                                    widget.onTapSeat(MapSeatModel(
                                        image: avaiableSeat.image,
                                        dealScore: avaiableSeat.dealScore,
                                        price: avaiableSeat.price,
                                        row: avaiableSeat.row,
                                        seatNumber: avaiableSeat.seatNumber,
                                        sectionName: avaiableSeat.sectionName,
                                        seatX: avaiableSeat.seatX,
                                        seatY: avaiableSeat.seatY,
                                        seatR: avaiableSeat.seatR,
                                        seatId: avaiableSeat.seatId));
                                  });
                                }
                              },
                              onExit: (event) {
                                if (hoveredModalId != seat.seatId) {
                                  setState(() {
                                    hoveredId = '';
                                  });
                                  if (MediaQuery.of(context).size.width >
                                      1100) {
                                    // set delay to ensure user inside modal or not
                                    Future.delayed(Duration(milliseconds: 100),
                                        () {
                                      _removeSeatModal(seat.seatId);
                                    });
                                  }
                                }
                              },
                              child: InkWell(
                                  onTap: () {
                                    widget.onTapSeat(MapSeatModel(
                                        image: avaiableSeat.image,
                                        dealScore: avaiableSeat.dealScore,
                                        price: avaiableSeat.price,
                                        row: avaiableSeat.row,
                                        seatNumber: avaiableSeat.seatNumber,
                                        sectionName: avaiableSeat.sectionName,
                                        seatX: avaiableSeat.seatX,
                                        seatY: avaiableSeat.seatY,
                                        seatR: avaiableSeat.seatR,
                                        seatId: avaiableSeat.seatId));

                                    widget.zoomToSeat(
                                        Offset(avaiableSeat.seatX,
                                            avaiableSeat.seatY),
                                        0.2);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                  )),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ));
                }),
              ],
            );
    });
  }
}
