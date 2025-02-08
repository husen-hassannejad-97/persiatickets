import 'package:billit_now/apps/helper/event_status.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/about_artist_model.dart';
import 'package:billit_now/repositories/event/models/about_organizer_model.dart';
import 'package:billit_now/repositories/event/models/cancellation_policy_model.dart';
import 'package:billit_now/repositories/event/models/event_ad_banner_model.dart';
import 'package:billit_now/repositories/event/models/event_hero_model.dart';
import 'package:billit_now/repositories/event/models/explore_pricing_model.dart';
import 'package:billit_now/repositories/event/models/info_faq_model.dart';
import 'package:billit_now/repositories/event/models/organizer_banner_model.dart';
import 'package:billit_now/repositories/event/models/programs_model.dart';
import 'package:billit_now/repositories/event/models/programs_status.dart';
import 'package:billit_now/repositories/event/models/similar_events_model.dart';
import 'package:billit_now/repositories/event/models/top_music.dart';
import 'package:billit_now/repositories/event/models/venue_facilities_model.dart';
import 'package:billit_now/repositories/event/models/venue_guidelines_model.dart';
import 'package:billit_now/repositories/event/models/venue_location_model.dart';
import 'package:billit_now/repositories/event/models/what_attendees_say_model.dart';
import 'package:billit_now/repositories/event/models/why_persia_tickets_model.dart';
import 'package:billit_now/templates/events/event_page/about_artist.dart';
import 'package:billit_now/templates/events/event_page/about_organizer.dart';
import 'package:billit_now/templates/events/event_page/cancellation_policy.dart';
import 'package:billit_now/templates/events/event_page/event_banner_ad.dart';
import 'package:billit_now/templates/events/event_page/explore_pricing.dart';
import 'package:billit_now/templates/events/event_page/info_faq.dart';
import 'package:billit_now/templates/events/event_page/organizer_banner.dart';
import 'package:billit_now/templates/events/event_page/programs.dart';
import 'package:billit_now/templates/events/event_page/similar_events.dart';
import 'package:billit_now/templates/events/event_page/venue_facilities.dart';
import 'package:billit_now/templates/events/event_page/venue_guidLines.dart';
import 'package:billit_now/templates/events/event_page/venue_location.dart';
import 'package:billit_now/templates/events/event_page/what_attendees_say.dart';
import 'package:billit_now/templates/events/event_page/why_persia_tickets.dart';
import 'package:flutter/material.dart';

class EventContent extends BaseStatelessWidget {
  EventContent({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.eventHeroModel,
    required this.whysList,
    required this.programs,
    required this.onProgramSelected,
    required this.aboutArtistModel,
    required this.venueFacilitiesModel,
  });

  final String title;
  final DateTime date;
  final String location;
  final EventHeroModel eventHeroModel;
  final List<WhyPersiaTicketsModel> whysList;
  final List<ProgramsModel> programs;
  final Function(ProgramsModel) onProgramSelected;
  final AboutArtistModel aboutArtistModel;
  final VenueFacilitiesModel venueFacilitiesModel;

