import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/features/base/base_bloc_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../apps/helper/utils/app_icon_name.dart';
import '../../../component/app_button.dart';
import '../../../features/base/base_bloc.dart';
import '../../../features/base/base_bloc_event.dart';
import '../../../features/base/base_bloc_state.dart';
import '../../../repositories/auth/auth_repository.dart';
import 'device_info_provider.dart';

class GoogleSignInDone extends BaseBlocEvent {}

class GoogleSignInError extends BaseBlocEvent {}

class LoginGoogleEvent extends BaseBlocEvent {}

class PerformGoogleLogin extends LoginGoogleEvent {}

@injectable
class LoginGoogleBloc extends BaseBloc<LoginGoogleEvent, BaseBlocState> {
  AuthRepository authRepo;
  LoginGoogleBloc({
    required this.authRepo,
  }) {
    on<PerformGoogleLogin>((event, emit) async {
      callRepo(
          emit: emit,
          repoFunc: await authRepo.loginGoogle(await getDeviceInfoModel()));
    });
  }
}

class LoginGoogle extends BaseBlocStatelessWidget<LoginGoogleBloc> {
  LoginGoogle({super.key, required this.isEnabled});

  final bool isEnabled;

  @override
  Widget body(BuildContext context, BaseBlocState state) {
    return AppButton.buttonIcon(
        text: getString("continue_with_Google"),
        AppIconName.logoGoogle,
        iconSize: 24,
        textColor: Theme.of(context).appColors.textSecondary700,
        bgColor: isEnabled
            ? Theme.of(context).appColors.bgPrimary
            : Theme.of(context).appColors.bgDisabled,
        bgHoverColor: Theme.of(context).appColors.bgPrimaryHover,
        border: isEnabled
            ? Theme.of(context).appDimensions.borderPrimary
            : Theme.of(context).appDimensions.borderDisablePrimaryButton,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        context: context,
        disable: !isEnabled, onTap: () {
      addEvent(context, PerformGoogleLogin());
    });
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is StateSuccess) {
      addEvent(context, GoogleSignInDone());
    } else {
      addEvent(context, GoogleSignInError());
    }
  }
}
