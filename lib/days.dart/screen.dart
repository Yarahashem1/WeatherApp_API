import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant/component.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class weathereLayout extends StatelessWidget {
  String? location;
  weathereLayout({this.location});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => weathereCubit()..getWeathere(location),
      child: BlocConsumer<weathereCubit, weathereStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = weathereCubit.get(context);
          var list = cubit.business;

          return Scaffold(
            body: weathereBuilder(list,location),
          );
        },
      ),
    );
  }
}
