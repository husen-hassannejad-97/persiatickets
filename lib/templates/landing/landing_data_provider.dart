
import 'package:billit_now/repositories/event/models/event_range_model.dart';

import '../../apps/helper/event_status.dart';


final List<Map<String, String>> tabsInfo = [
  {
    'title': 'Concert',
    'video': 'assets/videos/concert.mov',
    'thumbnail': 'assets/images/concert_hall_with_people_landscape.png'
  },
  {
    'title': 'Theater',
    'video': 'assets/videos/theater.mov',
    'thumbnail': 'assets/images/theater-thumbnail.png'
  },
  {
    'title': 'Cinema',
    'video': 'assets/videos/cinema.mov',
    'thumbnail': 'assets/images/cinema-thumbnail.png'
  },
  {
    'title': 'Standup Comedy',
    'video': 'assets/videos/standup-comedy.mov',
    'thumbnail': 'assets/images/standup-comedy-thumbnail.png'
  },
  {
    'title': 'Party',
    'video': 'assets/videos/party.mov',
    'thumbnail': 'assets/images/party-thumbnail.png'
  },
];
List<Map<String, dynamic>> provideCountriesList() => [
  {
    'alpha2Code': 'at',
    'fullName': 'Austria',
    'cities': ['Viena']
  },
  {
    'alpha2Code': 'de',
    'fullName': 'Germany',
    'cities': ['Berlin', 'Frankfurt', 'Munich']
  },
];
final List<Map<String, String>> footerBtns = [
  {'title': 'Events', 'link': ''},
  {'title': 'Artists', 'link': ''},
  {'title': 'Venues', 'link': ''},
  {'title': 'Help center', 'link': ''},
  {'title': 'About', 'link': ''},
  {'title': 'Contacts', 'link': ''},
  {'title': 'Privacy policy', 'link': ''}
];
final List<Map<String, String>> filterTabs = [
  {'title': 'Any dates'},
  {'title': 'This weekend'},
  {'title': 'This week'},
  {'title': 'Next week'},
  {'title': 'This month'},
  {'title': 'Next month'},
  {'title': 'This year'},
];
final List<EventRangeModel> filterTabRanges = [
  EventRangeModel.any_dates,
  EventRangeModel.this_weekend,
  EventRangeModel.this_week,
  EventRangeModel.next_week,
  EventRangeModel.this_month,
  EventRangeModel.next_month,
  EventRangeModel.this_year,
];
final List<Map<String, dynamic>> highlightEvents = [
  {
    'image': 'assets/images/ebi.png',
    'status': EventStatus.extended,
    'date': 'Sat, 2 March 2025',
    'start-date': 'Sat, 15. Mar 2024  -',
    'end-date': 'Mon, 17. Mar 2024',
    'time': '20:00 - 23:00',
    'title': 'Ebi live in Vienna',
    'location': 'Musikverein, Vienna, Austria',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/test_image.png',
    'status': EventStatus.extended,
    'date': 'Nov 21',
    'start-date': 'Sat, 15. Mar 2024  -',
    'end-date': 'Mon, 17. Mar 2024',
    'time': '20:00 - 23:00',
    'title': 'Behnam Bani live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/googoosh-on-stage.jpeg',
    'status': EventStatus.completing,
    'date': 'Dec 12',
    'start-date': 'Sat, 15. Mar 2024  -',
    'end-date': 'Mon, 17. Mar 2024',
    'time': '20:00 - 23:00',
    'title': 'Googoosh live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/Hamlet_drama.webp',
    'status': EventStatus.completing,
    'date': 'Dec 15',
    'start-date': 'Sat, 15. Mar 2024  -',
    'end-date': 'Mon, 17. Mar 2024',
    'time': '20:00 - 23:00',
    'title': 'Hamlet drama in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/gorbani.jpg',
    'status': EventStatus.comingSoon,
    'date': 'Dec 20',
    'start-date': 'Sat, 15. Mar 2024  -',
    'end-date': 'Mon, 17. Mar 2024',
    'time': '20:00 - 23:00',
    'title': 'Alireza Ghorbani live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
];
final List<Map<String, dynamic>> concertItems = [
  {
    'image': 'assets/images/ebi.png',
    'status': EventStatus.extended,
    'date': 'Sat, 2 March 2025',
    'time': '20:00 - 23:00',
    'title': 'Ebi live in Vienna',
    'location': 'Musikverein, Vienna, Austria',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/test_image.png',
    'status': EventStatus.extended,
    'date': 'Nov 21',
    'time': '20:00 - 23:00',
    'title': 'Behnam Bani live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/googoosh-on-stage.jpeg',
    'status': EventStatus.completing,
    'date': 'Dec 12',
    'time': '20:00 - 23:00',
    'title': 'Googoosh live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/Hamlet_drama.webp',
    'status': EventStatus.completing,
    'date': 'Dec 15',
    'time': '20:00 - 23:00',
    'title': 'Hamlet drama in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/test_image.png',
    'status': EventStatus.extended,
    'date': 'Nov 21',
    'time': '20:00 - 23:00',
    'title': 'Behnam Bani live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/googoosh-on-stage.jpeg',
    'status': EventStatus.completing,
    'date': 'Dec 12',
    'time': '20:00 - 23:00',
    'title': 'Googoosh live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/Hamlet_drama.webp',
    'status': EventStatus.completing,
    'date': 'Dec 15',
    'time': '20:00 - 23:00',
    'title': 'Hamlet drama in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/gorbani.jpg',
    'status': EventStatus.comingSoon,
    'date': 'Dec 20',
    'time': '20:00 - 23:00',
    'title': 'Alireza Ghorbani live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
];
final List<Map<String, dynamic>> theaterItems = [
  {
    'image': 'assets/images/11721_photo.jpg',
    'status': EventStatus.extended,
    'date': 'Sat, 2 March 2025',
    'time': '20:00 - 23:00',
    'title': 'Ebi live in Vienna',
    'location': 'Behnam Bani live in Vienna',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/imm-chiara-iran-1.jpg',
    'status': EventStatus.extended,
    'date': 'Nov 21',
    'time': '20:00 - 23:00',
    'title': 'Female drama in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/Hamlet_drama.webp',
    'status': EventStatus.completing,
    'date': 'Dec 15',
    'time': '20:00 - 23:00',
    'title': 'Hamlet drama in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/ebi.png',
    'status': EventStatus.completing,
    'date': 'Dec 12',
    'time': '20:00 - 23:00',
    'title': 'Ebi live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/11721_photo.jpg',
    'status': EventStatus.extended,
    'date': 'Sat, 2 March 2025',
    'time': '20:00 - 23:00',
    'title': 'Ebi live in Vienna',
    'location': 'Behnam Bani live in Vienna',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/imm-chiara-iran-1.jpg',
    'status': EventStatus.extended,
    'date': 'Nov 21',
    'time': '20:00 - 23:00',
    'title': 'Female drama in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/Hamlet_drama.webp',
    'status': EventStatus.completing,
    'date': 'Dec 15',
    'time': '20:00 - 23:00',
    'title': 'Hamlet drama in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/ebi.png',
    'status': EventStatus.completing,
    'date': 'Dec 12',
    'time': '20:00 - 23:00',
    'title': 'Ebi live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/gorbani.jpg',
    'status': EventStatus.comingSoon,
    'date': 'Dec 20',
    'time': '20:00 - 23:00',
    'title': 'Alireza Ghorbani live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
];
final List<Map<String, dynamic>> spotlights = [
  {
    'brand_name': 'R-MONEY',
    'id': 'rmoney.eu',
    'brand_image': 'assets/images/r_money.png',
    'ads': [
      {
        'image': 'assets/images/1.png',
        'description':
        ' The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing.',
        'page': '1'
      },
      {
        'image': 'assets/images/2.png',
        'description':
        ' The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing.',
        'page': '2'
      },
      {
        'image': 'assets/images/3.png',
        'description':
        ' The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing.',
        'page': '3'
      },
      {
        'image': 'assets/images/4.png',
        'description':
        ' The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing.',
        'page': '4'
      },
    ]
  },
  {
    'brand_name': 'X-MONEY ',
    'id': 'xmoney.eu',
    'brand_image': 'assets/images/x_money.png',
    'ads': [
      {
        'image': 'assets/images/4.png',
        'description':
        'rmoney.eu The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing. In this p. We are examining different phases of this project and its challenges.',
        'page': '1'
      },
      {
        'image': 'assets/images/8.png',
        'description':
        'rmoney.eu The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing. In this p. We are examining different phases of this project and its challenges.',
        'page': '2'
      },
      {
        'image': 'assets/images/6.png',
        'description':
        'rmoney.eu The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing. In this p. We are examining different phases of this project and its challenges.',
        'page': '3'
      },
      {
        'image': 'assets/images/7.png',
        'description':
        'rmoney.eu The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing. In this p. We are examining different phases of this project and its challenges.',
        'page': '4'
      },
    ]
  },
  {
    'brand_name': 'Y-MONEY',
    'id': 'ymoney.eu',
    'brand_image': 'assets/images/y_money.png',
    'ads': [
      {
        'image': 'assets/images/1.png',
        'description':
        'rmoney.eu The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing. In this p. We are examining different phases of this project and its challenges.',
        'page': '1'
      },
      {
        'image': 'assets/images/6.png',
        'description':
        'rmoney.eu The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing. In this p. We are examining different phases of this project and its challenges.',
        'page': '2'
      },
      {
        'image': 'assets/images/3.png',
        'description':
        'rmoney.eu The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing. In this p. We are examining different phases of this project and its challenges.',
        'page': '3'
      },
      {
        'image': 'assets/images/7.png',
        'description':
        'rmoney.eu The revision project of the Euro plan, whose first phase began in 2021, Is still ongoing. In this p. We are examining different phases of this project and its challenges.',
        'page': '4'
      },
    ]
  },
];
final List<Map<String, dynamic>> popMovies = [
  {
    'image': 'assets/images/4WuCZLk5nnV2blwIrMRWm2Ph5UHmA85czkx7JvYK.webp',
    'status': EventStatus.extended,
    'date': 'Sat, 2 March 2025',
    'time': '20:00 - 23:00',
    'title': 'Ebi live in Vienna',
    'location': 'Musikverein, Vienna, Austria',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/11_53_04asbdif.jpg',
    'status': EventStatus.extended,
    'date': 'Nov 21',
    'time': '20:00 - 23:00',
    'title': 'Behnam Bani live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/Mzyh3P71aN7UjQMXOma5JYccCFETwbAvfdAXNrIa.webp',
    'status': EventStatus.completing,
    'date': 'Dec 12',
    'time': '20:00 - 23:00',
    'title': 'Googoosh live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/q3FF1F7zZM36pkqBp0ukQ5Pve4p2b8tsj65qdeOq.webp',
    'status': EventStatus.completing,
    'date': 'Dec 15',
    'time': '20:00 - 23:00',
    'title': 'Hamlet drama in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
  {
    'image': 'assets/images/ZoodPaz-Poster.jpg',
    'status': EventStatus.comingSoon,
    'date': 'Dec 20',
    'time': '20:00 - 23:00',
    'title': 'Alireza Ghorbani live in Vienna',
    'location': 'Wiener Stadthalle, Hall F',
    'price': '350',
    'link': '',
  },
];