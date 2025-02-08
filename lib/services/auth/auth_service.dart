import 'package:billit_now/services/auth/dto/verify_signup_dto.dart';
import 'package:billit_now/services/auth/response_dto/send_code_response_dto.dart';
import 'package:billit_now/services/auth/response_dto/token_wrapper_response_dto.dart';
import 'package:billit_now/services/base/base_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../shared_response_dto/message_response_dto.dart';
import 'response_dto/token_response_dto.dart';
import 'dto/code_dto.dart';
import 'dto/complete_dto.dart';
import 'dto/login_apple_dto.dart';
import 'dto/login_dto.dart';
import 'dto/login_facebook_dto.dart';
import 'dto/login_google_dto.dart';
import 'dto/password_reset_confirm_dto.dart';
import 'dto/password_reset_request_dto.dart';
import 'dto/register_dto.dart';
import 'dto/send_code_dto.dart';
import 'dto/verify_code_dto.dart';
import 'dto/verify_dto.dart';

part 'auth_service.g.dart';

const AuthServiceVersion = "v1";

@RestApi()
@singleton
abstract class AuthService extends BaseService {

  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST('auth/api/$AuthServiceVersion/auth/code')
  Future<void> code(@Body() CodeDto codeDto);

  @POST('auth/api/$AuthServiceVersion/auth/verify-code')
  Future<void> verifyCode(@Body() VerifyCodeDto verifyCodeDto);

  @POST('auth/api/$AuthServiceVersion/auth/login')
  Future<void> login(@Body() LoginDto loginDto);

  @POST('auth/api/$AuthServiceVersion/auth/register')
  Future<void> register(@Body() RegisterDto registerDto);

  @POST('auth/api/$AuthServiceVersion/auth/login/google')
  Future<TokenWrapperResponseDto> loginGoogle(@Body() LoginGoogleDto loginGoogleDto);

  @POST('auth/api/$AuthServiceVersion/auth/login/facebook')
  Future<TokenWrapperResponseDto> loginFacebook(@Body() LoginFacebookDto loginFacebookDto);

  @POST('auth/api/$AuthServiceVersion/auth/login/apple')
  Future<TokenWrapperResponseDto> loginApple(@Body() LoginAppleDto loginAppleDto);

  @POST('auth/api/$AuthServiceVersion/auth/password-reset/request')
  Future<MessageResponseDto> passwordResetRequest(@Body() PasswordResetRequestDto passwordResetRequestDto);

  @POST('auth/api/$AuthServiceVersion/auth/password-reset/confirm')
  Future<MessageResponseDto> passwordResetConfirm(@Body() PasswordResetConfirmDto passwordResetConfirmDto);

  @POST('auth/api/$AuthServiceVersion/auth/logout')
  Future<MessageResponseDto> logout();

  @POST('auth/api/$AuthServiceVersion/auth/send-code')
  Future<SendCodeResponseDto> sendCode(@Body() SendCodeDto sendCodeDto);

  @POST('auth/api/$AuthServiceVersion/auth/verify')
  Future<TokenWrapperResponseDto> verify(@Body() VerifyDto verifyDto);

  @POST('auth/api/$AuthServiceVersion/auth/verify-signup')
  Future<TokenWrapperResponseDto> verifySignup(@Body() VerifySignupDto verifyDto);

  @GET('auth/api/$AuthServiceVersion/auth/status')
  Future<void> status(@Query('email') String email, @Query('phone') String phone);

  @POST('auth/api/$AuthServiceVersion/auth/signup/complete')
  Future<TokenWrapperResponseDto> complete(@Body() CompleteDto completeDto);

  @GET('auth/api/$AuthServiceVersion/auth/validate')
  Future<void> validate();

}