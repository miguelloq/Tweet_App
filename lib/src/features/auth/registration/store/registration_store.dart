import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/auth/registration/models/registration_request_model.dart';
import 'package:tweet_app/src/core/services/auth_service_firebase.dart';

part 'registration_store.g.dart';

enum RegistrationState { idle, success, error, loading }

class RegistrationStore = _RegistrationStore with _$RegistrationStore;

abstract class _RegistrationStore with Store {
  late final AuthServiceFirebase authService;

  _RegistrationStore({required this.authService});

  @observable
  RegistrationRequestModel registrationModel =
      RegistrationRequestModel(email: '', password: '', confirmPassword: '');

  @observable
  RegistrationState screenState = RegistrationState.idle;

  @observable
  String? errorMessage;

  @action
  void changeModel(RegistrationRequestModel newModel) {
    registrationModel = newModel;
  }

  @action
  void setScreenState({required RegistrationState newState}) {
    if (screenState == RegistrationState.error &&
        newState != RegistrationState.error) {
      errorMessage = null;
    }
    screenState = newState;
  }

  @action
  void registrationAction() {
    setScreenState(newState: RegistrationState.loading);
    authService
        .registrationUser(
            email: registrationModel.email,
            password: registrationModel.password)
        .then(
      (String? error) {
        if (error != null) {
          errorMessage = error;
          setScreenState(newState: RegistrationState.error);
        } else {
          setScreenState(newState: RegistrationState.success);
        }
      },
    );
  }
}
