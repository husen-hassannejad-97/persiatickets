import 'package:billit_now/local_storage/auth/AuthStorage.dart';
import 'package:billit_now/repositories/auth/input_models/code_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/complete_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/login_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/password_reset_confirm_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/password_reset_request_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/register_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/send_code_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/status_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/verify_code_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/verify_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/verify_signup_input_model.dart';
import 'package:billit_now/repositories/auth/mappers/auth_type_enum_response_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/code_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/complete_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/logged_user_info_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/login_apple_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/login_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/login_facebook_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/login_google_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/password_reset_confirm_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/password_reset_request_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/register_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/send_code_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/token_response_dto_entity_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/verify_code_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/verify_dto_mapper.dart';
import 'package:billit_now/repositories/auth/mappers/verify_signup_dto_mapper.dart';
import 'package:billit_now/repositories/auth/models/auth_type_enum_model.dart';
import 'package:billit_now/repositories/auth/models/logged_user_info_model.dart';
import 'package:billit_now/repositories/base/base_repository.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/repositories/shared/mappers/device_info_dto_mapper.dart';
import 'package:billit_now/repositories/shared/models/device_info_model.dart';
import 'package:billit_now/repositories/shared/result.dart';
import 'package:billit_now/services/auth/auth_service.dart';
import 'package:billit_now/services/auth/dto/logged_user_info_dto.dart';
import 'package:billit_now/services/auth/dto/login_facebook_dto.dart';
import 'package:billit_now/services/auth/dto/login_google_dto.dart';
import 'package:billit_now/services/auth/response_dto/send_code_response_dto.dart';
import 'package:billit_now/services/auth/response_dto/token_response_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../services/auth/response_dto/token_wrapper_response_dto.dart';

@singleton
class AuthRepository extends BaseRepository {
  AuthStorage authStorage;
  AuthService authService;
  CodeDtoMapper codeDtoMapper;
  CompleteDtoMapper completeDtoMapper;
  LoginDtoMapper loginDtoMapper;
  LoginAppleDtoMapper loginAppleDtoMapper;
  LoginFacebookDtoMapper loginFacebookDtoMapper;
  LoginGoogleDtoMapper loginGoogleDtoMapper;
  PasswordResetConfirmDtoMapper passwordResetConfirmDtoMapper;
  PasswordResetRequestDtoMapper passwordResetRequestDtoMapper;
  RegisterDtoMapper registerDtoMapper;
  SendCodeDtoMapper sendCodeDtoMapper;
  VerifyCodeDtoMapper verifyCodeDtoMapper;
  VerifyDtoMapper verifyDtoMapper;
  VerifySignupDtoMapper verifySignupDtoMapper;
  LoggedUserInfoDtoMapper loggedUserInfoDtoMapper;
  TokenResponseDtoEntityMapper tokenResponseDtoEntityMapper;
  AuthTypeEnumResponseDtoMapper authTypeEnumResponseDtoMapper;
  DeviceInfoDtoMapper deviceInfoDtoMapper;
  AuthRepository({
    required this.authStorage,
    required this.authService,
    required this.codeDtoMapper,
    required this.completeDtoMapper,
    required this.loginDtoMapper,
    required this.loginAppleDtoMapper,
    required this.loginFacebookDtoMapper,
    required this.loginGoogleDtoMapper,
    required this.passwordResetConfirmDtoMapper,
    required this.passwordResetRequestDtoMapper,
    required this.registerDtoMapper,
    required this.sendCodeDtoMapper,
    required this.verifyCodeDtoMapper,
    required this.verifyDtoMapper,
    required this.verifySignupDtoMapper,
    required this.loggedUserInfoDtoMapper,
    required this.tokenResponseDtoEntityMapper,
    required this.authTypeEnumResponseDtoMapper,
    required this.deviceInfoDtoMapper,
  });

  Future<Result<void>> code(CodeInputModel codeInputModel) async {
    return callApi(() {
      return authService.code(codeDtoMapper.toDto(codeInputModel));
    });
  }

  Future<Result<void>> verifyCode(
      VerifyCodeInputModel verifyCodeInputModel) async {
    return callApi(() {
      return authService
          .verifyCode(verifyCodeDtoMapper.toDto(verifyCodeInputModel));
    });
  }

  Future<Result<void>> login(LoginInputModel loginInputModel) async {
    return callApi(() {
      return authService.login(loginDtoMapper.toDto(loginInputModel));
    });
  }

  Future<Result<void>> register(RegisterInputModel registerInputModel) async {
    return callApi(() {
      return authService.register(registerDtoMapper.toDto(registerInputModel));
    });
  }

