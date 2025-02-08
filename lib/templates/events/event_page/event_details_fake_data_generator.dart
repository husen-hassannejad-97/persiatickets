import 'package:billit_now/repositories/event/models/about_artist_model.dart';
import 'package:billit_now/repositories/event/models/cancellation_policy_model.dart';
import 'package:billit_now/repositories/event/models/event_ad_banner_model.dart';
import 'package:billit_now/repositories/event/models/explore_pricing_model.dart';
import 'package:billit_now/repositories/event/models/info_faq_model.dart';
import 'package:billit_now/repositories/event/models/organizer_banner_model.dart';
import 'package:billit_now/repositories/event/models/programs_model.dart';
import 'package:billit_now/repositories/event/models/similar_events_model.dart';
import 'package:billit_now/repositories/event/models/venue_facilities_model.dart';
import 'package:billit_now/repositories/event/models/venue_guidelines_model.dart';
import 'package:billit_now/repositories/event/models/venue_location_model.dart';
import 'package:billit_now/repositories/event/models/what_attendees_say_model.dart';

import '../../../apps/helper/event_status.dart';
import '../../../apps/helper/utils/app_icon_name.dart';
import '../../../repositories/event/models/about_organizer_model.dart';
import '../../../repositories/event/models/programs_status.dart';
import '../../../repositories/event/models/top_music.dart';
import '../../../repositories/event/models/why_persia_tickets_model.dart';

final List<WhyPersiaTicketsModel> fWhysList = [
  WhyPersiaTicketsModel(
      icon: AppIconName.uebe8Phone01.name,
      title: 'Effortless Ticketing Experience',
      desc: 'Receive your e-ticket instantly—Apple Wallet-ready or printable.'),
  WhyPersiaTicketsModel(
      icon: AppIconName.ueb60Bell01.name,
      title: 'Timely Change Notifications',
      desc:
          'Get instant alerts for concert changes. Cancel or switch events if plans no longer suit you.'),
  WhyPersiaTicketsModel(
      icon: AppIconName.uecbbPencil02.name,
      title: 'Booking Adjustments',
      desc:
          'Modify your reservation—seat, date, or quantity—within the allowed change period.'),
  WhyPersiaTicketsModel(
      icon: AppIconName.hours24.name,
      title: 'Unmatched Support',
      desc: '24/7 premium support for prompt issue resolution.')
];

final List<ProgramsModel> fPrograms = [
  ProgramsModel(
    date: DateTime.now(), // TODO Fix
    time: DateTime.now(), // TODO Fix
    status: ProgramsStatus.comingSoon,
    seatsCount: 2000,
    priceRange: '\$120 - \$782',
  ),
  ProgramsModel(
      date: DateTime.now(), // TODO Fix
      time: DateTime.now(), // TODO Fix
      status: ProgramsStatus.completing,
      seatsCount: 30,
      priceRange: '\$120 - \$782'),
  ProgramsModel(
    date: DateTime.now(), // TODO Fix
    time: DateTime.now(), // TODO Fix
    status: ProgramsStatus.completing,
    seatsCount: 5,
    priceRange: '\$120 - \$782',
  ),
];

final AboutArtistModel fAboutArtistModel = AboutArtistModel(
    artistName: 'Ebi',
    about:
        """Ebrahim Hamedi, known better as “Ebi” to his millions of fans across the world. His legendary satin, yet incredibly powerful voice has established Ebi as a Legendary Iranian Singer for the ages. Throughout his 50 year career, Ebi has released over 30 albums, and closer to 100 singles, performed sold out shows across the world, and continuously released an endless string of hits, transcending Ebi’s fan base through 3 generations of Iranians worldwide.
                    Since the Islamic revolution, Ebi’s music has been illegal to play in Iran, yet his audience is ever growing, both inside, and outside of his birth country. This is manifested by 5 decades of touring the globe, performing for millions of fans, selling out some of the most prestigious venues in the world: Royal Albert Hall, Microsoft Theatre L.A Live, Wembley Stadium, Sydney Opera House, Air Canada Center, Globen, Cologne Arena, Sony Center Toronto, Queen Elizabeth Theatre, Greek Theatre Los Angeles, and many many more. """,
    musics: [
      TopMusicModel(
          source: 'assets/musics/Gheseh-Eshgh.mp3',
          name: 'Gheseh Eshgh',
          album: 'Koohe Yakh (Album)'),
      TopMusicModel(
          source: 'assets/musics/Ghalb-Ghaap.mp3',
          name: 'Ghalb Ghaap',
          album: 'Lalehzaar (Album)')
    ]);

