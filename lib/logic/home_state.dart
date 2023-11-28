// part of используется в контексте директивы part для объединения нескольких файлов в единое целое.
part of "home_cubit.dart";

// `abstract` - ech kandai ulgu tuzulbogon tushunuktordu gana bildirgen class
// extends используется для создания наследования между классами.
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final num data;
  HomeSuccessState(this.data);
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState(this.message);
}