  // Future<Result<void>> loginGoogle(LoginGoogleInputModel loginGoogleInputModel) async {
  //   var result = callApi(() { return authService.loginGoogle(loginGoogleDtoMapper.toDto(loginGoogleInputModel));});
  //   if(result is Success) {
  //     final token = (result as Success<TokenWrapperResponseDto>).data.token;
  //     if(token != null) {
  //       authStorage.saveToken(tokenResponseDtoEntityMapper.fromDto(token));
  //       return Success<Object>(data: Object());
  //     } else {
  //       return Error(error: UnauthorizedException());
  //     }
  //   } else {
  //     return result;
  //   }
  // }

  // Future<Result<void>> loginFacebook(LoginFacebookInputModel loginFacebookInputModel) async {
  //   var result = callApi((){ return authService.loginFacebook(loginFacebookDtoMapper.toDto(loginFacebookInputModel)); });
  //   if(result is Success) {
  //     final token = (result as Success<TokenWrapperResponseDto>).data.token;
  //     if(token != null) {
  //       authStorage.saveToken(tokenResponseDtoEntityMapper.fromDto(token));
  //       return Success<Object>(data: Object());
  //     } else {
  //       return Error(error: UnauthorizedException());
  //     }
  //   } else {
  //     return result;
  //   }
  // }

  // Future<Result<void>> loginApple(LoginAppleInputModel loginAppleInputModel) async {
  //   var result = callApi(() { return authService.loginApple(loginAppleDtoMapper.toDto(loginAppleInputModel)); });
  //   if(result is Success) {
  //     final token = (result as Success<TokenWrapperResponseDto>).data.token;
  //     if(token != null) {
  //       authStorage.saveToken(tokenResponseDtoEntityMapper.fromDto(token));
  //       return Success<Object>(data: Object());
  //     } else {
  //       return Error(error: UnauthorizedException());
  //     }
  //   } else {
  //     return result;
  //   }
  // }

  Future<Result<void>> passwordResetRequest(
      PasswordResetRequestInputModel passwordResetRequestInputModel) async {
    return callApi(() {
      return authService.passwordResetRequest(
          passwordResetRequestDtoMapper.toDto(passwordResetRequestInputModel));
    });
  }

  Future<Result<void>> passwordResetConfirm(
      PasswordResetConfirmInputModel passwordResetConfirmInputModel) async {
    return callApi(() {
      return authService.passwordResetConfirm(
          passwordResetConfirmDtoMapper.toDto(passwordResetConfirmInputModel));
    });
  }

  Future<Result<void>> logout() async {
    var result = callApi(() {
      return authService.logout();
    });
    if (result is Success) {
      authStorage.removeToken();
      return Success<Object>(data: Object());
    } else {
      return result;
    }
  }

  Future<Result<AuthTypeEnumModel>> sendCode(
      SendCodeInputModel sendCodeInputModel) async {
    return callApi<SendCodeResponseDto>(() {
      return authService.sendCode(sendCodeDtoMapper.toDto(sendCodeInputModel));
    }).map(
      (SendCodeResponseDto data) =>
          authTypeEnumResponseDtoMapper.fromDto(data.type),
    );
  }

  Future<Result<void>> verify(VerifyInputModel verifyInputModel) async {
    Result<TokenWrapperResponseDto> result = await callApi(() {
      return authService.verify(verifyDtoMapper.toDto(verifyInputModel));
    });

    if (result is Success<TokenWrapperResponseDto>) {
      TokenResponseDto? token = result.data.token;
      if (token != null) {
        authStorage.saveToken(tokenResponseDtoEntityMapper.fromDto(token));
        return Success<Object>(data: Object());
      } else {
        return result;
      }
    } else {
      return result;
    }
  }

  Future<Result<void>> verifySignup(
      VerifySignupInputModel verifySignupInputModel) async {
    Result<TokenWrapperResponseDto> result =
        await callApi(() => authService.verifySignup(
              verifySignupDtoMapper.toDto(verifySignupInputModel),
            ));

    if (result is Success<TokenWrapperResponseDto>) {
      TokenResponseDto? token = result.data.token;
      if (token != null) {
        authStorage.saveToken(tokenResponseDtoEntityMapper.fromDto(token));

        return Success<Object>(data: Object());
      } else {
        return result;
      }
    } else {
      return result;
    }
  }

  Future<Result<void>> status(StatusInputModel statusInputModel) async {
    throw UnimplementedError();
  }

  Future<Result<void>> complete(CompleteInputModel completeInputModel) async {
    var result = callApi(() {
      return authService.complete(completeDtoMapper.toDto(completeInputModel));
    });
    if (result is Success) {
      final token = (result as Success<TokenWrapperResponseDto>).data.token;
      if (token != null) {
        authStorage.saveToken(tokenResponseDtoEntityMapper.fromDto(token));
        return Success<Object>(data: Object());
      } else {
        return Error(error: UnauthorizedError());
      }
    } else {
      return result;
    }
  }

