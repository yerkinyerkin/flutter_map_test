import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:map_test/src/features/location/data/datasources/remote_datasource.dart';
import 'package:map_test/src/features/location/data/models/building_model.dart';

part 'building_event.dart';
part 'building_state.dart';
part 'building_bloc.freezed.dart';

class BuildingBloc extends Bloc<BuildingEvent, BuildingState> {
  final RemoteDatasource dataSource;

  late BuildingResponse _allBuildings;

  BuildingBloc(this.dataSource) : super(const BuildingState.initial()) {
    on<BuildingEvent>((event, emit) async {
      await event.map(
        fetch: (_) async {
          emit(const BuildingState.loading());
          try {
            final data = await dataSource.fetchBuildings();
            _allBuildings = data;
            emit(BuildingState.loaded(data.buildings));
          } catch (e) {
            emit(BuildingState.error(e.toString()));
          }
        },
        search: (value) async {
          final query = value.query.toLowerCase();
          final filtered = _allBuildings.buildings.where((b) {
            final address = b.address?.toLowerCase() ?? '';
            return address.contains(query);
          }).toList();
          emit(BuildingState.loaded(filtered));
        },
      );
    });
  }
}
