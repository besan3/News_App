abstract class CubitStates{}
class InitialState extends CubitStates{}
class ChangeScreenState extends CubitStates{}
class GetBusinessDataLoadingState extends CubitStates{}
class GetBusinessSuccessState extends CubitStates{}
class GetBusinessErrorState extends CubitStates{
  final String? error;
GetBusinessErrorState(this.error);
}
class GetSportsDataLoadingState extends CubitStates{}
class GetSportsSuccessState extends CubitStates{}
class GetSportsErrorState extends CubitStates{
  final String? error;
  GetSportsErrorState(this.error);
}
class GetScienceDataLoadingState extends CubitStates{}
class GetScienceSuccessState extends CubitStates{}
class GetScienceErrorState extends CubitStates{
  final String? error;
  GetScienceErrorState(this.error);
}
class GetSearchDataLoadingState extends CubitStates{}
class GetSearchSuccessState extends CubitStates{}
class GetSearchErrorState extends CubitStates{
  final String? error;
  GetSearchErrorState(this.error);
}
class AppChangeModeState extends CubitStates{}
