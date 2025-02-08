import '../../base/base_model.dart';

class VenueLocationModel implements BaseModel {
  final String name;
  final String address;
  final double lat;
  final double lon;
  final String overViewDesc;
  final String nearbyAmenitiesDesc;
  final List<GettingThereItems> gettingThereItems;

  VenueLocationModel({
    required this.name,
    required this.address,
    required this.lat,
    required this.lon,
    required this.overViewDesc,
    required this.nearbyAmenitiesDesc,
    required this.gettingThereItems,
  });
}

class GettingThereItems implements BaseModel {
  final String title;
  final List<String> items;

  GettingThereItems({required this.title, required this.items});
}
