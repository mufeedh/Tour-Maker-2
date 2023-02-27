import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/style.dart';

class SingleTourTile extends StatelessWidget {
  const SingleTourTile({
    super.key,
    required this.onPressed,
    required this.image,
    required this.tourName,
    required this.tourcode,
    required this.packageamount,
    this.isClickedFavourites = false,
    this.isHaveoffer = false,
    this.offerAmount,
    required this.days,
    required this.nights,
    required this.onClickFavourites,
  });
  final Function() onPressed;
  final String image;
  final String tourName;
  final String tourcode;
  final String days;
  final String nights;
  final String packageamount;
  final bool isHaveoffer;
  final bool isClickedFavourites;
  final String? offerAmount;
  final Function() onClickFavourites;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Card(
          elevation: 2,
          // type: MaterialType.transparency,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            width: 100.w,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade50),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: 120,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: englishlinearViolet,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(image),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Wrap(
                    spacing: 8.0,
                    alignment: WrapAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            tourName,
                            style: subheading1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          const SizedBox(height: 5),
                          Text(tourcode, style: paragraph2),
                          const SizedBox(height: 5),
                          Text(
                            '$days Days / $nights Nights',
                            style: subheading3,
                          ),
                          const SizedBox(height: 10),
                          if (isHaveoffer)
                            Row(
                              children: <Widget>[
                                Text(
                                  '₹$packageamount',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                const SizedBox(width: 10),
                                Text('₹$offerAmount', style: subheading1),
                              ],
                            )
                          else
                            Text('₹$packageamount', style: subheading1),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: GestureDetector(
                    onTap: onClickFavourites,
                    child: Column(
                      children: <Widget>[
                        if (isClickedFavourites)
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        else
                          const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.black,
                          ),
                      ],
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
