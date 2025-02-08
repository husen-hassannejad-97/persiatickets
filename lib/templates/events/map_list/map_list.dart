import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/nav_drawer.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/repositories/event/models/header_navigation_model.dart';
import 'package:billit_now/repositories/event_map/models/map_model.dart';
import 'package:billit_now/repositories/event_map/models/sort_filter.dart';
import 'package:billit_now/templates/events/widgets/header_navigation.dart';
import 'package:billit_now/templates/events/map_list/header_selection_section.dart';
import 'package:billit_now/templates/events/map_list/seat_map.dart';
import 'package:billit_now/templates/events/map_list/select_section.dart';
import 'package:billit_now/templates/events/widgets/header_step.dart';
import 'package:billit_now/templates/events/widgets/seat_selection_modal.dart';
import 'package:flutter/material.dart';
import 'package:zoomable_interactive_viewer/zoomable_interactive_viewer.dart';

class MapListPage extends StatefulWidget {
  MapListPage({super.key});

  @override
  State<MapListPage> createState() => _MapListPageState();
}

class _MapListPageState extends State<MapListPage> {
  List<MapSeatModel> seats = [
    MapSeatModel(
      seatId: '1001001',
      seatNumber: 1,
      row: 1,
      sectionName: 'Front Right 1',
      price: 300,
      image: 'assets/images/sections.png',
      dealScore: 10,
      seatX: 1668.6,
      seatY: 409.8,
      seatR: 12,
    ),
    MapSeatModel(
      seatId: '1001001003',
      seatNumber: 3,
      row: 1,
      sectionName: 'Front Right 1',
      price: 500,
      image: 'assets/images/sections.png',
      dealScore: 9,
      seatX: 1620,
      seatY: 432.1,
      seatR: 12,
    ),
    MapSeatModel(
      seatId: '1003001006',
      seatNumber: 45,
      row: 1,
      sectionName: 'Front Center',
      price: 700,
      image: 'assets/images/sections.png',
      dealScore: 4,
      seatX: 1077.6,
      seatY: 528,
      seatR: 12,
    ),
    MapSeatModel(
      seatId: '1001001002',
      seatNumber: 2,
      row: 1,
      sectionName: 'Front Right 1',
      price: 400,
      image: 'assets/images/sections.png',
      dealScore: 1,
      seatX: 1644.8,
      seatY: 422,
      seatR: 12,
    ),
    MapSeatModel(
      seatId: '1001001004',
      seatNumber: 4,
      row: 1,
      sectionName: 'Front Right 1',
      price: 600,
      image: 'assets/images/sections.png',
      dealScore: 5,
      seatX: 1595.1,
      seatY: 442.3,
      seatR: 12,
    ),
    MapSeatModel(
      seatId: '1003001004',
      seatNumber: 43,
      row: 1,
      sectionName: 'Front Center',
      price: 800,
      image: 'assets/images/sections.png',
      dealScore: 7,
      seatX: 1132.9,
      seatY: 528,
      seatR: 12,
    ),
    MapSeatModel(
      seatId: '1002017001',
      seatNumber: 20,
      row: 17,
      sectionName: 'Front Right 2',
      price: 800,
      image: 'assets/images/sections.png',
      dealScore: 4,
      seatX: 1710.7,
      seatY: 1076.2,
      seatR: 12,
    ),
    MapSeatModel(
      seatId: '1002017005',
      seatNumber: 24,
      row: 17,
      sectionName: 'Front Right 2',
      price: 900,
      image: 'assets/images/sections.png',
      dealScore: 8,
      seatX: 1686.5,
      seatY: 1083.8,
      seatR: 12,
    ),
  ];
  List<MapSeatModel> _seatsToDisplay = [];
  List<MapSpecialSeatModel> specialSeats = [
    MapSpecialSeatModel(id: '1002017001', special: Special.wheelchairServices),
    MapSpecialSeatModel(id: '1002017002', special: Special.wheelchairServices),
    MapSpecialSeatModel(id: '1002017003', special: Special.wheelchairServices),
    MapSpecialSeatModel(id: '1002017004', special: Special.wheelchairServices),
    MapSpecialSeatModel(id: '1002017005', special: Special.wheelchairServices),
  ];
  late bool _isLiked = false;
  late bool _accessibilityIsApplyed = false;
  late bool _isFeesCaculationOn = true;

  @override
  initState() {
    super.initState();
    _initSeatsValue(seats);
    _isLiked = false;
    _accessibilityIsApplyed = false;
    _isFeesCaculationOn = true;
  }

