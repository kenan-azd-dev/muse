import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

part 'home_page_view_state.dart';

class HomePageViewCubit extends Cubit<HomePageViewState> {
  HomePageViewCubit() : super(const HomePageViewState());

  void navigateTo(int index) {
    emit(HomePageViewState(currentIndex: index));
  }
}
