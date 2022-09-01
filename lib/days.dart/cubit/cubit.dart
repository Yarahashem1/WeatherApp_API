import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/days.dart/cubit/states.dart';

import '../../constant/dio.dart';

class weathereCubit extends Cubit<weathereStates> {
  weathereCubit() : super(InitialState());

  static weathereCubit get(context) => BlocProvider.of(context);
 

  List<dynamic> business = [];

  void getWeathere(String? location) {
    emit(GetWeathereLoadingState());

    DioHelper.getData(
      url: 'data/2.5/forecast',
      query: {
        'q': location,
        'appid': 'b9f03ff8fcde2139195df21adcdf3b28',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['list'];
      print(business[0]['main']['temp']);

      emit(GetWeathereSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetWeathereErrorState(error.toString()));
    });
  }
}
