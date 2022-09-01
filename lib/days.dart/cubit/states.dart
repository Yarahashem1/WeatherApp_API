abstract class weathereStates {}

class InitialState extends  weathereStates {}

class GetWeathereLoadingState extends  weathereStates {}

class GetWeathereSuccessState extends weathereStates {}

class GetWeathereErrorState extends  weathereStates
{
  final String error;

  GetWeathereErrorState(this.error);
}