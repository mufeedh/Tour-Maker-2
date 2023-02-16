import 'package:flutter/material.dart';

import '../../core/theme/style.dart';

class SingleTourTile extends StatelessWidget {
  const SingleTourTile({
    super.key,
    required this.onPressed,
  });
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: fontColor,
            )),
        margin: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  // imageUrl: bhai.photo_url,
                  // imageBuilder: (context, imageProvider) => Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                // placeholder: (context, url) => CircularProgressIndicator(),
                // errorWidget: (context, url, error) => Icon(Icons.error),

                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.amber,
                )
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('hwllo', style: heading2),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'ajasik',
                    style: heading2.copyWith(color: fontColor),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'ajasik',
                    style: heading2.copyWith(color: fontColor),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'ajasik',
                    style: heading2.copyWith(color: fontColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
