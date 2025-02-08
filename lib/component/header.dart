import 'package:billit_now/apps/helper/header_actions.dart';
import 'package:billit_now/apps/helper/router/router_extention/landing_router_extention.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/component/modal_dropdown.dart';
import 'package:billit_now/component/modal_search.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateful_widget.dart';
import 'package:billit_now/features/base/base_stateful_page.dart';
import 'package:billit_now/features/base/base_stateless_page.dart';
import 'package:billit_now/local_storage/auth/AuthStorage.dart';
import 'package:billit_now/core/di/di_setup.dart';
import 'package:billit_now/core/localization/layout_direction.dart';
import 'package:billit_now/core/localization/localize.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/repositories/auth/auth_repository.dart';
import 'package:billit_now/repositories/auth/models/logged_user_info_model.dart';
import 'package:billit_now/repositories/event/models/lang_model.dart';
import 'package:billit_now/templates/auth/widgets/logged_in_modal.dart';
import 'package:billit_now/templates/landing/widgets/account_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../core/localization/languages.dart';

sealed class HeaderEvent extends BaseBlocEvent {}

class LogoutEvent extends HeaderEvent {}

@injectable
class HeaderBloc extends BaseBloc<BaseBlocEvent, BaseBlocState> {
  final AuthRepository authRepo;

  HeaderBloc({required this.authRepo}) {
    on<EventInitial>((event, emit) async => callRepoWithResult(
        emit: emit, repoFunc: await authRepo.loggedUserInfo()));
    on<LogoutEvent>((event, emit) async {
      print('TAGX logout event');
      return callRepo(emit: emit, repoFunc: await authRepo.logoutUser());
    });
  }
}

class Header extends BaseStatelessPage {
  const Header({super.key, required this.scrollController, this.activeAction});

  final ScrollController scrollController;
  final HeaderActions? activeAction;

  @override
  List setProviders(BuildContext context) {
    return [
      BlocProvider(create: (context) {
        return getIt<HeaderBloc>();
      })
    ];
  }

  @override
  Widget body(BuildContext context) {
    return HeaderWidget(
        scrollController: scrollController, activeAction: activeAction);
  }
}

class HeaderWidget extends BaseBlocStatefulWidget
    implements PreferredSizeWidget {
  const HeaderWidget(
      {super.key, required this.scrollController, this.activeAction})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  final ScrollController scrollController;
  final HeaderActions? activeAction;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();

  @override
  final Size preferredSize;
}

class _HeaderWidgetState extends BaseBlocStateWidget<HeaderWidget, HeaderBloc> {
  final OverlayPortalController accountDropDownController =
      OverlayPortalController();
  final OverlayPortalController langCurrencyDropDownController =
      OverlayPortalController();
  final OverlayPortalController searchModalController =
      OverlayPortalController();

  // late ScrollController _scrollController;
  bool _isAppBarVisible = true;

