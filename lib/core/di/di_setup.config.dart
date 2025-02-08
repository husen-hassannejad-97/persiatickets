// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;

import '../../apps/helper/router/app_router.dart' as _i447;
import '../../component/header.dart' as _i791;
import '../../local_storage/auth/AuthStorage.dart' as _i344;
import '../../repositories/ad/ad_repository.dart' as _i889;
import '../../repositories/ad/mappers/ad_action_stats_response_dto_mapper.dart'
    as _i382;
import '../../repositories/ad/mappers/ad_response_dto_mapper.dart' as _i1;
import '../../repositories/ad/mappers/create_ad_dto_mapper.dart' as _i652;
import '../../repositories/ad/mappers/record_ad_action_dto_mapper.dart'
    as _i843;
import '../../repositories/ad/mappers/record_ad_action_response_dto_mapper.dart'
    as _i1066;
import '../../repositories/ad/mappers/update_ad_dto_mapper.dart' as _i328;
import '../../repositories/ad/mappers/update_ad_media_dto_mapper.dart' as _i984;
import '../../repositories/auth/auth_repository.dart' as _i707;
import '../../repositories/auth/mappers/auth_type_enum_response_dto_mapper.dart'
    as _i156;
import '../../repositories/auth/mappers/code_dto_mapper.dart' as _i494;
import '../../repositories/auth/mappers/complete_dto_mapper.dart' as _i99;
import '../../repositories/auth/mappers/logged_user_info_dto_mapper.dart'
    as _i452;
import '../../repositories/auth/mappers/login_apple_dto_mapper.dart' as _i356;
import '../../repositories/auth/mappers/login_dto_mapper.dart' as _i369;
import '../../repositories/auth/mappers/login_facebook_dto_mapper.dart'
    as _i207;
import '../../repositories/auth/mappers/login_google_dto_mapper.dart' as _i730;
import '../../repositories/auth/mappers/password_reset_confirm_dto_mapper.dart'
    as _i970;
import '../../repositories/auth/mappers/password_reset_request_dto_mapper.dart'
    as _i874;
import '../../repositories/auth/mappers/register_dto_mapper.dart' as _i630;
import '../../repositories/auth/mappers/send_code_dto_mapper.dart' as _i278;
import '../../repositories/auth/mappers/token_entity_mapper.dart' as _i544;
import '../../repositories/auth/mappers/token_response_dto_entity_mapper.dart'
    as _i644;
import '../../repositories/auth/mappers/token_response_dto_mapper.dart'
    as _i209;
import '../../repositories/auth/mappers/verify_code_dto_mapper.dart' as _i180;
import '../../repositories/auth/mappers/verify_dto_mapper.dart' as _i483;
import '../../repositories/auth/mappers/verify_signup_dto_mapper.dart' as _i588;
import '../../repositories/event/event_repository.dart' as _i142;
import '../../repositories/event/mappers/create_event_dto_mapper.dart' as _i171;
import '../../repositories/event/mappers/event_artist_response_dto_mapper.dart'
    as _i713;
import '../../repositories/event/mappers/event_category_dto_mapper.dart'
    as _i271;
import '../../repositories/event/mappers/event_details_response_dto_mapper.dart'
    as _i493;
import '../../repositories/event/mappers/event_faq_response_dto_mapper.dart'
    as _i119;
import '../../repositories/event/mappers/event_guideline_response_dto_mapper.dart'
    as _i803;
import '../../repositories/event/mappers/event_program_response_dto_mapper.dart'
    as _i53;
import '../../repositories/event/mappers/event_response_dto_mapper.dart'
    as _i524;
import '../../repositories/event/mappers/event_venue_facility_item_response_dto_mapper.dart'
    as _i767;
import '../../repositories/event/mappers/event_venue_response_venue_location_dto_mapper.dart'
    as _i1036;
