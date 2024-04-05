import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:bloc/bloc.dart';

// Project Files
part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(const BottomNavBarState());

  void navigateTo(int index) {
    emit(BottomNavBarState(currentIndex: index));
  }
}