final VenueFacilitiesModel fVenueFacilitiesModel = VenueFacilitiesModel(
    name: 'Wiener Stadthalle',
    desc:
        'Wiener Stadthalle offers a comprehensive range of facilities, ensuring a seamless and comfortable experience for all attendees. Below is a curated list of the most notable amenities, with a focus on general welfare services and the specialized offerings of Hall F.',
    facilities: [
      FacilitiesModel(title: 'General Venue Facilities', facilities: [
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Accessibility',
            desc:
                'Fully wheelchair-accessible entrances, seating areas, and restrooms, along with reserved parking for individuals with disabilities.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Parking and Transportation',
            desc:
                'Convenient on-site parking facilities and excellent public transport connections via subway, bus, and tram lines.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Food and Beverage',
            desc:
                'Multiple concession stands and kiosks offering a variety of food and drinks to suit diverse preferences.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Cloakroom Services',
            desc:
                'Secure and complimentary cloakroom facilities to store personal belongings during events.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Restrooms',
            desc:
                'Modern and well-maintained restrooms throughout the venue for visitor convenience.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Customer Support',
            desc:
                'On-site customer service desks for assistance and inquiries.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Safety and Security',
            desc:
                'On-site first aid services and security personnel to ensure a safe event environment.')
      ]),
      FacilitiesModel(title: 'Hall F-Specific Amenities', facilities: [
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Seating Comfort',
            desc:
                'Ergonomic seating with excellent sightlines for an optimal viewing experience.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Acoustics and Lighting',
            desc:
                'State-of-the-art sound and lighting systems designed for concerts, performances, and other live events.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Dedicated Food and Beverage Services',
            desc:
                'Exclusive kiosks and bars catering to Hall F guests, offering quick service during event intermissions.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'VIP Services',
            desc:
                'Premium seating options and access to VIP areas for select events.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Family-Friendly Features',
            desc:
                'Complimentary hearing protection for children and dedicated family seating zones.'),
        FacilityModel(
            icon: AppIconName.hours24.name,
            title: 'Efficient Entry and Exit',
            desc:
                'Streamlined entry points and organized crowd management for a smooth event experience.')
      ])
    ]);

final VenueGuidelinesModel fVenueGuidelinesModel =
    VenueGuidelinesModel(guides: [
  GuidesModel(
      icon: AppIconName.filledCircleCheckDefault.name,
      desc:
          'Doors open at [X time]. Please arrive early to avoid delays and enjoy the full concert experience.'),
  GuidesModel(
      icon: AppIconName.filledCircleCheckDefault.name,
      desc:
          'Your ticket is available via email or mobile. Please ensure you have access to your digital or printed ticket for a smooth entry.'),
  GuidesModel(
      icon: AppIconName.filledCircleCheckDefault.name,
      desc:
          'This event is suitable for ages [X+]. Children under [Y years] must be accompanied by an adult.'),
  GuidesModel(
      icon: AppIconName.filledCircleCheckDefault.name,
      desc:
          'For safety reasons, items such as large bags, professional cameras, and alcohol are not allowed inside.'),
  GuidesModel(
      icon: AppIconName.filledCircleCheckDefault.name,
      desc:
          'Parking is available on-site, or you may use public transportation with nearby stops [X] and [Y].'),
  GuidesModel(
      icon: AppIconName.filledCircleCheckDefault.name,
      desc:
          'We recommend smart casual attire for this event. Please avoid wearing clothing that may obstruct other attendees\' views.')
]);

final CancellationPolicyModel fCancellationPolicyModel =
    CancellationPolicyModel(title: 'Concert Cancellation Policy', policies: [
  CancellationPolicyItemModel(
      icon: AppIconName.hours24.name,
      title: 'From the Organizer',
      description:
          'In case of unforeseen circumstances, users will be notified immediately. Refunds or event substitutions will be offered based on user preferences.'),
  CancellationPolicyItemModel(
      icon: AppIconName.hours24.name,
      title: 'From the User',
      description:
          'Cancellations by users are allowed within [specific days] of booking. Refunds will be issued minus the service fee.')
]);

