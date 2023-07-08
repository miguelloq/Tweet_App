import 'package:mobx/mobx.dart';
import '../models/login_request_model.dart';

//part 'login_store.g.dart';

//class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  LoginRequestModel loginModel = LoginRequestModel(email: '', password: '');
}