  Future<Result<void>> validate() async {
    return callApi(() {
      return authService.validate();
    });
  }

  Future<Result<LoggedUserInfoModel>> loggedUserInfo() async {
    Result<String?> result =
        await callStorage(() => authStorage.readTokenAsString());

    if (result is Success<String?>) {
      String? token = result.data;
      if (token != null) {
        if (JwtDecoder.isExpired(token)) {
          return Error(
            error: IOError(
                message: 'Your session has expired. Please log in again.'),
          );
        }

        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        return Success(
            data: loggedUserInfoDtoMapper
                .fromDto(LoggedUserInfoDto.fromJson(decodedToken)));
      } else {
        return Error(
          error: IOError(message: "You are not logged in."),
        );
      }
    } else {
      return Error(
        error: IOError(message: "An IOException encountered!"),
      );
    }
  }

  Future<Result<void>> logoutUser() async {
    print('TAGX repo');
    return await callStorage(() => authStorage.removeTokenAsString());
  }

  Future<Result<void>> loginGoogle(DeviceInfoModel deviceModel) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'openid',
        ],
      );
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;
        final token = auth.accessToken;
        auth.idToken;
        if (token != null) {
          var result = callApi(() {
            return authService.loginGoogle(LoginGoogleDto(
                token: token, device: deviceInfoDtoMapper.toDto(deviceModel)));
          });
          if (result is Success) {
            final ourToken =
                (result as Success<TokenWrapperResponseDto>).data.token;
            if (ourToken != null) {
              authStorage
                  .saveToken(tokenResponseDtoEntityMapper.fromDto(ourToken));
              return Success<Object>(data: Object());
            } else {
              return Error(error: UnauthorizedError());
            }
          } else {
            return Error(error: UnexpectedError(message: 'UEE'));
          }
        } else {
          return Error(error: UnexpectedError(message: 'UEE'));
        }
      } else {
        return Error(error: UnexpectedError(message: 'UEE'));
      }
    } catch (e) {
      return Error(error: UnexpectedError(message: 'UEE'));
    }
  }

  Future<Result<void>> loginFacebook(DeviceInfoModel deviceModel) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken?.tokenString;
        if (accessToken != null) {
          var result = callApi(() {
            return authService.loginFacebook(LoginFacebookDto(
                token: accessToken,
                device: deviceInfoDtoMapper.toDto(deviceModel)));
          });
          if (result is Success) {
            final ourToken =
                (result as Success<TokenWrapperResponseDto>).data.token;
            if (ourToken != null) {
              authStorage
                  .saveToken(tokenResponseDtoEntityMapper.fromDto(ourToken));
              return Success<Object>(data: Object());
            } else {
              return Error(error: UnauthorizedError());
            }
          } else {
            return Error(error: UnexpectedError(message: 'UEE'));
          }
        } else {
          return Error(error: UnexpectedError(message: 'UEE'));
        }
      } else {
        return Error(error: UnexpectedError(message: 'UEE'));
      }
    } catch (e) {
      return Error(error: UnexpectedError(message: 'UEE'));
    }
  }

  Future<Result<void>> loginApple(DeviceInfoModel deviceModel) async {
    try {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        // final credential = await SignInWithApple.getAppleIDCredential(
        //   scopes: [
        //     AppleIDAuthorizationScopes.email,
        //     AppleIDAuthorizationScopes.fullName,
        //   ],
        // );
        // final token = credential.identityToken;
        // if (token != null) {
        //   var result = callApi(() {
        //     return authService.loginApple(LoginAppleDto(identityToken: token, device: deviceInfoDtoMapper.toDto(deviceModel)));
        //   });
        //   if(result is Success) {
        //     final ourToken = (result as Success<TokenWrapperResponseDto>).data.token;
        //     if(ourToken != null) {
        //       authStorage.saveToken(tokenResponseDtoEntityMapper.fromDto(ourToken));
        //       return Success<Object>(data: Object());
        //     } else {
        //       return Error(error: UnauthorizedException());
        //     }
        //   } else {
        //     return Error(error: UnexpectedErrorException(message: 'UEE'));
        //   }
        // } else {
        //   return Error(error: UnexpectedErrorException(message: 'UEE'));
        // }
        return Success(data: Object());
      } else {
        return Error(error: UnexpectedError(message: 'UEE'));
      }
    } catch (e) {
      return Error(error: UnexpectedError(message: 'UEE'));
    }
  }
}
