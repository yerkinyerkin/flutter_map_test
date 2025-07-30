import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_test/src/features/location/data/models/building_model.dart';

class BuildingItem extends StatelessWidget {
  const BuildingItem({super.key, required this.building, required this.onTap});

  final VoidCallback onTap;
  final Building building;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              alignment: Alignment.center,
              child: const Text('Нет Фото'),
            ),
            const SizedBox(width: 10),
            Expanded(
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
