import '../../base/base_model.dart';

class MapModel implements BaseModel {
  final String svgPath;
  final String title;
  final bool isLiked;
  final DateTime date;
  final String location;
  final double startPrice;
  final double endPrice;
  final String currency;
  final List<MapSeatModel> seats;
  final List<MapSpecialSeatModel> specialSeats;

  MapModel(
      {required this.svgPath,
      required this.title,
      required this.isLiked,
      required this.date,
      required this.location,
      required this.startPrice,
      required this.endPrice,
      required this.currency,
      required this.seats,
      required this.specialSeats});
}

class MapSeatModel implements BaseModel {
  final String? image;
  final int? dealScore;
  final double? price;
  final int? row;
  final int? seatNumber;
  final String? sectionName;
  final double seatX;
  final double seatY;
  final double seatR;
  final String seatId;

  MapSeatModel(
      {required this.image,
      required this.dealScore,
      required this.price,
      required this.row,
      required this.seatNumber,
      required this.sectionName,
      required this.seatX,
      required this.seatY,
      required this.seatR,
      required this.seatId});
}

class MapSpecialSeatModel implements BaseModel {
  final String id;
  final Special special;

  MapSpecialSeatModel({required this.id, required this.special});
}

enum Special {
  vipServices('VIP Services'),
  wheelchairServices('Wheelchair Services');

  // Property to hold the string value
  final String title;
  const Special(this.title);
}

enum Deal {
  amazingDeal('Amazing Deal'),
  greatDeals('Great Deal'),
  goodDeals('Good Deal'),
  okayDeals('Okay Deal'),
  moderatePrices('Moderate Price'),
  deluxePrices('Deluxe Price');

  // Property to hold the string value
  final String title;
  const Deal(this.title);
}
