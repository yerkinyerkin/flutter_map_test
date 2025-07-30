import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_test/src/features/location/data/models/building_model.dart';
import 'package:map_test/src/features/map/presentation/pages/map_page.dart';

class LocationDetailsPage extends StatelessWidget {
  const LocationDetailsPage({super.key, required this.building});
  final Building building;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Color(0xff262626), size: 18),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Детали Постройки',
            style: GoogleFonts.montserrat(
              fontSize: 17,
              color: const Color(0xff262626),
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Нет Фото',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: const Color(0xff262626)),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Адрес:',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xff7E7E7E),
                        ),
                      ),
                      Text(
                        building.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: const Color(0xff262626),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Номер Дома:',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xff7E7E7E),
                        ),
                      ),
                      Text(
                        building.houseNumber.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: const Color(0xff262626),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Описание:',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xff7E7E7E),
                        ),
                      ),
                      Text(
                        building.description ?? 'Нет Данных',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: const Color(0xff262626),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Количество Этажей:',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xff7E7E7E),
                        ),
                      ),
                      Text(
                        building.amountOfFloors ?? 'Нет Данных',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: const Color(0xff262626),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Год Постройки:',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xff7E7E7E),
                        ),
                      ),
                      Text(
                        building.yearOfFoundation ?? 'Нет Данных',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: const Color(0xff262626),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Почтовый код:',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xff7E7E7E),
                        ),
                      ),
                      Text(
                        building.postCode ?? 'Нет Данных',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: const Color(0xff262626),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'ID дома:',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xff7E7E7E),
                        ),
                      ),
                      Text(
                        building.id.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: const Color(0xff262626),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => YandexMapPage(
                                  building: building,
                                )));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 37, 67),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Посмотреть на Карте',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
