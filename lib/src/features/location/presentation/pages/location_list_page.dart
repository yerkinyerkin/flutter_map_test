import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_test/src/features/location/data/datasources/remote_datasource.dart';
import 'package:map_test/src/features/location/presentation/bloc/building_bloc.dart';
import 'package:map_test/src/features/location/presentation/pages/location_details_page.dart';
import 'package:map_test/src/features/location/presentation/widgets/building_item.dart';

class LocationListPage extends StatefulWidget {
  const LocationListPage({super.key});

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: BlocProvider(
            create: (_) => BuildingBloc(RemoteDatasource())
              ..add(const BuildingEvent.fetch()),
            child: Column(
              children: [
                const SizedBox(height: 15),
                BlocBuilder<BuildingBloc, BuildingState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(child: Text('')),
                      loading: () => const Center(child: Text('')),
                      loaded: (data) => Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            context
                                .read<BuildingBloc>()
                                .add(BuildingEvent.search(value));
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Поиск',
                            hintStyle: GoogleFonts.montserrat(
                                fontSize: 16, color: const Color(0xff7E7E7E)),
                          ),
                        ),
                      ),
                      error: (msg) => const Text('Возникла ошибка'),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<BuildingBloc, BuildingState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const Center(child: Text('')),
                        loading: () => const Center(
                            child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 0, 59, 108),
                        )),
                        loaded: (data) => ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final building = data[index];

                            return BuildingItem(
                              building: building,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LocationDetailsPage(
                                      building: building,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        error: (msg) => Center(
                          child:
                              Text('Возникла Ошибка, попробуйте позже: $msg'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
