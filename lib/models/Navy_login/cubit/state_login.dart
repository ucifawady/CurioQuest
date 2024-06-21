
abstract class NavyLoginStates{}
class NavyLoginInitialState extends NavyLoginStates{}
class NavyLoginLoadingState extends NavyLoginStates{}
class NavyLoginSuccessState extends NavyLoginStates{
  final String uId;
  NavyLoginSuccessState(this.uId);

}
class NavyLoginErrorState extends NavyLoginStates{
  final String error;
  NavyLoginErrorState(this.error);
}
class NavyChangePasswordVisibilityState extends NavyLoginStates{}
