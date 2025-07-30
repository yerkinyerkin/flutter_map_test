part of 'building_bloc.dart';

@freezed
class BuildingState with _$BuildingState {
  const factory BuildingState.initial() = _Initial;
  const factory BuildingState.loading() = _Loading;
  const factory BuildingState.loaded(List<Building> data) = _Loaded;
  const factory BuildingState.error(String message) = _Error;
}
