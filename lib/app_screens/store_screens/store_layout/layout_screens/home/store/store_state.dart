part of 'store_cubit.dart';

@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreSuccess extends StoreState {
}
class StoreError extends StoreState {
  final error ;

  StoreError(this.error);
}

class productLoading extends StoreState {}

class productSuccess extends StoreState {
}
class productError extends StoreState {
  final error ;

  productError(this.error);

}


class ProfileImagePicker extends StoreState{}