final WhatAttendeesSayModel fWhatAttendeesSayModel =
    WhatAttendeesSayModel(averageScore: '4.8', comments: [
  CommentModel(
    image: "",
    name: "Cameron",
    score: 4,
    date: DateTime.now(),
    comment:
        'The concert was amazing! The sound quality and stage setup were fantastic, but I wish there were more food options in the hall.',
    organizerResponse: CommentModel(
        image: null,
        name: null,
        score: null,
        date: DateTime.now(),
        comment:
            'Thank you for your feedback. We’re thrilled you enjoyed the venue! We apologize for the delay at entry. To improve your experience, we’re working with the hall to streamline security checks and reduce wait times.'),
  ),
  CommentModel(
    image: "",
    name: "Cameron",
    score: 4,
    date: DateTime.now(),
    comment:
        'The concert was amazing! The sound quality and stage setup were fantastic, but I wish there were more food options in the hall.',
    organizerResponse: CommentModel(
        image: null,
        name: null,
        score: null,
        date: DateTime.now(),
        comment:
            'Thank you for your feedback. We’re thrilled you enjoyed the venue! We apologize for the delay at entry. To improve your experience, we’re working with the hall to streamline security checks and reduce wait times.'),
  ),
  CommentModel(
    image: "",
    name: "Cameron",
    score: 4,
    date: DateTime.now(),
    comment:
        'The concert was amazing! The sound quality and stage setup were fantastic, but I wish there were more food options in the hall.',
    organizerResponse: CommentModel(
        image: null,
        name: null,
        score: null,
        date: DateTime.now(),
        comment:
            'Thank you for your feedback. We’re thrilled you enjoyed the venue! We apologize for the delay at entry. To improve your experience, we’re working with the hall to streamline security checks and reduce wait times.'),
  ),
  CommentModel(
    image: "",
    name: "Cameron",
    score: 5,
    date: DateTime.now(),
    comment:
        'The concert was amazing! The sound quality and stage setup were fantastic, but I wish there were more food options in the hall.',
    organizerResponse: CommentModel(
        image: null,
        name: null,
        score: null,
        date: DateTime.now(),
        comment:
            'Thank you for your feedback. We’re thrilled you enjoyed the venue! We apologize for the delay at entry. To improve your experience, we’re working with the hall to streamline security checks and reduce wait times.'),
  ),
  CommentModel(
    image: "",
    name: "James",
    score: 2.5,
    date: DateTime.now(),
    comment:
        'The concert was amazing! The sound quality and stage setup were fantastic, but I wish there were more food options in the hall.',
    organizerResponse: CommentModel(
        image: null,
        name: null,
        score: null,
        date: DateTime.now(),
        comment:
            'Thank you for your feedback. We’re thrilled you enjoyed the venue! We apologize for the delay at entry. To improve your experience, we’re working with the hall to streamline security checks and reduce wait times.'),
  ),
  CommentModel(
    image: "",
    name: "Cameron",
    score: 4,
    date: DateTime.now(),
    comment:
        'The concert was amazing! The sound quality and stage setup were fantastic, but I wish there were more food options in the hall.',
    organizerResponse: CommentModel(
        image: null,
        name: null,
        score: null,
        date: DateTime.now(),
        comment:
            'Thank you for your feedback. We’re thrilled you enjoyed the venue! We apologize for the delay at entry. To improve your experience, we’re working with the hall to streamline security checks and reduce wait times.'),
  ),
  CommentModel(
    image: "",
    name: "Cameron",
    score: 4,
    date: DateTime.now(),
    comment:
        'The concert was amazing! The sound quality and stage setup were fantastic, but I wish there were more food options in the hall.',
    organizerResponse: CommentModel(
        image: null,
        name: null,
        score: null,
        date: DateTime.now(),
        comment:
            'Thank you for your feedback. We’re thrilled you enjoyed the venue! We apologize for the delay at entry. To improve your experience, we’re working with the hall to streamline security checks and reduce wait times.'),
  ),
]);

