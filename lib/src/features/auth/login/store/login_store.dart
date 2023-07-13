import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/core/services/auth_service_firebase.dart';
import '../models/login_request_model.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

enum LoginState { idle, success, error, loading }

abstract class _LoginStore with Store {
  late final AuthServiceFirebase authService;

  _LoginStore({required this.authService});

  LoginRequestModel loginModel = LoginRequestModel(email: '', password: '');

  @observable
  String? errorMessage;

  @observable
  LoginState screenState = LoginState.idle;

  @observable
  bool isPasswordFieldObscure = true;

  @action
  void setScreenState({required LoginState newState}) {
    if (screenState == LoginState.error && newState != LoginState.error) {
      errorMessage = null;
    }
    screenState = newState;
  }

  @action
  void changePasswordVisibility() {
    isPasswordFieldObscure = !isPasswordFieldObscure;
  }

  @action
  void loginAction() {
    setScreenState(newState: LoginState.loading);
    authService
        .loginUser(email: loginModel.email, password: loginModel.password)
        .then(
      (String? error) {
        if (error != null) {
          errorMessage = error;
          setScreenState(newState: LoginState.error);
        } else {
          setScreenState(newState: LoginState.success);
        }
      },
    );
  }
}
