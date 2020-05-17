import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget circleAvatar(double radius, double radiusBorder, String urlImagem,
    {String imagemDefault = 'assets/images/avatar/camera.png',
    String imagemError = 'assets/images/avatar/avatar_error.png'}) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: Colors.white,
    child: CircleAvatar(
      radius: radiusBorder,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusBorder),
        child: CachedNetworkImage(
          imageUrl: urlImagem,
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return CircularProgressIndicator(
              value: downloadProgress.progress,
            );
          },
          errorWidget: (context, url, error) => urlImagem.isEmpty
              ? Container(
                  color: Colors.white,
                  child: Image.asset(imagemDefault),
                )
              : Container(
                  color: Colors.white,
                  child: Image.asset(imagemError),
                ),
        ),
      ),
    ),
  );
}
