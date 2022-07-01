abstract class CentersState {}

class CentersInitial extends CentersState {}
class CentersLoading extends CentersState {}

class CentersSuccess extends CentersState {
  // final CreateCenterModel createCenterModel ;
  CentersSuccess();
}
class CentersError extends CentersState {
  final error;

  CentersError(this.error);


}

class ProfileImagePicker extends CentersState{}