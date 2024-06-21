
abstract class NavyRegisterStates{}
class NavyRegisterIntialState extends NavyRegisterStates{}
class NavyRegisterLoadingState extends NavyRegisterStates{}
class NavyRegisterSuccessState extends NavyRegisterStates{
}
class NavyRegisterErrorState extends NavyRegisterStates{
  final String error;
  NavyRegisterErrorState(this.error);
}
class NavyCreateUserSuccessState extends NavyRegisterStates{
}
class NavyCreateUserErrorState extends NavyRegisterStates{
  final String error;
  NavyCreateUserErrorState(this.error);
}
class NavyRegisterChangePasswordVisibilityState extends NavyRegisterStates{}
