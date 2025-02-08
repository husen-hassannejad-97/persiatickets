import 'package:shared_preferences/shared_preferences.dart';

class EventData {
  const EventData({
    required this.eventImage,
      required this.organizer,
      required this.title,
      required this.subTitle,
      required this.startDate,
      required this.endDate,
      required this.location,
    required this.id,
  });

  final String id;
  final String eventImage;
  final String organizer;
  final String title;
  final String subTitle;
  final DateTime startDate;
  final DateTime endDate;
  final String location;

  void saveOnStorage(Function() done) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('EventData_id', id);
    await prefs.setString('EventData_eventImage', eventImage);
    await prefs.setString('EventData_organizer', organizer);
    await prefs.setString('EventData_title', title);
    await prefs.setString('EventData_subTitle', subTitle);
    await prefs.setString('EventData_startDate', startDate.toIso8601String());
    await prefs.setString('EventData_endDate', endDate.toIso8601String());
    await prefs.setString('EventData_location', location);
    done();
  }

  static Future<EventData> retrieveFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return EventData(
      id: prefs.getString('EventData_id') ?? "",
      eventImage: prefs.getString('EventData_eventImage') ?? "",
      organizer: prefs.getString('EventData_organizer') ?? "",
      title: prefs.getString('EventData_title') ?? "",
      subTitle: prefs.getString('EventData_subTitle') ?? "",
      startDate: DateTime.parse(prefs.getString('EventData_startDate') ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(prefs.getString('EventData_endDate') ?? DateTime.now().toIso8601String()),
      location: prefs.getString('EventData_location') ?? "",
    );
  }

}
