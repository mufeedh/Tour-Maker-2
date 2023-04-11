import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/style.dart';

class PackageTile extends StatelessWidget {
  const PackageTile({
    super.key,
    required this.onPressed,
    required this.isFavourite,
    required this.onClickedFavourites,
    required this.tourName,
    required this.tourCode,
    required this.tourDays,
    required this.tournights,
    required this.tourAmount,
    required this.tourImage,
  });
  final String tourName;
  final String tourCode;
  final String tourDays;
  final String tournights;
  final String tourAmount;
  final String tourImage;
  final Function() onPressed;
  final bool isFavourite;
  final Function() onClickedFavourites;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.all(12),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                CachedNetworkImage(
                  useOldImageOnUrlChange: true,
                  errorWidget:
                      (BuildContext context, String url, dynamic error) {
                    log('cache nertwrk $error');
                    return const Icon(Icons.error);
                  },
                  placeholder: (BuildContext context, String url) {
                    return CircularProgressIndicator(
                        color: englishlinearViolet);
                  },
                  imageUrl: tourImage,
                  imageBuilder: (BuildContext context,
                          ImageProvider<Object> imageProvider) =>
                      Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 145,
                    height: 162,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: englishlinearViolet,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: imageProvider,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Text(
                    tourName.split(' ').join('\n'),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: fontColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(tourCode, style: paragraph1),
                  const SizedBox(height: 12),
                  Text(
                    '$tourDays Days / $tournights Nights',
                    style: subheading3,
                  ),
                  const SizedBox(height: 13),
                  Text('₹ $tourAmount', style: heading3),
                ],
              ),
            ),
            Container(
              height: 180,
              margin: const EdgeInsets.only(right: 16, top: 15),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: onClickedFavourites,
                    child: isFavourite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20.sp,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: englishlinearViolet,
                            size: 20.sp,
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