import '../../repositories/event/mappers/get_events_dto_mapper.dart' as _i5;
import '../../repositories/event/mappers/update_event_dto_mapper.dart' as _i906;
import '../../repositories/order/mappers/order_response_dto_mapper.dart'
    as _i24;
import '../../repositories/order/mappers/order_status_dto_mapper.dart' as _i319;
import '../../repositories/order/order_repository.dart' as _i378;
import '../../repositories/report/mappers/inventory_report_response_dto_mapper.dart'
    as _i924;
import '../../repositories/report/mappers/sale_report_response_dto_mapper.dart'
    as _i1020;
import '../../repositories/report/mappers/user_behavior_report_response_dto_mapper.dart'
    as _i678;
import '../../repositories/report/report_repository.dart' as _i474;
import '../../repositories/seat/mappers/create_seat_dto_mapper.dart' as _i89;
import '../../repositories/seat/mappers/seat_response_dto_mapper.dart' as _i8;
import '../../repositories/seat/mappers/update_seat_dto_mapper.dart' as _i465;
import '../../repositories/seat/seat_repository.dart' as _i612;
import '../../repositories/shared/mappers/device_info_dto_mapper.dart' as _i761;
import '../../repositories/shared/mappers/organizer_response_dto_mapper.dart'
    as _i180;
import '../../repositories/ticket/mappers/purchase_status_dto_mapper.dart'
    as _i535;
import '../../repositories/ticket/mappers/purchase_tickets_dto_mapper.dart'
    as _i264;
import '../../repositories/ticket/mappers/purchase_tickets_response_dto_mapper.dart'
    as _i626;
import '../../repositories/ticket/mappers/ticket_response_dto_mapper.dart'
    as _i976;
import '../../repositories/ticket/mappers/ticket_status_dto_mapper.dart'
    as _i851;
import '../../repositories/ticket/ticket_repository.dart' as _i691;
import '../../repositories/venue/mappers/create_venue_dto_mapper.dart' as _i496;
import '../../repositories/venue/mappers/update_venue_dto_mapper.dart' as _i90;
import '../../repositories/venue/mappers/venue_response_dto_mapper.dart'
    as _i678;
import '../../repositories/venue/venue_repository.dart' as _i614;
import '../../services/ad/ad_service.dart' as _i761;
import '../../services/auth/auth_service.dart' as _i756;
import '../../services/event/event_service.dart' as _i361;
import '../../services/order/order_service.dart' as _i781;
import '../../services/report/report_service.dart' as _i1056;
import '../../services/seat/seat_service.dart' as _i1013;
import '../../services/ticket/ticket_service.dart' as _i815;
import '../../services/venue/venue_service.dart' as _i481;
import '../../templates/auth/login/login_email.dart' as _i1060;
import '../../templates/auth/login/login_email_otp.dart' as _i1040;
import '../../templates/auth/login/login_email_password.dart' as _i1013;
import '../../templates/auth/login/login_phone.dart' as _i897;
import '../../templates/auth/login/login_phone_otp.dart' as _i764;
import '../../templates/auth/reset_password/forgot_password_step_1.dart'
    as _i210;
import '../../templates/auth/reset_password/forgot_password_step_3.dart'
    as _i595;