  final TextEditingController searchTextFieldController =
      TextEditingController();
  bool isShowingSearchModal = false;
  List<Map> serachResults = [];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);

    searchTextFieldController.addListener(() {
      if (searchTextFieldController.value.text.isNotEmpty) {
        setState(() {
          serachResults = [
            {
              'category': 'Artists',
              'items': [
                {
                  'icon': 'assets/images/test_image.png',
                  'title': 'Behnam Bani',
                  'subTitle': '5 live events',
                },
                {
                  'icon':
                      'assets/images/q3FF1F7zZM36pkqBp0ukQ5Pve4p2b8tsj65qdeOq.webp',
                  'title': 'Sirvan Khosravi',
                  'subTitle': '3 live events',
                }
              ]
            },
            {
              'category': 'Events',
              'items': [
                {
                  'icon': 'assets/images/ebi.png',
                  'title': 'Behnam Bani',
                  'subTitle': '5 live events',
                },
                {
                  'icon':
                      'assets/images/concert_hall_with_people_landscape.png',
                  'title': 'Sirvan Khosravi',
                  'subTitle': '3 live events',
                },
                {
                  'icon': 'assets/images/11721_photo.jpg',
                  'title': 'Behnam Bani',
                  'subTitle': '5 live events',
                },
                {
                  'icon': 'assets/images/gorbani.jpg',
                  'title': 'Sirvan Khosravi',
                  'subTitle': '3 live events',
                }
              ]
            }
          ];
        });
      }
    });
  }

  void _scrollListener() {
    if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // Scrolling down
      if (_isAppBarVisible) {
        setState(() {
          _isAppBarVisible = false;
        });
      }
    } else if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // Scrolling up
      if (!_isAppBarVisible) {
        setState(() {
          _isAppBarVisible = true;
        });
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  OverlayPortalController loggedModalController = OverlayPortalController();

  @override
  Widget body(BuildContext context, BaseBlocState state) {
    if (
        // get check loggedIn on initial
        state is StateInitial ||
            //check againt if logout is success
            state is StateSuccess) {
      addEvent(context, EventInitial());
    }

    return Directionality(
        textDirection: getLayoutDirection() == LayoutDirection.ltr
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          height: _isAppBarVisible ? kToolbarHeight : 0,
          child: AppBar(
            actions: [
              context.isSmallTabletOrLess
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AppButton.buttonIcon(AppIconName.ueb0aMenu02,
                          iconSize: 15,
                          bgColor: Colors.transparent,
                          bgHoverColor: Colors.transparent,
                          textColor: Colors.transparent,
                          padding: const EdgeInsets.all(2),
                          context: context,
                          onTap: () => Scaffold.of(context).openEndDrawer()),
                    )
                  : Container(),
            ],
            title: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: context.logicalWidth),
                margin: EdgeInsets.symmetric(
                    horizontal: context.logicalWidth > 1200 ? 64 : 0,
                    vertical: 14),
                child: context.isSmallTabletOrLess
                    ? _smScreen(state)
                    : _lgScreen(state, loggedModalController),
              ),
            ),
            backgroundColor:
                Theme.of(context).appColors.bgSecondary.withOpacity(0.9),
            shadowColor: Colors.transparent,
            surfaceTintColor: Theme.of(context).appColors.bgSecondary,
            foregroundColor: Colors.transparent,
            elevation: 0,
          ),
        ));
  }

  _lgScreen(
          BaseBlocState state, OverlayPortalController loggedModalController) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: 420,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: AppIcon.logo(
                    appIconName: AppIconName.logoFullLTR,
                    context: context,
                    size: 30,
                  ),
                  onTap: () => context.goLanding()),
              // Home, Events, Artists, Venues Buttons
              SizedBox(
                width: 310,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton.buttonTertiary(
                          text: getString("home"),
                          context: context,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          bgColor: widget.activeAction == HeaderActions.home
                              ? Theme.of(context).appColors.bgActive
                              : Colors.transparent,
                          onTap: () {
                            context.goLanding();
                          }),
                      AppButton.buttonTertiary(
                          text: getString("events"),
                          context: context,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          bgColor: widget.activeAction == HeaderActions.events
                              ? Theme.of(context).appColors.bgActive
                              : Colors.transparent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EmptyModal.show(context: context);
                              },
                            );
                          }),
                      AppButton.buttonTertiary(
                          text: getString("artists"),
                          context: context,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          bgColor: widget.activeAction == HeaderActions.artists
                              ? Theme.of(context).appColors.bgActive
                              : Colors.transparent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EmptyModal.show(context: context);
                              },
                            );
                          }),
                      AppButton.buttonTertiary(
                          text: getString("venues"),
                          context: context,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          bgColor: widget.activeAction == HeaderActions.venues
                              ? Theme.of(context).appColors.bgActive
                              : Colors.transparent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EmptyModal.show(context: context);
                              },
                            );
                          }),
                    ]),
              )
            ],
          ),
        ),
        // Create & host events,lang and currency and account btns
        SizedBox(
            width: 450,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 310,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton.buttonTertiary(
                          text: getString("create_and_host_events"),
                          context: context,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EmptyModal.show(context: context);
                              },
                            );
                          }),
                      ModalDropDown.langCurrency(
                        controller: langCurrencyDropDownController,
                        context: context,
                        onChangeLang: (LangCurrencyModel lang) {
                          for (int i = 0; i < Language.values.length; i++) {
                            if (lang.title == Language.values[i].title &&
                                lang.subTitle == Language.values[i].subTitle) {
                              getIt<Localize>()
                                  .setSelectedLanguage(Language.values[i]);
                              break;
                            }
                          }
                        },
                        onChangeCurrency: (LangCurrencyModel currency) {},
                      )
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 32,
                  color: Theme.of(context).appColors.borderPrimary,
                ),
                SizedBox(
                  width: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ModalSearch.def(
                        context: context,
                        controller: searchModalController,
                        searchTextFieldController: searchTextFieldController,
                        serachResults: serachResults,
                        onDismiss: () {
                          searchModalController.hide();
                          setState(() {
                            isShowingSearchModal = false;
                          });
                        },
                        child: AppButton.buttonIcon(AppIconName.ueb1dSearchLg,
                            iconSize: 20,
                            bgColor: Colors.transparent,
                            bgHoverColor: Colors.transparent,
                            textColor: Colors.transparent,
                            padding: const EdgeInsets.all(2),
                            border: Border.all(
                                color: isShowingSearchModal
                                    ? Theme.of(context).appColors.borderBrand
                                    : Colors.transparent,
                                width: 1),
                            context: context, onTap: () {
                          searchModalController.toggle();
                          searchTextFieldController.text = '';
                          serachResults = [];
                          setState(() {
                            isShowingSearchModal = true;
                          });
                        }),
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: AppButton.buttonIcon(AppIconName.ueb60Bell01,
                            iconSize: 20,
                            bgColor: Colors.transparent,
                            bgHoverColor: Colors.transparent,
                            textColor: Colors.transparent,
                            padding: const EdgeInsets.all(2),
                            context: context, onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EmptyModal.show(context: context);
                            },
                          );
                        }),
                      ),
                      state is StateSuccessWithResult<LoggedUserInfoModel>
                          ? SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: LoggedInModal(
                                  isRtl: false,
                                  controller: loggedModalController,
                                  firstName: state.result.firstName,
                                  lastName: state.result.lastName,
                                  mail: state.result.email,
                                  offset: Offset(-150, 35),
                                  compositWidth: 0.0,
                                  compositHeight: 0.0,
                                  compositTarget: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .appColors
                                            .bgSecondaryHover,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                      child: Text(
                                          '${state.result.firstName[0].toUpperCase()}${state.result.lastName[1].toUpperCase()}',
                                          style: Theme.of(context)
                                              .appTexts
                                              .textMdSemiBold
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .appColors
                                                      .fgQuinary400)),
                                    ),
                                  ),
                                  onTapViewProfile: () {
                                    loggedModalController.toggle();
                                    EmptyModal.show(context: context);
                                  },
                                  onTapAccountSettings: () {
                                    loggedModalController.toggle();
                                    EmptyModal.show(context: context);
                                  },
                                  onTapSignOut: () {
                                    loggedModalController.toggle();
                                    addEvent(context, LogoutEvent());
                                  }),
                            )
                          : AccountDropDown.logIn(
                              controller: accountDropDownController,
                              context: context,
                              items: [],
                              onChanged: (_) {})
                    ],
                  ),
                ),
              ],
            ))
      ]);
  _smScreen(BaseBlocState state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: AppIcon.logo(
              appIconName: AppIconName.logoFullLTR,
              context: context,
              size: 30,
            ),
            onTap: () => context.goLanding(),
          ),
          AppButton.buttonIcon(AppIconName.ueb60Bell01,
              iconSize: 20,
              bgColor: Colors.transparent,
              bgHoverColor: Colors.transparent,
              textColor: Colors.transparent,
              padding: const EdgeInsets.all(2),
              context: context, onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EmptyModal.show(context: context);
              },
            );
          })
        ],
      );

  @override
  void consumeState(BuildContext context, BaseBlocState state) {}
}