final VenueLocationModel fVenueLocationModel = VenueLocationModel(
    name: 'Wiener Stadthalle',
    address: 'Roland-Rainer-Platz 1, 1150 Vienna, Austria',
    lat: 48.2024077,
    lon: 16.3337406,
    overViewDesc:
        "Wiener Stadthalle, located in the heart of Vienna, is Austria's premier multi-functional event venue, hosting world-class concerts, performances, and exhibitions. Its central location ensures easy access for attendees from across the city and beyond.",
    nearbyAmenitiesDesc:
        'Situated in a vibrant area of Vienna, Wiener Stadthalle is surrounded by hotels, cafes, restaurants, and retail shops, providing plenty of options for dining and accommodation.',
    gettingThereItems: [
      GettingThereItems(title: 'By Public Transport:', items: [
        'U-Bahn: U6 (Burggasse-Stadthalle) or U3 (Schweglerstraße).',
        'Tram: Lines 6 and 18 stop at Burggasse-Stadthalle.',
        'Bus: Several bus lines provide convenient access to the venue.'
      ]),
      GettingThereItems(title: 'By Car:', items: [
        'Parking is available at the nearby Stadthalle Garage, offering direct access to the venue.',
        'Electric vehicle charging stations are also available.'
      ]),
      GettingThereItems(title: 'By Bicycle:', items: [
        'Secure bicycle parking is located near the venue for environmentally friendly travel.'
      ]),
    ]);

final AboutOrganizerModel fAboutOrganizerModel = AboutOrganizerModel(
    organizerModel: OrganizerModel(
        organizerImage: 'assets/images/16051981977461.png',
        name: 'Alireza Zolghadri',
        phoneNumber: '+43 650 555 74470',
        emailAddress: 'alireza.zolghadri@gmail.com',
        company: 'Online SIM',
        officeNumber: '+43 350 235 93470',
        address: 'Rittingergasse 24 , 1210 Wien',
        socials: [
      SocialModel(
          icon: AppIconName.whatsapp.name, link: 'https://whatsapp.com/'),
      SocialModel(
          icon: AppIconName.logoFacebook.name,
          link: 'https://www.facebook.com/'),
      SocialModel(
          icon: AppIconName.instagramColor.name,
          link: 'https://www.instagram.com/'),
      SocialModel(icon: AppIconName.x.name, link: 'https://x.com/'),
      SocialModel(
          icon: AppIconName.telegram.name, link: 'https://telegram.org/'),
    ],
        featuredSingers: [
      SingerModel(image: 'assets/images/EbiYasmineAsha2020.jpg', name: 'Ebi'),
      SingerModel(
          image: 'assets/images/EbiYasmineAsha2020.jpg',
          name: 'Ali Zand Vakili'),
      SingerModel(
          image: 'assets/images/EbiYasmineAsha2020.jpg', name: 'Behnam Bahni'),
      SingerModel(
          image: 'assets/images/EbiYasmineAsha2020.jpg',
          name: 'Mohsen Yeganeh'),
    ]));

final InfoFaqModel fInfoFaqModel = InfoFaqModel(
    desc:
        'Ebi, one of the most renowned Iranian pop icons, will perform live at the prestigious Wiener Stadthalle in Vienna, Austria. Fans can look forward to an unforgettable evening filled with timeless classics and soul-stirring performances. This concert is part of Ebi\'s much-anticipated European tour, showcasing his incredible talent and charisma.',
    faqs: [
      FaqModel(
          title: 'How much are Ebi concert tickets?',
          desc:
              'Ticket prices for Ebi\'s concert at Wiener Stadthalle depend on factors like seat location, time of purchase, and demand. Currently, tickets are available starting from €70.'),
      FaqModel(
          title: 'How can I buy Ebi concert tickets?',
          desc:
              'Browse the listings of Ebi concert tickets to select the event date and time you wish to attend. Use popular filters to refine your search by seat location, price, and availability. Once you’ve chosen the perfect concert date, click the "Reserve Ticket" button to view all available tickets. When on the tickets page, explore available seating options using the interactive seat map. Filters allow you to sort by price, seat location, or Persia Tickets’ “Best Value” feature, which highlights the best deals for Ebi concert tickets.'),
      FaqModel(
          title: 'What are Ebi’s European concert dates?',
          desc:
              'Ebi will perform across several iconic venues in Europe. Below are the key dates for his tour:',
          items: [
            'March 15, 2025: London, United Kingdom, at O2 Arena',
            'March 22, 2025: Paris, France, at Accor Arena',
            'March 30, 2025: Vienna, Austria, at Wiener Stadthalle',
            'April 5, 2025: Stockholm, Sweden, at Avicii Arena'
          ]),
      FaqModel(
          title: 'When is Ebi\'s next concert?',
          desc:
              'Ebi’s next concert will take place in Vienna at Wiener Stadthalle on March 30, 2025. Scroll up to view other upcoming dates and locations for Ebi’s European tour.'),
    ]);