  @override
  Widget build(BuildContext context) {
    return MapList(
        data: MapModel(
            svgPath: 'assets/svg/wienerStadthalleHallF-v2.0.svg',
            title: 'EBI live in Vienna',
            isLiked: _isLiked,
            date: DateTime(2025, 2, 25, 19, 00),
            location: 'Wiener Stadthalle, Hall F',
            startPrice: 256,
            endPrice: 1728,
            currency: '\$',
            seats: _seatsToDisplay,
            specialSeats: specialSeats),
        onTapLike: (bool isLiked) => _likeEvent(isLiked),
        accessibilityIsApplyed: _accessibilityIsApplyed,
        onApplyAccessibility: (bool isApplied) =>
            _setAccessibilityOnOff(isApplied, seats, specialSeats),
        isFeesCalculateOn: _isFeesCaculationOn,
        onFeesCalculateChanged: (bool value) => _setCalculateFeesOnOff(value),
        onMinMaxPriceChanged: (double min, double max) =>
            _getSeatsByPriceRange(min, max, seats),
        onClearMinMaxPrice: () => _clearPriceRange(seats),
        onApplySortFilter: (SortFilter filter) => _sortByFilter(filter));
  }

  _initSeatsValue(List<MapSeatModel> seats) {
    _seatsToDisplay = seats;
    setState(() {
      // sort lowest price for initial
      _seatsToDisplay = List.from(seats)
        ..sort((a, b) {
          if (a.price == null || b.price == null) {
            return 0;
          }
          return a.price!.compareTo(b.price!.toInt());
        });
    });
  }

  _sortByFilter(SortFilter filter) {
    switch (filter) {
      case SortFilter.lowestPrice:
        setState(() {
          _seatsToDisplay = List.from(seats)
            ..sort((a, b) {
              if (a.price == null || b.price == null) {
                return 0;
              }
              return a.price!.compareTo(b.price!.toInt());
            });
        });
        break;
      case SortFilter.highestPrice:
        setState(() {
          _seatsToDisplay = List.from(seats)
            ..sort((a, b) {
              if (a.price == null || b.price == null) {
                return 0;
              }
              return b.price!.compareTo(a.price!.toInt());
            });
        });
        break;
      case SortFilter.highestSealScore:
        setState(() {
          _seatsToDisplay = List.from(seats)
            ..sort((a, b) {
              if (a.dealScore == null || b.dealScore == null) {
                return 0;
              }
              return b.dealScore!.compareTo(a.dealScore as num);
            });
        });
        break;
      case SortFilter.lowestSealScore:
        setState(() {
          _seatsToDisplay = List.from(seats)
            ..sort((a, b) {
              if (a.dealScore == null || b.dealScore == null) {
                return 0;
              }
              return a.dealScore!.compareTo(b.dealScore as num);
            });
        });
        break;
      default:
    }
  }

  _likeEvent(bool isLiked) {
    setState(() {
      _isLiked = isLiked;
    });
  }

  _setCalculateFeesOnOff(bool value) {
    setState(() {
      _isFeesCaculationOn = value;
    });
  }

  _setAccessibilityOnOff(bool value, List<MapSeatModel> seats,
      List<MapSpecialSeatModel> specialSeats) {
    setState(() {
      _accessibilityIsApplyed = value;
    });

    if (_accessibilityIsApplyed) {
      _seatsToDisplay = seats.where((seat) {
        return specialSeats.any((specialSeat) => specialSeat.id == seat.seatId);
      }).toList();
    } else {
      _initSeatsValue(seats);
    }
  }

  _getSeatsByPriceRange(double min, double max, List<MapSeatModel> seats) {
    setState(() {
      _seatsToDisplay = _seatsToDisplay.where((seat) {
        return seat.price == null
            ? false
            : seat.price! <= max && seat.price! >= min;
      }).toList();
    });
  }

  _clearPriceRange(List<MapSeatModel> seats) {
    setState(() {
      _seatsToDisplay = seats;
    });
  }
}

class MapList extends BaseStatefulWidget {
  MapList(
      {super.key,
      required this.data,
      required this.onTapLike,
      required this.accessibilityIsApplyed,
      required this.onApplyAccessibility,
      required this.onMinMaxPriceChanged,
      required this.onClearMinMaxPrice,
      required this.isFeesCalculateOn,
      required this.onFeesCalculateChanged,
      required this.onApplySortFilter});

  final MapModel data;
  final Function(bool isLiked) onTapLike;
  final bool accessibilityIsApplyed;
  final Function(bool isApplied) onApplyAccessibility;
  final Function(double min, double max) onMinMaxPriceChanged;
  final Function() onClearMinMaxPrice;
  final bool isFeesCalculateOn;
  final Function(bool value) onFeesCalculateChanged;
  final Function(SortFilter filter) onApplySortFilter;

