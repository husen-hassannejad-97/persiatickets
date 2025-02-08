import 'package:billit_now/apps/helper/country_code/country_codes_data.dart';
import 'package:billit_now/apps/helper/router/router_extention/landing_router_extention.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/apps/helper/utils/country_model.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_dropdown.dart';
import 'package:billit_now/component/app_switch.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/component/nav_drawer.dart';
import 'package:billit_now/component/signup_modal/signup_modal.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/repositories/event/models/checkout_model.dart';
import 'package:billit_now/repositories/event/models/header_navigation_model.dart';
import 'package:billit_now/repositories/event_map/models/map_model.dart';
import 'package:billit_now/templates/auth/widgets/country_code.dart';
import 'package:billit_now/templates/auth/widgets/password_checker.dart';
import 'package:billit_now/templates/events/checkout/ticket_invoice.dart';
import 'package:billit_now/templates/events/widgets/checkout_timer.dart';
import 'package:billit_now/templates/events/widgets/form_complation_modal.dart';
import 'package:billit_now/templates/events/widgets/header_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Checkout extends BaseStatefulWidget {
  Checkout({super.key, required this.currency, required this.data});

  final String currency;
  final CheckoutModel data;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final ScrollController _scrollController = ScrollController();

  String title = '';
  String academyDegree = '';
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final int birthYear = 0;
  final int birthMonth = 0;
  final int birthDay = 0;

  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  String country = '';
  String addressDialCode = '';
  final TextEditingController _addressPhoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  String accountDialCode = '';
  CountryModel? _accountSelectedCountry;
  final TextEditingController _accountPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String password = '';

  late List<MapSeatModel> selectedSeats;
  bool? formIsReady;
  double totalTickets = 0;
  late double bookingFees;
  late double totalAmount;
  late double feePercent;
  late String currency;

  late Duration duration;

  @override
  void initState() {
    selectedSeats = widget.data.seats;
    super.initState();
    duration = Duration(minutes: widget.data.durationMinutes);
    _passwordController.addListener(() {
      setState(() {
        password = _passwordController.text;
      });
    });
    initInvoice();
  }

  initInvoice() {
    totalTickets = 0;

    feePercent = widget.data.fee;
    for (var seat in selectedSeats) {
      totalTickets += seat.price ?? 0;
      currency = widget.currency;
    }

    bookingFees = totalTickets * feePercent;
    totalAmount = totalTickets + bookingFees;
  }

  @override
  Widget build(BuildContext context) {
    bool isSmScreen = context.logicalWidth < 1100;
    return Scaffold(
      endDrawer: isSmScreen ? const NavDrawer() : null,
      backgroundColor: Theme.of(context).appColors.bgPrimary,
      bottomNavigationBar: isSmScreen
          ? Container(
              height: 70,
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: Center(
                  child: _bottonButtons(context, isSmScreen,
                      formIsReady ?? false, totalAmount, currency)))
          : null,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: context.logicalWidth),
            child: Stack(
              children: [
                formIsReady != null && formIsReady == true && isSmScreen
                    ? TicketInvoice(
                        scrollController: _scrollController,
                        title: widget.data.venueTitle,
                        date: widget.data.venueDate,
                        time: widget.data.venueTime,
                        location: widget.data.venueLocation,
                        whysList: widget.data.whyPersiaTickets,
                        selectedSeats: selectedSeats,
                        feePercent: feePercent,
                        bookingFees: bookingFees,
                        currency: currency,
                        totalAmount: totalAmount,
                        totalTickets: totalTickets,
                        removeSeat: (int index) {
                          setState(() {
                            selectedSeats.removeAt(index);
                            initInvoice();
                          });
                        },
                        duration: duration,
                        durationTime: (d) {
                          setState(() {
                            duration = d;
                          });
                        },
                      )
                    : Row(
                        children: [
                          Container(
                              width: isSmScreen
                                  ? context.logicalWidth
                                  : context.logicalWidth * 0.7,
                              color: Theme.of(context).appColors.bgSecondary,
                              child: ListView(
                                controller: _scrollController,
                                children: [
                                  _formHeader(context),
                                  Divider(
                                    color: Theme.of(context)
                                        .appColors
                                        .borderSecondary,
                                    height: 1,
                                  ),
                                  _personalDetails(context, isSmScreen,
                                      (String? title) {
                                    if (title != null) {
                                      setState(() {
                                        title = title;
                                      });
                                    }
                                  }, (String? degree) {
                                    if (degree != null) {
                                      setState(() {
                                        degree = degree;
                                      });
                                    }
                                  }, (int year) {
                                    setState(() {
                                      year = year;
                                    });
                                  }, (int month) {
                                    setState(() {
                                      month = month;
                                    });
                                  }, (int day) {
                                    setState(() {
                                      day = day;
                                    });
                                  }),
                                  _addressInfo(context, isSmScreen,
                                      (String? country) {
                                    if (country != null) {
                                      setState(() {
                                        country = country;
                                      });
                                    }
                                  }, (String dialCode, int i) {
                                    setState(() {
                                      addressDialCode = dialCode;
                                    });
                                  }),
                                  _accountSetup(context,
                                      (String dialCode, int i) {
                                    setState(() {
                                      accountDialCode = dialCode;
                                    });
                                  }),
                                  _notificationsFromUs(
                                      context, (bool email) {}, (bool sms) {}),
                                  isSmScreen
                                      ? Container()
                                      : Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 32.0,
                                              right: 20.0,
                                              left: 20.0),
                                          child: _bottonButtons(
                                              context,
                                              isSmScreen,
                                              formIsReady ?? false,
                                              totalAmount,
                                              currency))
                                ],
                              )),
                          isSmScreen
                              ? Container()
                              : Container(
                                  width: context.logicalWidth * 0.3,
                                  color: Theme.of(context).appColors.bgPrimary,
                                  child: TicketInvoice(
                                    scrollController: _scrollController,
                                    title: widget.data.venueTitle,
                                    date: widget.data.venueDate,
                                    time: widget.data.venueTime,
                                    location: widget.data.venueLocation,
                                    whysList: widget.data.whyPersiaTickets,
                                    selectedSeats: selectedSeats,
                                    feePercent: feePercent,
                                    bookingFees: bookingFees,
                                    currency: currency,
                                    totalAmount: totalAmount,
                                    totalTickets: totalTickets,
                                    removeSeat: (int index) {
                                      setState(() {
                                        selectedSeats.removeAt(index);
                                        initInvoice();
                                      });
                                    },
                                    duration: duration,
                                    durationTime: (Duration d) {
                                      setState(() {
                                        duration = d;
                                      });
                                    },
                                  ))
                        ],
                      ),
                _headerNavigation(isSmScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timer() => CheckoutTimer(
      duration: duration,
      currentTime: (Duration d) {
        setState(() {
          duration = d;
        });
      });

  Widget _headerNavigation(bool isSmScreen) => Column(
        children: [
          HeaderNavigation(scrollController: _scrollController, steps: [
            HeaderNavigationModel(
                title: 'Select Date & Time', isDone: true, isHover: false),
            HeaderNavigationModel(
                title: 'Select Seats', isDone: true, isHover: false),
            HeaderNavigationModel(
                title: 'User Info & Invoice', isDone: false, isHover: true),
            HeaderNavigationModel(
                title: 'Payment', isDone: false, isHover: false),
            HeaderNavigationModel(
                title: 'Tickets', isDone: false, isHover: false)
          ]),
          isSmScreen ? SizedBox(height: 60.0, child: _timer()) : Container(),
        ],
      );

  Widget _formHeader(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 80.0, bottom: 25.0, right: 25.0, left: 25),
        constraints: BoxConstraints(maxWidth: 640),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 190,
                child: AppButton.buttonIcon(AppIconName.uea1fChevronLeft,
                    text: 'Back to previous step',
                    bgColor: Colors.transparent,
                    bgHoverColor: Colors.transparent,
                    textColor: Theme.of(context).appColors.buttonTeritoryFg,
                    context: context, onTap: () {
                  context.pop();
                }),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                constraints: BoxConstraints(maxWidth: 640),
                child: Text('Complete Your Details for Secure Payment',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .appTexts
                        .displayXsSemibold
                        .copyWith(
                            color: Theme.of(context).appColors.textPrimary900)),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 640),
                child: Text(
                    'Provide the required details below to generate your payment invoice and proceed securely.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).appTexts.textMdRegular.copyWith(
                        color: Theme.of(context).appColors.textTeritory600)),
              )
            ],
          ),
        ),
      );

  Widget _personalDetails(
    BuildContext context,
    bool isSmScreen,
    Function(String? title) onTitle,
    Function(String? degree) onDegree,
    Function(int time) onBirthYear,
    Function(int time) onBirthMonth,
    Function(int time) onBirthDay,
  ) {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Format the date and time
    int year = int.parse(DateFormat('yyyy').format(now));

    List<String> titles = ['not specified', 'Mr', 'Mrs', 'Ms'];
    List<String> monthes = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    List<String> degrees = [
      'Associate',
      'Bachelor',
      'Master',
      'Doctoral',
      'Professional'
    ];

    return Container(
      margin:
          const EdgeInsets.only(top: 24.0, bottom: 32.0, right: 25.0, left: 25),
      constraints: BoxConstraints(maxWidth: 640),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text('Personal Details',
                style: Theme.of(context).appTexts.textLgSemiBold.copyWith(
                    color: Theme.of(context).appColors.textPrimary900)),
            // SubTitle
            Text('Enter your details to identify your account.',
                style: Theme.of(context).appTexts.textSmRegular.copyWith(
                    color: Theme.of(context).appColors.textPrimary900)),
            // Form
            Container(
              margin: EdgeInsets.only(top: 24.0),
              padding: EdgeInsets.all(24.0),
              constraints: BoxConstraints(maxWidth: 640),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).appColors.borderSecondary),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isSmScreen
                      ? Column(
                          children: [
                            AppDropDown.def(
                                items: titles,
                                label: 'Title *',
                                hint: 'Select title',
                                onChanged: onTitle),
                            SizedBox(height: 16.0),
                            AppDropDown.def(
                                items: degrees,
                                label: 'Academy degree',
                                hint: 'Select Acd. degree',
                                onChanged: onDegree),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AppDropDown.def(
                                  items: titles,
                                  label: 'Title *',
                                  hint: 'Select title',
                                  onChanged: onTitle),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: AppDropDown.def(
                                  items: degrees,
                                  label: 'Academy degree',
                                  hint: 'Select Acd. degree',
                                  onChanged: onDegree),
                            )
                          ],
                        ),
                  SizedBox(height: 16.0),
                  isSmScreen
                      ? Column(
                          children: [
                            AppTextField.main(
                                controller: _firstNameController,
                                labelText: 'First name *',
                                keyboardType: TextInputType.name,
                                placeHolder: '',
                                helpText: '',
                                validator: (_) => null),
                            SizedBox(height: 16.0),
                            AppTextField.main(
                                controller: _lastNameController,
                                labelText: 'Last name *',
                                keyboardType: TextInputType.name,
                                placeHolder: '',
                                helpText: '',
                                validator: (_) => null),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: AppTextField.main(
                                  controller: _firstNameController,
                                  labelText: 'First name *',
                                  keyboardType: TextInputType.name,
                                  placeHolder: '',
                                  helpText: '',
                                  validator: (_) => null),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: AppTextField.main(
                                  controller: _lastNameController,
                                  labelText: 'Last name *',
                                  keyboardType: TextInputType.name,
                                  placeHolder: '',
                                  helpText: '',
                                  validator: (_) => null),
                            )
                          ],
                        ),
                  Text('Date of birthday *',
                      style: Theme.of(context).appTexts.textSmMedium.copyWith(
                          color: Theme.of(context).appColors.textSecondary700)),
                  ...context.logicalWidth < 500
                      ? _birthDaySM(
                          isSmScreen: isSmScreen,
                          monthes: monthes,
                          year: year,
                          onBirthDay: onBirthDay,
                          onBirthMonth: onBirthMonth,
                          onBirthYear: onBirthYear,
                        )
                      : [],
                  context.logicalWidth > 500
                      ? Row(
                          children: _birthDayLG(
                          isSmScreen: isSmScreen,
                          monthes: monthes,
                          year: year,
                          onBirthDay: onBirthDay,
                          onBirthMonth: onBirthMonth,
                          onBirthYear: onBirthYear,
                        ))
                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _addressInfo(
          BuildContext context,
          bool isSmScreen,
          Function(String? country) onCountry,
          Function(String, int) onDialCode) =>
      Container(
        margin: const EdgeInsets.only(
            top: 24.0, bottom: 32.0, right: 25.0, left: 25),
        constraints: BoxConstraints(maxWidth: 640),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text('Address Info',
                  style: Theme.of(context).appTexts.textLgSemiBold.copyWith(
                      color: Theme.of(context).appColors.textPrimary900)),
              // SubTitle
              Text('Provide your address for invoice delivery.',
                  style: Theme.of(context).appTexts.textSmRegular.copyWith(
                      color: Theme.of(context).appColors.textPrimary900)),
              // Form
              Container(
                margin: EdgeInsets.only(top: 24.0),
                padding: EdgeInsets.all(24.0),
                constraints: BoxConstraints(maxWidth: 640),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).appColors.borderSecondary),
                    borderRadius: BorderRadius.circular(12.0)),
                child: Column(
                  children: [
                    isSmScreen
                        ? Column(
                            children: [
                              AppTextField.main(
                                  controller: _streetController,
                                  labelText: 'Street/No *',
                                  keyboardType: TextInputType.name,
                                  placeHolder: '',
                                  helpText: '',
                                  validator: (_) => null),
                              SizedBox(height: 16.0),
                              AppTextField.main(
                                  controller: _postalCodeController,
                                  labelText: 'Postal code *',
                                  keyboardType: TextInputType.name,
                                  placeHolder: '',
                                  helpText: '',
                                  validator: (_) => null),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AppTextField.main(
                                    controller: _streetController,
                                    labelText: 'Street/No *',
                                    keyboardType: TextInputType.name,
                                    placeHolder: '',
                                    helpText: '',
                                    validator: (_) => null),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: AppTextField.main(
                                    controller: _postalCodeController,
                                    labelText: 'Postal code *',
                                    keyboardType: TextInputType.name,
                                    placeHolder: '',
                                    helpText: '',
                                    validator: (_) => null),
                              )
                            ],
                          ),
                    SizedBox(height: 16.0),
                    isSmScreen
                        ? Column(
                            children: [
                              AppTextField.main(
                                  controller: _cityController,
                                  labelText: 'City *',
                                  keyboardType: TextInputType.name,
                                  placeHolder: '',
                                  helpText: '',
                                  validator: (_) => null),
                              SizedBox(height: 16.0),
                              AppDropDown.def(
                                  items: List.generate(
                                      CountryCodes.info.length,
                                      (int index) =>
                                          CountryCodes.info[index]['name']),
                                  label: 'Country *',
                                  hint: 'Select country',
                                  onChanged: onCountry),
                              SizedBox(height: 16.0),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: AppTextField.main(
                                    controller: _cityController,
                                    labelText: 'City *',
                                    keyboardType: TextInputType.name,
                                    placeHolder: '',
                                    helpText: '',
                                    validator: (_) => null),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: AppDropDown.def(
                                    items: List.generate(
                                        CountryCodes.info.length,
                                        (int index) =>
                                            CountryCodes.info[index]['name']),
                                    label: 'Country *',
                                    hint: 'Select country',
                                    onChanged: onCountry),
                              )
                            ],
                          ),
                    CountryCode(
                      labelText: 'Phone number',
                      dropdownPlaceHolder: 'Select country code',
                      dropdownSearchPlaceHolder: 'Search country name',
                      textFieldController: _addressPhoneController,
                      enabled: true,
                      selectedCountry: (CountryModel country) {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget _accountSetup(
          BuildContext context, Function(String dialCode, int i) onDialCode) =>
      Container(
        margin: const EdgeInsets.only(
            top: 24.0, bottom: 32.0, right: 25.0, left: 25),
        constraints: BoxConstraints(maxWidth: 640),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text('Account Setup',
                  style: Theme.of(context).appTexts.textLgSemiBold.copyWith(
                      color: Theme.of(context).appColors.textPrimary900)),
              // SubTitle
              Text(
                  'Set up login details or create a new account with email and mobile verification.',
                  style: Theme.of(context).appTexts.textSmRegular.copyWith(
                      color: Theme.of(context).appColors.textPrimary900)),
              // Form
              Container(
                margin: EdgeInsets.only(top: 24.0),
                padding: EdgeInsets.all(24.0),
                constraints: BoxConstraints(maxWidth: 640),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).appColors.borderSecondary),
                    borderRadius: BorderRadius.circular(12.0)),
                child: Column(
                  children: [
                    AppTextField.main(
                        controller: _emailController,
                        labelText: 'Email address *',
                        keyboardType: TextInputType.name,
                        placeHolder: 'sample@company.com',
                        helpText: '',
                        validator: (_) => null),
                    SizedBox(height: 16.0),
                    CountryCode(
                      labelText: 'Phone number',
                      dropdownPlaceHolder: 'Select country code',
                      dropdownSearchPlaceHolder: 'Search country name',
                      textFieldController: _accountPhoneController,
                      selectedCountry: (CountryModel country) {
                        setState(() {
                          _accountSelectedCountry = country;
                        });
                      },
                      enabled: true,
                    ),
                    AppTextField.main(
                        controller: _passwordController,
                        labelText: 'Password *',
                        keyboardType: TextInputType.visiblePassword,
                        isObscure: true,
                        placeHolder: '',
                        helpText: '',
                        validator: (_) => null),
                    PasswordChecker(password: password),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget _notificationsFromUs(BuildContext context,
          Function(bool email) isEmail, Function(bool sms) isSMS) =>
      Container(
        margin: const EdgeInsets.only(
            top: 24.0, bottom: 32.0, right: 25.0, left: 25),
        constraints: BoxConstraints(maxWidth: 640),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text('Notifications from us',
                  style: Theme.of(context).appTexts.textLgSemiBold.copyWith(
                      color: Theme.of(context).appColors.textPrimary900)),
              // SubTitle
              Container(
                constraints: BoxConstraints(maxWidth: 640),
                child: Text(
                    'Please select the ways you would like to receive the latest changes to the event you have booked or important messages.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).appTexts.textSmRegular.copyWith(
                        color: Theme.of(context).appColors.textPrimary900)),
              ),
              // Form
              Container(
                margin: EdgeInsets.only(top: 24.0),
                padding: EdgeInsets.all(24.0),
                constraints: BoxConstraints(maxWidth: 640),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).appColors.borderSecondary),
                    borderRadius: BorderRadius.circular(12.0)),
                child: Row(
                  children: [
                    AppSwitch.main(
                      label: 'Email',
                      enableColor: Theme.of(context).appColors.bgBrandSolid,
                      diableColor: Theme.of(context).appColors.bgTertiary,
                      enable: true,
                      onChange: isEmail,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: AppSwitch.main(
                        label: 'SMS',
                        enableColor: Theme.of(context).appColors.bgBrandSolid,
                        diableColor: Theme.of(context).appColors.bgTertiary,
                        enable: false,
                        onChange: isSMS,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget _bottonButtons(BuildContext context, bool isSmScreen, bool formIsReady,
          double totalAmount, String currency) =>
      Container(
        constraints: BoxConstraints(maxWidth: 640),
        child: Center(
            child: Container(
          constraints: BoxConstraints(maxWidth: 640),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isSmScreen
                  ? Container()
                  : formIsReady == false
                      ? Text('Starred (*) items must be completed',
                          style: Theme.of(context)
                              .appTexts
                              .textMdMedium
                              .copyWith(
                                  color: Theme.of(context)
                                      .appColors
                                      .textErrorPrimary600))
                      : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton.buttonIcon(AppIconName.uea1fChevronLeft,
                      text: 'Back',
                      bgColor: Colors.transparent,
                      bgHoverColor: Colors.transparent,
                      textColor: Theme.of(context).appColors.buttonSecondaryFg,
                      border: Border.all(
                          color: Theme.of(context)
                              .appColors
                              .buttonSecondaryBorder),
                      borderRadius: BorderRadius.circular(8.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      context: context,
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => EmptyModal.value(
                                icon: AppIconName.ueb5cAlertTriangle,
                                title: 'Are you sure you want to cancel?',
                                subTitle:
                                    'Your ticket reservation process will be discarded, and all selected seats will be released. This action cannot be undone.',
                                cancelBtnTitle: 'No, Go Back',
                                cancelBtnBgColor: Colors.transparent,
                                onTapCancelBtn: () {
                                  context.pop();
                                },
                                processBtnTitle: 'Yes, Cancel',
                                processBtnBgColor:
                                    Theme.of(context).appColors.bgBrand,
                                onTapProcessBtn: () {
                                  context.goLanding();
                                },
                              ))),
                  SizedBox(width: isSmScreen ? 0.0 : 12.0),
                  isSmScreen
                      ? Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: _confirmBtn(isSmScreen, formIsReady,
                                  totalAmount, currency)),
                        )
                      : _confirmBtn(
                          isSmScreen, formIsReady, totalAmount, currency)
                ],
              ),
            ],
          ),
        )),
      );

  _confirmBtn(bool isSmScreen, bool formIsReady, double totalAmount,
          String currency) =>
      AppButton.buttonPrimary(
          context: context,
          text: isSmScreen && formIsReady
              ? 'Pay $currency$totalAmount'
              : isSmScreen && !formIsReady
                  ? 'Continue'
                  : 'Checkout',
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          onTap: () {
            // if (title != '' ||
            //     academyDegree != '' ||
            //     _firstNameController.text != '' ||
            //     _lastNameController.text != '' ||
            //     birthYear != 0 ||
            //     birthMonth != 0 ||
            //     birthDay != 0 ||
            //     _streetController.text != '' ||
            //     _postalCodeController.text != '' ||
            //     _cityController.text != '' ||
            //     country != '' ||
            //     _addressPhoneController.text != '' ||
            //     _emailController.text != '' ||
            //     _accountPhoneController.text != '' ||
            //     _passwordController.text != '') {
            // setState(() {
            //   formIsReady = true;
            //   showDialog(
            //       context: context,
            //       builder: (context) => SignUpModal(
            //             country: _accountSelectedCountry,
            //             phoneNumber: _accountPhoneController.text,
            //             email: _emailController.text,
            //             verificationCodeMail: (String code) {},
            //             resendCodeMail: () {},
            //             verificationCodePhone: (String code) {},
            //             resendCodePhone: () {},
            //             onAgreeTerms: () {},
            //           ));
            // });
            // } else {
            //   setState(() {
            //     formIsReady = false;
            //   });

            //   isSmScreen
            //       ? showDialog(
            //           context: context,
            //           builder: (context) => FormComplationModal.show())
            //       : null;
            // }
          });

  List<Widget> _birthDayLG({
    required bool isSmScreen,
    required List<String> monthes,
    required int year,
    required Function(int) onBirthDay,
    required Function(int) onBirthMonth,
    required Function(int) onBirthYear,
  }) =>
      [
        Expanded(
          child: AppDropDown.def(
              items: List.generate(31, (index) => (index + 1).toString()),
              label: '',
              hint: 'Day',
              onChanged: (String? v) {
                if (v != null) {
                  onBirthDay(int.parse(v));
                }
              }),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: AppDropDown.def(
              items: monthes,
              label: '',
              hint: 'Month',
              onChanged: (String? v) {
                if (v != null) {
                  onBirthMonth(monthes.indexOf(v));
                }
              }),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: AppDropDown.def(
              items: List.generate(100, (index) => (year - index).toString()),
              label: '',
              hint: 'Year',
              onChanged: (String? v) {
                if (v != null) {
                  onBirthYear(int.parse(v));
                }
              }),
        )
      ];

  List<Widget> _birthDaySM({
    required bool isSmScreen,
    required List<String> monthes,
    required int year,
    required Function(int) onBirthDay,
    required Function(int) onBirthMonth,
    required Function(int) onBirthYear,
  }) =>
      [
        AppDropDown.def(
            items: List.generate(31, (index) => (index + 1).toString()),
            label: '',
            hint: 'Day',
            onChanged: (String? v) {
              if (v != null) {
                onBirthDay(int.parse(v));
              }
            }),
        // SizedBox(width: 12.0),
        AppDropDown.def(
            items: monthes,
            label: '',
            hint: 'Month',
            onChanged: (String? v) {
              if (v != null) {
                onBirthMonth(monthes.indexOf(v));
              }
            }),
        // SizedBox(width: 12.0),
        AppDropDown.def(
            items: List.generate(100, (index) => (year - index).toString()),
            label: '',
            hint: 'Year',
            onChanged: (String? v) {
              if (v != null) {
                onBirthYear(int.parse(v));
              }
            })
      ];
}