  @override
  Widget body(BuildContext context) {
    return SizedBox(
        width: context.logicalWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Content
            Expanded(
              child: Container(
                // width: ,//context.logicalWidth * 0.7,
                padding: EdgeInsets.only(top: 40, right: 32, left: 48),
                child: Column(
                  children: [
                    whysList.isEmpty
                        ? Container()
                        : Column(
                            children: [
                              WhyPersiaTickets(whysList: whysList),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Divider(
                                  color:
                                      Theme.of(context).appColors.borderPrimary,
                                  thickness: 1.0,
                                ),
                              )
                            ],
                          ),
                    // Programs
                    Programs(
                      data: programs,
                      callback: onProgramSelected,
                    ), // About
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Theme.of(context).appColors.borderPrimary,
                        thickness: 1.0,
                      ),
                    ),
                    // About
                    AboutArtist(data: aboutArtistModel),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Theme.of(context).appColors.borderPrimary,
                        thickness: 1.0,
                      ),
                    ),
                    // Venue Facilities
                    VenueFacilities(data: venueFacilitiesModel),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Theme.of(context).appColors.borderPrimary,
                        thickness: 1.0,
                      ),
                    ),
                    // GuideLines
                    VenueGuidelines(
                        data: VenueGuidelinesModel(guides: [
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
                    ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Theme.of(context).appColors.borderPrimary,
                        thickness: 1.0,
                      ),
                    ),
                    // Cancellation Policy
                    CancellationPolicy(
                        data: CancellationPolicyModel(
                            title: 'Concert Cancellation Policy',
                            policies: [
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
                        ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Theme.of(context).appColors.borderPrimary,
                        thickness: 1.0,
                      ),
                    ),
                    // What Attendees Are Saying
                    WhatAttendeesSay(
                      data:
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
                      ]),
                      writeReview: () {
                        // TODO
                      },
                      showAllReviews: () {
                        // TODO
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Theme.of(context).appColors.borderPrimary,
                        thickness: 1.0,
                      ),
                    ),
                    // Location
                    VenueLocation(
                      data: VenueLocationModel(
                          name: 'Wiener Stadthalle',
                          address:
                              'Roland-Rainer-Platz 1, 1150 Vienna, Austria',
                          lat: 48.2024077,
                          lon: 16.3337406,
                          overViewDesc:
                              "Wiener Stadthalle, located in the heart of Vienna, is Austria's premier multi-functional event venue, hosting world-class concerts, performances, and exhibitions. Its central location ensures easy access for attendees from across the city and beyond.",
                          nearbyAmenitiesDesc:
                              'Situated in a vibrant area of Vienna, Wiener Stadthalle is surrounded by hotels, cafes, restaurants, and retail shops, providing plenty of options for dining and accommodation.',
                          gettingThereItems: [
                            GettingThereItems(
                                title: 'By Public Transport:',
                                items: [
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
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Theme.of(context).appColors.borderPrimary,
                        thickness: 1.0,
                      ),
                    ),
                    // About Organizer
                    AboutOrganizer(
                      data: AboutOrganizerModel(
                          organizerModel: OrganizerModel(
                              organizerImage:
                                  'assets/images/16051981977461.png',
                              name: 'Alireza Zolghadri',
                              phoneNumber: '+43 650 555 74470',
                              emailAddress: 'alireza.zolghadri@gmail.com',
                              company: 'Online SIM',
                              officeNumber: '+43 350 235 93470',
                              address: 'Rittingergasse 24 , 1210 Wien',
                              socials: [
                            SocialModel(
                                icon: AppIconName.whatsapp.name,
                                link: 'https://whatsapp.com/'),
                            SocialModel(
                                icon: AppIconName.logoFacebook.name,
                                link: 'https://www.facebook.com/'),
                            SocialModel(
                                icon: AppIconName.instagramColor.name,
                                link: 'https://www.instagram.com/'),
                            SocialModel(
                                icon: AppIconName.x.name,
                                link: 'https://x.com/'),
                            SocialModel(
                                icon: AppIconName.telegram.name,
                                link: 'https://telegram.org/'),
                          ],
                              featuredSingers: [
                            SingerModel(
                                image: 'assets/images/EbiYasmineAsha2020.jpg',
                                name: 'Ebi'),
                            SingerModel(
                                image: 'assets/images/EbiYasmineAsha2020.jpg',
                                name: 'Ali Zand Vakili'),
                            SingerModel(
                                image: 'assets/images/EbiYasmineAsha2020.jpg',
                                name: 'Behnam Bahni'),
                            SingerModel(
                                image: 'assets/images/EbiYasmineAsha2020.jpg',
                                name: 'Mohsen Yeganeh'),
                          ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Theme.of(context).appColors.borderPrimary,
                        thickness: 1.0,
                      ),
                    ),
                    // Info FAQ
                    InfoFAQ(
                        data: InfoFaqModel(
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
                        ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Theme.of(context).appColors.borderPrimary,
                        thickness: 1.0,
                      ),
                    ),
                    // Explore Pricing
                    ExplorePricing(
                        data: ExplorePricingModel(
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
                        ])),
                    // Ad Banner
                    EventAdBanner(
                        data: EventAdBannerModel(
                            image: 'assets/images/thumbnail-ads 1.png',
                            title: '2024 Advent Calendar',
                            desc:
                                'Make every day enchanting with our 2024 Advent Calendar. This year, journey through a winter wonderland aboard our crystallized steam train. Open each window to reveal a locomotive, carriages, and woodland creatures, all crafted with charm and our signature savoir-faire.Products are illustrative only.',
                            btnTitle: 'Shop now',
                            link: 'https://google.com')),
                    // Similars
                    SimilarEvents(data: [
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
                    ])
                  ],
                ),
              ),
            ),
            // Organizer
            context.isSmallTabletOrLess
                ? Container()
                : Container(
                    width: 376,
                    padding: EdgeInsets.only(top: 40, right: 48, left: 16),
                    child: OrganizerBanner(
                      data: OrganizerBannerModel(
                          title: title,
                          location: location,
                          date: DateTime.now(), // TODO
                          role: eventHeroModel.role, // TODO
                          sponsors: List.empty(),
                          organizerModel: OrganizerModel(
                              organizerImage:
                                  eventHeroModel.organizerModel.organizerImage,
                              name: eventHeroModel.organizerModel.name,
                              phoneNumber: "",
                              emailAddress: "",
                              company: "",
                              officeNumber: "",
                              address: "",
                              socials: List.empty(),
                              featuredSingers: List.empty())),
                      reserveTickets: eventHeroModel.reserveTickets,
                    ))
          ],
        ));
  }
}