  @override
  State<MapList> createState() => _MapList();
}

class _MapList extends BaseWidgetState<MapList> {
  late ScrollController _scrollController;
  late ScrollController _navigationScrollController;

  late Offset initMapOffset;
  late double initMapScalefactor;

  late double
      minMapZoom; // Default minimum zoom, will be calculated dynamically
  late double maxMapZoom; // Maximum zoom level

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _navigationScrollController = ScrollController();

    minMapZoom = 0.1;
    maxMapZoom = 3.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToStepNavigationHeader();
      calculateInitialOffsetAndZoom();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    calculateInitialOffsetAndZoom();
  }

  void calculateInitialOffsetAndZoom() {
    const double svgWidth = 2206.8; // Replace with actual SVG width
    const double svgHeight = 2010.9; // Replace with actual SVG height

    final double widthZoom = context.logicalWidth / svgWidth;
    final double heightZoom = context.logicalHeightSA / svgHeight;
    minMapZoom = widthZoom < heightZoom ? widthZoom : heightZoom;

    // Set the initial scale factor and offset
    setState(() {
      initMapScalefactor = minMapZoom.clamp(minMapZoom, maxMapZoom);
      initMapOffset = context.logicalWidth > 1100
          ? Offset((context.logicalWidth - svgWidth * initMapScalefactor) / 1.5,
              (context.logicalHeightSA - svgHeight * initMapScalefactor) / 1.5)
          : Offset((context.logicalWidth - svgWidth * initMapScalefactor) / 5,
              (context.logicalHeightSA - svgHeight * initMapScalefactor) / 5);
    });
  }

  void scrollToStepNavigationHeader() {
    _navigationScrollController.animateTo(
      100.0,
      duration: Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void calculateMinZoom() {
    const double svgWidth = 2206.8; // Replace with actual SVG width
    const double svgHeight = 2010.9; // Replace with actual SVG height
    final Size screenSize = MediaQuery.of(context).size;

    final double widthZoom = screenSize.width / svgWidth;
    final double heightZoom = screenSize.height / svgHeight;
    minMapZoom = widthZoom < heightZoom ? widthZoom : heightZoom;

    setState(() {
      initMapScalefactor = minMapZoom.clamp(minMapZoom, maxMapZoom);
      initMapOffset = Offset(
          (screenSize.width - svgWidth * initMapScalefactor) / 2,
          (screenSize.height - svgHeight * initMapScalefactor) / 2);
    });
  }

  void _zoomIn() {
    setState(() {
      initMapScalefactor =
          (initMapScalefactor + 0.1).clamp(minMapZoom, maxMapZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      initMapScalefactor =
          (initMapScalefactor - 0.1).clamp(minMapZoom, maxMapZoom);
    });
  }

  void _zoomAtMouse(Offset position, double scaleChange) {
    setState(() {
      final newScaleFactor =
          (initMapScalefactor + scaleChange).clamp(minMapZoom, maxMapZoom);
      if (newScaleFactor != initMapScalefactor) {
        final scaleDiff = newScaleFactor / initMapScalefactor;
        initMapOffset = Offset(
          initMapOffset.dx - (position.dx - initMapOffset.dx) * (scaleDiff - 1),
          initMapOffset.dy - (position.dy - initMapOffset.dy) * (scaleDiff - 1),
        );
        initMapScalefactor = newScaleFactor;
      }
    });
  }

  void _zoomToSeat(Offset seatPosition, double scaleChange) {
    setState(() {
      double? newScaleFactor;

      if (initMapScalefactor < 0.32) {
        newScaleFactor =
            (initMapScalefactor + scaleChange).clamp(minMapZoom, maxMapZoom);
      } else {
        newScaleFactor = initMapScalefactor;
      }

      if (newScaleFactor != initMapScalefactor) {
        final scaleDiff = newScaleFactor / initMapScalefactor;
        initMapOffset = Offset(
          (initMapOffset.dx -
                  (seatPosition.dx - initMapOffset.dx) * (scaleDiff - 1)) +
              400,
          initMapOffset.dy -
              (seatPosition.dy - initMapOffset.dy) * (scaleDiff - 1) +
              300,
        );

        initMapScalefactor = newScaleFactor;
      }
    });
  }

  _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      initMapScalefactor =
          (initMapScalefactor * details.scale).clamp(minMapZoom, maxMapZoom);
      initMapOffset += details.focalPointDelta;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _navigationScrollController.dispose();
    super.dispose();
  }

  List<HeaderNavigationModel> headerNavigationSteps = [
    HeaderNavigationModel(
        title: 'Select Date & Time', isDone: true, isHover: false),
    HeaderNavigationModel(title: 'Select Seats', isDone: false, isHover: true),
    HeaderNavigationModel(
        title: 'User Info & Invoice', isDone: false, isHover: false),
    HeaderNavigationModel(title: 'Payment', isDone: false, isHover: false),
    HeaderNavigationModel(title: 'Tickets', isDone: false, isHover: false)
  ];
  List<MapSeatModel> selectedSeats = [];

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      endDrawer: context.logicalWidth < 1100 ? const NavDrawer() : null,
      backgroundColor: Theme.of(context).appColors.bgPrimary,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: context.logicalWidth),
            height: context.logicalHeightSA,
            child: context.logicalWidth < 1100
                ? Stack(
                    children: [
                      ListView(
                        controller: _scrollController,
                        children: [
                          // Steps
                          Padding(
                            padding: EdgeInsets.only(top: 70.0),
                            child: SizedBox(
                              height: 40,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: _navigationScrollController,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    headerNavigationSteps.length,
                                    (int index) => HeaderStep(
                                      index: index,
                                      step: headerNavigationSteps[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12.0),
                            child: _sectionHeader(
                              widget.data.title,
                              widget.data.isLiked,
                              widget.data.date,
                              widget.data.location,
                              widget.data.startPrice,
                              widget.data.endPrice,
                              widget.data.currency,
                              widget.onTapLike,
                              widget.accessibilityIsApplyed,
                              widget.onApplyAccessibility,
                              widget.data.startPrice,
                              widget.data.endPrice,
                              widget.onMinMaxPriceChanged,
                              widget.onClearMinMaxPrice,
                              widget.isFeesCalculateOn,
                              widget.onFeesCalculateChanged,
                            ),
                          ),
                          // seat map
                          SizedBox(
                            width: context.logicalWidth,
                            height: context.logicalHeight / 2,
                            child: _seatMap(
                              initMapOffset,
                              initMapScalefactor,
                              widget.data.svgPath,
                              widget.data.currency,
                              widget.data.seats,
                              selectedSeats,
                              widget.data.specialSeats,
                              _zoomToSeat,
                              _zoomAtMouse,
                              _onScaleUpdate,
                            ),
                          ),
                          // Seats items
                          _selectSections(
                            widget.onApplySortFilter,
                            (MapSeatModel seat) {
                              _zoomToSeat(Offset(seat.seatX, seat.seatY), 0.2);
                              if (!selectedSeats.contains(seat)) {
                                setState(() {
                                  selectedSeats.add(seat);
                                });
                              }
                            },
                            widget.data.currency,
                            widget.data.seats,
                          ),
                        ],
                      ),
                      _headerNavigation(),
                      selectedSeats.isNotEmpty
                          ? Positioned(
                              right: context.logicalWidth > 700 ? 10 : 0,
                              bottom: context.logicalWidth > 700 ? 10 : 0,
                              left: context.logicalWidth > 700 ? null : 0,
                              child: SeatSelectionModal(
                                currency: widget.data.currency,
                                selectedSeats: selectedSeats,
                                onRemoveSeat: (int index) {
                                  setState(() {
                                    selectedSeats.removeAt(index);
                                  });
                                },
                              ),
                            )
                          : Container(),
                    ],
                  )
                : Stack(
                    children: [
                      _seatMap(
                        initMapOffset,
                        initMapScalefactor,
                        widget.data.svgPath,
                        widget.data.currency,
                        widget.data.seats,
                        selectedSeats,
                        widget.data.specialSeats,
                        _zoomToSeat,
                        _zoomAtMouse,
                        _onScaleUpdate,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 450,
                          height: context.logicalHeightSA,
                          child: ListView(
                            children: [
                              _sectionHeader(
                                widget.data.title,
                                widget.data.isLiked,
                                widget.data.date,
                                widget.data.location,
                                widget.data.startPrice,
                                widget.data.endPrice,
                                widget.data.currency,
                                widget.onTapLike,
                                widget.accessibilityIsApplyed,
                                widget.onApplyAccessibility,
                                widget.data.startPrice,
                                widget.data.endPrice,
                                widget.onMinMaxPriceChanged,
                                widget.onClearMinMaxPrice,
                                widget.isFeesCalculateOn,
                                widget.onFeesCalculateChanged,
                              ),
                              Divider(
                                color:
                                    Theme.of(context).appColors.borderSecondary,
                                height: 1,
                              ),
                              // Seats items
                              _selectSections(
                                widget.onApplySortFilter,
                                (MapSeatModel seat) {
                                  _zoomToSeat(
                                      Offset(seat.seatX, seat.seatY), 0.2);
                                  if (!selectedSeats.contains(seat)) {
                                    setState(() {
                                      selectedSeats.add(seat);
                                    });
                                  }
                                },
                                widget.data.currency,
                                widget.data.seats,
                              ),
                            ],
                          ),
                        ),
                      ),
                      _headerNavigation(),
                      selectedSeats.isNotEmpty
                          ? Positioned(
                              right: 10,
                              bottom: 10,
                              child: SeatSelectionModal(
                                currency: widget.data.currency,
                                selectedSeats: selectedSeats,
                                onRemoveSeat: (int index) {
                                  setState(() {
                                    selectedSeats.removeAt(index);
                                  });
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _seatMap(
    Offset offset,
    double scaleFactor,
    String svgPath,
    String currency,
    List<MapSeatModel> seats,
    List<MapSeatModel> selectedSeats,
    List<MapSpecialSeatModel> specialSeats,
    Function(Offset seatPosition, double scaleChangeeats) zoomToSeat,
    Function(Offset position, double scaleChange) zoomAtMouse,
    Function(ScaleUpdateDetails details) onScaleUpdate,
  ) =>
      Stack(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: context.logicalWidth),
            height: context.logicalHeightSA,
            decoration: BoxDecoration(
              color: Theme.of(context).appColors.bgSecondary,
            ),
            child: ZoomableInteractiveViewer(
              child: SeatMap(
                offset: offset,
                scaleFactor: scaleFactor,
                svgPath: svgPath,
                currency: currency,
                availableSeats: seats,
                specialSeats: specialSeats,
                maxZoom: maxMapZoom,
                minZoom: minMapZoom,
                selectedSeats: selectedSeats,
                onTapSeat: (MapSeatModel seat) {
                  if (!selectedSeats.contains(seat)) {
                    setState(() {
                      selectedSeats.add(seat);
                    });
                  }
                },
                zoomToSeat: zoomToSeat,
                zoomAtMouse: zoomAtMouse,
                onScaleUpdate: onScaleUpdate,
              ),
            ),
          ),
          Positioned(
              right: 10,
              top: context.logicalWidth > 1100 ? 70 : 10,
              child: AppButton.buttonIcon(AppIconName.circle,
                  bgColor: Theme.of(context).appColors.bgPrimary,
                  bgHoverColor: Theme.of(context).appColors.bgPrimary,
                  textColor: Colors.transparent,
                  padding: EdgeInsets.all(12.0),
                  context: context,
                  onTap: () => calculateInitialOffsetAndZoom()))
        ],
      );

  Widget _sectionHeader(
    String title,
    bool isLiked,
    DateTime date,
    String location,
    double startPrice,
    double endPrice,
    String currency,
    Function(bool isLiked) onTapLike,
    bool accessibilityIsApplyed,
    Function(bool isApplied) onApplyAccessibility,
    double minPrice,
    double maxPrice,
    Function(double min, double max) onMinMaxPriceChanged,
    Function() onClearMinMaxPrice,
    bool isFeesCalculateOn,
    Function(bool value) onFeesCalculateChanged,
  ) =>
      HeaderSelectionSection(
        title: title,
        isLiked: isLiked,
        date: date,
        location: location,
        startPrice: startPrice,
        endPrice: endPrice,
        currency: currency,
        onTapLike: onTapLike,
        accessibilityIsApplyed: accessibilityIsApplyed,
        onApplyAccessibility: onApplyAccessibility,
        minPrice: minPrice,
        maxPrice: maxPrice,
        onMinMaxPriceChanged: onMinMaxPriceChanged,
        onClearMinMaxPrice: onClearMinMaxPrice,
        isFeesCalculateOn: isFeesCalculateOn,
        onFeesCalculateChanged: onFeesCalculateChanged,
      );

  Widget _selectSections(
    Function(SortFilter filter) onApplySortFilter,
    Function(MapSeatModel seat) onSelectSeat,
    String currency,
    List<MapSeatModel> seats,
  ) =>
      SelectSection(
        onApplySortFilter: onApplySortFilter,
        currency: currency,
        seats: seats,
        onSelectSeat: onSelectSeat,
      );

  Widget _headerNavigation() => HeaderNavigation(
        scrollController: _scrollController,
        steps: headerNavigationSteps,
      );
}
