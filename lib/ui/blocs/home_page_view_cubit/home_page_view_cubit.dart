import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_view_state.dart';

class HomePageViewCubit extends Cubit<HomePageViewState> {
  HomePageViewCubit() : super(const HomePageViewState());

  void navigateTo(int index) {
    emit(HomePageViewState(currentIndex: index));
  }
}