final ExplorePricingModel fExplorePricingModel = ExplorePricingModel(
    name: 'Hall F',
    desc:
        'Discover the available seating options for Hall F at Wiener Stadthalle. Browse by section, price, and availability to secure the perfect spot for your concert experience. Select your section and reserve your tickets effortlessly.',
    sections: [
      PricingModel(
        sectionName: 'Section 1-17 Right',
        freeSeatsCount: 50,
        totalSeatsCount: 288,
        startPrice: 720,
        endPrice: 894,
      ),
      PricingModel(
        sectionName: 'Section 1-17 Center',
        freeSeatsCount: 30,
        totalSeatsCount: 200,
        startPrice: 750,
        endPrice: 822,
      ),
      PricingModel(
        sectionName: 'Section 1-17 Left',
        freeSeatsCount: 40,
        totalSeatsCount: 288,
        startPrice: 638,
        endPrice: 942,
      ),
      PricingModel(
        sectionName: 'Section 18-37 Right',
        freeSeatsCount: 20,
        totalSeatsCount: 517,
        startPrice: 462,
        endPrice: 854,
      ),
      PricingModel(
        sectionName: 'Section 18-37 Center',
        freeSeatsCount: 32,
        totalSeatsCount: 180,
        startPrice: 584,
        endPrice: 719,
      ),
      PricingModel(
        sectionName: 'Section 18-37 Left',
        freeSeatsCount: 43,
        totalSeatsCount: 517,
        startPrice: 476,
        endPrice: 743,
      ),
    ]);

final EventAdBannerModel fEventAdBannerModel = EventAdBannerModel(
    image: 'assets/images/thumbnail-ads 1.png',
    title: '2024 Advent Calendar',
    desc:
        'Make every day enchanting with our 2024 Advent Calendar. This year, journey through a winter wonderland aboard our crystallized steam train. Open each window to reveal a locomotive, carriages, and woodland creatures, all crafted with charm and our signature savoir-faire.Products are illustrative only.',
    btnTitle: 'Shop now',
    link: 'https://google.com');

final List<SimilarEventsModel> fSimilarEventsModel = [
  SimilarEventsModel(
      image: 'assets/images/imm-chiara-iran-1.jpg',
      status: EventStatus.completing,
      title: 'Female drama in Vienna',
      date: '21. Nov',
      location: 'Wiener Stadthalle, Hall F',
      price: '350'),
  SimilarEventsModel(
      image: 'assets/images/11721_photo.jpg',
      status: EventStatus.completing,
      title: 'Female drama in Vienna',
      date: '21. Nov',
      location: 'Wiener Stadthalle, Hall F',
      price: '350'),
  SimilarEventsModel(
      image: 'assets/images/ebi_viena.png',
      status: EventStatus.completing,
      title: 'Female drama in Vienna',
      date: '21. Nov',
      location: 'Wiener Stadthalle, Hall F',
      price: '350'),
  SimilarEventsModel(
      image: 'assets/images/Hamlet_drama.webp',
      status: EventStatus.completing,
      title: 'Female drama in Vienna',
      date: '21. Nov',
      location: 'Wiener Stadthalle, Hall F',
      price: '350'),
  SimilarEventsModel(
      image: 'assets/images/googoosh-on-stage.jpeg',
      status: EventStatus.completing,
      title: 'Female drama in Vienna',
      date: '21. Nov',
      location: 'Wiener Stadthalle, Hall F',
      price: '350'),
  SimilarEventsModel(
      image: 'assets/images/11721_photo.jpg',
      status: EventStatus.completing,
      title: 'Female drama in Vienna',
      date: '21. Nov',
      location: 'Wiener Stadthalle, Hall F',
      price: '350'),
];

// title: 'Experience Ebi Live in Concert',
// date: DateTime.now(), // TODO
// location: 'Wiener Stadthalle, Hall F, Vienna, Austria',
final OrganizerBannerModel fOrganizerBannerModel = OrganizerBannerModel(
    title: 'Experience Ebi Live in Concert',
    location: 'Wiener Stadthalle, Hall F, Vienna, Austria',
    date: DateTime.now(), // TODO
    role: "", // TODO
    sponsors: List.empty(),
    organizerModel: OrganizerModel(
        organizerImage: 'assets/images/EbiYasmineAsha2020.jpg',
        name: 'Alireza Zolghadri',
        phoneNumber: "",
        emailAddress: "",
        company: "",
        officeNumber: "",
        address: "",
        socials: List.empty(),
        featuredSingers: List.empty()));
