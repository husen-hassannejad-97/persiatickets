import '../../base/base_model.dart';

class TicketsModel implements BaseModel {
  final String pdfLink;
  final List<TicketModel> tickets;

  TicketsModel({required this.pdfLink, required this.tickets});
}

class TicketModel implements BaseModel {
  final String id;
  final String eventTitle;
  final String location;
  final DateTime date;
  final String block;
  final int row;
  final int seat;
  final String qrCode;
  final List<String> sponsorsLogo;

  TicketModel(
      {required this.id,
      required this.eventTitle,
      required this.location,
      required this.date,
      required this.block,
      required this.row,
      required this.seat,
      required this.qrCode,
      required this.sponsorsLogo});
}
