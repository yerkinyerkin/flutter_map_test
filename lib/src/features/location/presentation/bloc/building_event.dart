part of 'building_bloc.dart';

@freezed
class BuildingEvent with _$BuildingEvent {
  const factory BuildingEvent.fetch() = _Fetch;
  const factory BuildingEvent.search(String query) = _Search;
}