import '../../templates/auth/signup/signup_email.dart' as _i277;
import '../../templates/auth/signup/signup_email_otp.dart' as _i36;
import '../../templates/auth/signup/signup_phone_number.dart' as _i869;
import '../../templates/auth/signup/signup_phone_number_otp.dart' as _i770;
import '../../templates/auth/signup/signup_terms.dart' as _i256;
import '../../templates/auth/widgets/login_apple.dart' as _i5;
import '../../templates/auth/widgets/login_facebook.dart' as _i156;
import '../../templates/auth/widgets/login_google.dart' as _i296;
import '../../templates/events/event_page/event_details_page.dart' as _i369;
import '../../templates/landing/highlight_events.dart' as _i427;
import '../../templates/landing/landing.dart' as _i1049;
import '../../templates/landing/latest_concerts.dart' as _i838;
import '../../templates/landing/latest_theaters.dart' as _i746;
import '../../templates/landing/pop_movies.dart' as _i1006;
import '../../templates/shared/AdActionBloc.dart' as _i869;
import '../localization/localize.dart' as _i145;
import '../network/interceptors/dio_token_interceptor.dart' as _i330;
import 'network_module.dart' as _i567;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final networkModule = _$NetworkModule(getIt);
  final appRouter = _$AppRouter();
  gh.factory<_i344.AuthStorage>(() => _i344.AuthStorage());
  gh.factory<_i145.Localize>(() => _i145.Localize());
  gh.factory<_i90.UpdateVenueDtoMapper>(() => _i90.UpdateVenueDtoMapper());
  gh.factory<_i496.CreateVenueDtoMapper>(() => _i496.CreateVenueDtoMapper());
  gh.factory<_i678.VenueResponseDtoMapper>(
      () => _i678.VenueResponseDtoMapper());
  gh.factory<_i465.UpdateSeatDtoMapper>(() => _i465.UpdateSeatDtoMapper());
  gh.factory<_i8.SeatResponseDtoMapper>(() => _i8.SeatResponseDtoMapper());
  gh.factory<_i89.CreateSeatDtoMapper>(() => _i89.CreateSeatDtoMapper());
  gh.factory<_i678.UserBehaviorReportResponseDtoMapper>(
      () => _i678.UserBehaviorReportResponseDtoMapper());
  gh.factory<_i924.InventoryReportResponseDtoMapper>(
      () => _i924.InventoryReportResponseDtoMapper());
  gh.factory<_i1020.SaleReportResponseDtoMapper>(
      () => _i1020.SaleReportResponseDtoMapper());
  gh.factory<_i535.PurchaseStatusDtoMapper>(
      () => _i535.PurchaseStatusDtoMapper());
  gh.factory<_i851.TicketStatusDtoMapper>(() => _i851.TicketStatusDtoMapper());
  gh.factory<_i264.PurchaseTicketsDtoMapper>(
      () => _i264.PurchaseTicketsDtoMapper());
  gh.factory<_i767.EventVenueFacilityItemResponseDtoMapper>(
      () => _i767.EventVenueFacilityItemResponseDtoMapper());
  gh.factory<_i271.EventCategoryDtoMapper>(
      () => _i271.EventCategoryDtoMapper());
  gh.factory<_i119.EventFaqResponseDtoMapper>(
      () => _i119.EventFaqResponseDtoMapper());
  gh.factory<_i1036.EventVenueResponseVenueLocationDtoMapper>(
      () => _i1036.EventVenueResponseVenueLocationDtoMapper());
  gh.factory<_i803.EventGuidelineResponseDtoMapper>(
      () => _i803.EventGuidelineResponseDtoMapper());
  gh.factory<_i713.EventArtistResponseDtoMapper>(
      () => _i713.EventArtistResponseDtoMapper());
  gh.factory<_i53.EventProgramResponseDtoMapper>(
      () => _i53.EventProgramResponseDtoMapper());
  gh.factory<_i906.UpdateEventDtoMapper>(() => _i906.UpdateEventDtoMapper());
  gh.factory<_i171.CreateEventDtoMapper>(() => _i171.CreateEventDtoMapper());
  gh.factory<_i644.TokenResponseDtoEntityMapper>(
      () => _i644.TokenResponseDtoEntityMapper());
  gh.factory<_i984.UpdateAdMediaDtoMapper>(
      () => _i984.UpdateAdMediaDtoMapper());
  gh.factory<_i382.AdActionStatsResponseDtoMapper>(
      () => _i382.AdActionStatsResponseDtoMapper());
  gh.factory<_i1066.RecordAdActionResponseDtoMapper>(
      () => _i1066.RecordAdActionResponseDtoMapper());
  gh.factory<_i843.RecordAdActionDtoMapper>(
      () => _i843.RecordAdActionDtoMapper());
  gh.factory<_i328.UpdateAdDtoMapper>(() => _i328.UpdateAdDtoMapper());
  gh.factory<_i1.AdResponseDtoMapper>(() => _i1.AdResponseDtoMapper());
  gh.factory<_i652.CreateAdDtoMapper>(() => _i652.CreateAdDtoMapper());
  gh.factory<_i761.DeviceInfoDtoMapper>(() => _i761.DeviceInfoDtoMapper());
  gh.factory<_i180.OrganizerResponseDtoMapper>(
      () => _i180.OrganizerResponseDtoMapper());
  gh.factory<_i319.OrderStatusDtoMapper>(() => _i319.OrderStatusDtoMapper());
  gh.singleton<_i361.Dio>(() => networkModule.dio);
  gh.singleton<_i583.GoRouter>(() => appRouter.router);
  gh.singleton<_i494.CodeDtoMapper>(() => _i494.CodeDtoMapper());
  gh.singleton<_i207.LoginFacebookDtoMapper>(
      () => _i207.LoginFacebookDtoMapper());
  gh.singleton<_i630.RegisterDtoMapper>(() => _i630.RegisterDtoMapper());
  gh.singleton<_i588.VerifySignupDtoMapper>(
      () => _i588.VerifySignupDtoMapper());
  gh.singleton<_i970.PasswordResetConfirmDtoMapper>(
      () => _i970.PasswordResetConfirmDtoMapper());
  gh.singleton<_i874.PasswordResetRequestDtoMapper>(
      () => _i874.PasswordResetRequestDtoMapper());
  gh.singleton<_i483.VerifyDtoMapper>(() => _i483.VerifyDtoMapper());
  gh.singleton<_i99.CompleteDtoMapper>(() => _i99.CompleteDtoMapper());
  gh.singleton<_i356.LoginAppleDtoMapper>(() => _i356.LoginAppleDtoMapper());
  gh.singleton<_i180.VerifyCodeDtoMapper>(() => _i180.VerifyCodeDtoMapper());
  gh.singleton<_i209.TokenResponseDtoMapper>(
      () => _i209.TokenResponseDtoMapper());
  gh.singleton<_i544.TokenEntityMapper>(() => _i544.TokenEntityMapper());
  gh.singleton<_i156.AuthTypeEnumResponseDtoMapper>(
      () => _i156.AuthTypeEnumResponseDtoMapper());
  gh.singleton<_i730.LoginGoogleDtoMapper>(() => _i730.LoginGoogleDtoMapper());
  gh.singleton<_i452.LoggedUserInfoDtoMapper>(
      () => _i452.LoggedUserInfoDtoMapper());
  gh.singleton<_i330.DioTokenInterceptor>(
      () => networkModule.dioTokenInterceptor);
  gh.factory<_i5.GetEventsDtoMapper>(() => _i5.GetEventsDtoMapper(
      eventCategoryDtoMapper: gh<_i271.EventCategoryDtoMapper>()));
  gh.singleton<_i481.VenueService>(() => _i481.VenueService(gh<_i361.Dio>()));
  gh.singleton<_i1013.SeatService>(() => _i1013.SeatService(gh<_i361.Dio>()));
  gh.singleton<_i1056.ReportService>(
      () => _i1056.ReportService(gh<_i361.Dio>()));
  gh.singleton<_i815.TicketService>(() => _i815.TicketService(gh<_i361.Dio>()));
  gh.singleton<_i361.EventService>(() => _i361.EventService(gh<_i361.Dio>()));
  gh.singleton<_i756.AuthService>(() => _i756.AuthService(gh<_i361.Dio>()));
  gh.singleton<_i761.AdService>(() => _i761.AdService(gh<_i361.Dio>()));
  gh.singleton<_i781.OrderService>(() => _i781.OrderService(gh<_i361.Dio>()));
  gh.factory<_i24.OrderResponseDtoMapper>(() => _i24.OrderResponseDtoMapper(
      orderStatusDtoMapper: gh<_i319.OrderStatusDtoMapper>()));
  gh.factory<_i493.EventDetailsResponseDtoMapper>(() =>
      _i493.EventDetailsResponseDtoMapper(
        eventProgramResponseDtoMapper: gh<_i53.EventProgramResponseDtoMapper>(),
        eventArtistResponseDtoMapper: gh<_i713.EventArtistResponseDtoMapper>(),
        eventVenueFacilityItemResponseDtoMapper:
            gh<_i767.EventVenueFacilityItemResponseDtoMapper>(),
        eventGuidelineResponseDtoMapper:
            gh<_i803.EventGuidelineResponseDtoMapper>(),
        eventVenueResponseVenueLocationDtoMapper:
            gh<_i1036.EventVenueResponseVenueLocationDtoMapper>(),
        organizerResponseDtoMapper: gh<_i180.OrganizerResponseDtoMapper>(),
        eventFaqResponseDtoMapper: gh<_i119.EventFaqResponseDtoMapper>(),
      ));
  gh.factory<_i976.TicketResponseDtoMapper>(() => _i976.TicketResponseDtoMapper(
      ticketStatusDtoMapper: gh<_i851.TicketStatusDtoMapper>()));
  gh.singleton<_i369.LoginDtoMapper>(() => _i369.LoginDtoMapper(
      deviceInfoDtoMapper: gh<_i761.DeviceInfoDtoMapper>()));
  gh.singleton<_i278.SendCodeDtoMapper>(() => _i278.SendCodeDtoMapper(
      deviceInfoDtoMapper: gh<_i761.DeviceInfoDtoMapper>()));
  gh.factory<_i524.EventResponseDtoMapper>(() => _i524.EventResponseDtoMapper(
        eventCategoryDtoMapper: gh<_i271.EventCategoryDtoMapper>(),
        venueResponseDtoMapper: gh<_i678.VenueResponseDtoMapper>(),
      ));
  gh.singleton<_i378.OrderRepository>(() => _i378.OrderRepository(
        orderService: gh<_i781.OrderService>(),
        orderResponseDtoMapper: gh<_i24.OrderResponseDtoMapper>(),
      ));
  gh.singleton<_i612.SeatRepository>(() => _i612.SeatRepository(
        seatService: gh<_i1013.SeatService>(),
        seatResponseDtoMapper: gh<_i8.SeatResponseDtoMapper>(),
        createSeatDtoMapper: gh<_i89.CreateSeatDtoMapper>(),
        updateSeatDtoMapper: gh<_i465.UpdateSeatDtoMapper>(),
      ));
  gh.singleton<_i474.ReportRepository>(() => _i474.ReportRepository(
        reportService: gh<_i1056.ReportService>(),
        inventoryReportResponseDtoMapper:
            gh<_i924.InventoryReportResponseDtoMapper>(),
        saleReportResponseDtoMapper: gh<_i1020.SaleReportResponseDtoMapper>(),
        userBehaviorReportResponseDtoMapper:
            gh<_i678.UserBehaviorReportResponseDtoMapper>(),
      ));
  gh.singleton<_i614.VenueRepository>(() => _i614.VenueRepository(
        venueService: gh<_i481.VenueService>(),
        venueResponseDtoMapper: gh<_i678.VenueResponseDtoMapper>(),
        createVenueDtoMapper: gh<_i496.CreateVenueDtoMapper>(),
        updateVenueDtoMapper: gh<_i90.UpdateVenueDtoMapper>(),
      ));
  gh.singleton<_i889.AdRepository>(() => _i889.AdRepository(
        adService: gh<_i761.AdService>(),
        adResponseDtoMapper: gh<_i1.AdResponseDtoMapper>(),
        createAdDtoMapper: gh<_i652.CreateAdDtoMapper>(),
        recordAdActionDtoMapper: gh<_i843.RecordAdActionDtoMapper>(),
        updateAdDtoMapper: gh<_i328.UpdateAdDtoMapper>(),
        updateAdMediaDtoMapper: gh<_i984.UpdateAdMediaDtoMapper>(),
        recordAdActionResponseDtoMapper:
            gh<_i1066.RecordAdActionResponseDtoMapper>(),
        adActionStatsResponseDtoMapper:
            gh<_i382.AdActionStatsResponseDtoMapper>(),
      ));
  gh.singleton<_i142.EventRepository>(() => _i142.EventRepository(
        eventService: gh<_i361.EventService>(),
        eventResponseDtoMapper: gh<_i524.EventResponseDtoMapper>(),
        createEventDtoMapper: gh<_i171.CreateEventDtoMapper>(),
        updateEventDtoMapper: gh<_i906.UpdateEventDtoMapper>(),
        getEventsDtoMapper: gh<_i5.GetEventsDtoMapper>(),
        eventDetailsResponseDtoMapper:
            gh<_i493.EventDetailsResponseDtoMapper>(),
      ));
  gh.factory<_i626.PurchaseTicketsResponseDtoMapper>(
      () => _i626.PurchaseTicketsResponseDtoMapper(
            purchaseStatusDtoMapper: gh<_i535.PurchaseStatusDtoMapper>(),
            ticketResponseDtoMapper: gh<_i976.TicketResponseDtoMapper>(),
          ));
  gh.factory<_i1049.LandingBloc>(
      () => _i1049.LandingBloc(adRepo: gh<_i889.AdRepository>()));
  gh.factory<_i869.AdActionBloc>(
      () => _i869.AdActionBloc(adRepo: gh<_i889.AdRepository>()));
  gh.singleton<_i746.LatestTheatersBloc>(
      () => _i746.LatestTheatersBloc(gh<_i142.EventRepository>()));
  gh.singleton<_i1006.PopMoviesBloc>(
      () => _i1006.PopMoviesBloc(gh<_i142.EventRepository>()));
  gh.singleton<_i838.LatestConcertsBloc>(
      () => _i838.LatestConcertsBloc(gh<_i142.EventRepository>()));
  gh.singleton<_i369.EventDetailsBloc>(
      () => _i369.EventDetailsBloc(gh<_i142.EventRepository>()));
  gh.singleton<_i707.AuthRepository>(() => _i707.AuthRepository(
        authStorage: gh<_i344.AuthStorage>(),
        authService: gh<_i756.AuthService>(),
        codeDtoMapper: gh<_i494.CodeDtoMapper>(),
        completeDtoMapper: gh<_i99.CompleteDtoMapper>(),
        loginDtoMapper: gh<_i369.LoginDtoMapper>(),
        loginAppleDtoMapper: gh<_i356.LoginAppleDtoMapper>(),
        loginFacebookDtoMapper: gh<_i207.LoginFacebookDtoMapper>(),
        loginGoogleDtoMapper: gh<_i730.LoginGoogleDtoMapper>(),
        passwordResetConfirmDtoMapper:
            gh<_i970.PasswordResetConfirmDtoMapper>(),
        passwordResetRequestDtoMapper:
            gh<_i874.PasswordResetRequestDtoMapper>(),
        registerDtoMapper: gh<_i630.RegisterDtoMapper>(),
        sendCodeDtoMapper: gh<_i278.SendCodeDtoMapper>(),
        verifyCodeDtoMapper: gh<_i180.VerifyCodeDtoMapper>(),
        verifyDtoMapper: gh<_i483.VerifyDtoMapper>(),
        verifySignupDtoMapper: gh<_i588.VerifySignupDtoMapper>(),
        loggedUserInfoDtoMapper: gh<_i452.LoggedUserInfoDtoMapper>(),
        tokenResponseDtoEntityMapper: gh<_i644.TokenResponseDtoEntityMapper>(),
        authTypeEnumResponseDtoMapper:
            gh<_i156.AuthTypeEnumResponseDtoMapper>(),
        deviceInfoDtoMapper: gh<_i761.DeviceInfoDtoMapper>(),
      ));
  gh.singleton<_i691.TicketRepository>(() => _i691.TicketRepository(
        ticketService: gh<_i815.TicketService>(),
        ticketResponseDtoMapper: gh<_i976.TicketResponseDtoMapper>(),
        purchaseTicketsResponseDtoMapper:
            gh<_i626.PurchaseTicketsResponseDtoMapper>(),
        purchaseTicketsDtoMapper: gh<_i264.PurchaseTicketsDtoMapper>(),
      ));
  gh.factory<_i277.SignupEmailBloc>(
      () => _i277.SignupEmailBloc(gh<_i707.AuthRepository>()));
  gh.factory<_i869.SignupPhoneNumberBloc>(
      () => _i869.SignupPhoneNumberBloc(gh<_i707.AuthRepository>()));
  gh.factory<_i36.SignupEmailOtpBloc>(
      () => _i36.SignupEmailOtpBloc(gh<_i707.AuthRepository>()));
  gh.factory<_i770.SignupPhoneNumberOtpBloc>(
      () => _i770.SignupPhoneNumberOtpBloc(gh<_i707.AuthRepository>()));
  gh.factory<_i1060.LoginEmailBloc>(
      () => _i1060.LoginEmailBloc(gh<_i707.AuthRepository>()));
  gh.factory<_i897.LoginPhoneBloc>(
      () => _i897.LoginPhoneBloc(gh<_i707.AuthRepository>()));
  gh.factory<_i1013.LoginEmailPasswordBloc>(
      () => _i1013.LoginEmailPasswordBloc(gh<_i707.AuthRepository>()));
  gh.singleton<_i427.HighLightEventsBloc>(
      () => _i427.HighLightEventsBloc(gh<_i142.EventRepository>()));
  gh.factory<_i791.HeaderBloc>(
      () => _i791.HeaderBloc(authRepo: gh<_i707.AuthRepository>()));
  gh.factory<_i5.LoginAppleBloc>(
      () => _i5.LoginAppleBloc(authRepo: gh<_i707.AuthRepository>()));
  gh.factory<_i296.LoginGoogleBloc>(
      () => _i296.LoginGoogleBloc(authRepo: gh<_i707.AuthRepository>()));
  gh.factory<_i156.LoginFacebookBloc>(
      () => _i156.LoginFacebookBloc(authRepo: gh<_i707.AuthRepository>()));
  gh.factory<_i256.SignupTermsPageBloc>(
      () => _i256.SignupTermsPageBloc(authRepo: gh<_i707.AuthRepository>()));
  gh.factory<_i1040.LoginEmailOtpBloc>(
      () => _i1040.LoginEmailOtpBloc(authRepo: gh<_i707.AuthRepository>()));
  gh.factory<_i764.LoginPhoneOtpBloc>(
      () => _i764.LoginPhoneOtpBloc(authRepo: gh<_i707.AuthRepository>()));
  gh.factory<_i595.ForgotPasswordStep3Bloc>(() =>
      _i595.ForgotPasswordStep3Bloc(authRepo: gh<_i707.AuthRepository>()));
  gh.factory<_i210.ForgotPasswordStep1Bloc>(() =>
      _i210.ForgotPasswordStep1Bloc(authRepo: gh<_i707.AuthRepository>()));
  return getIt;
}

class _$NetworkModule extends _i567.NetworkModule {
  _$NetworkModule(this._getIt);

  final _i174.GetIt _getIt;

  @override
  _i330.DioTokenInterceptor get dioTokenInterceptor =>
      _i330.DioTokenInterceptor(
        authStorage: _getIt<_i344.AuthStorage>(),
        tokenDtoEntityMapper: _getIt<_i644.TokenResponseDtoEntityMapper>(),
        localize: _getIt<_i145.Localize>(),
      );
}

class _$AppRouter extends _i447.AppRouter {}
