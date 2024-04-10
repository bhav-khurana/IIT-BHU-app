import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iit_app/model/appConstants.dart';
import 'package:iit_app/model/built_post.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

getImageFileIO(String logoImageUrl) {
  final File logoFile =
      logoImageUrl != null ? AppConstants.getImageFile(logoImageUrl) : null;

  return logoFile == null
      ? (logoImageUrl == null || logoImageUrl == ''
          ? Image.asset('assets/iitbhu.jpeg', fit: BoxFit.cover, height: 300.0)
          : Image.network(logoImageUrl, fit: BoxFit.cover, height: 300.0))
      : Image.file(logoFile, fit: BoxFit.cover, height: 300);
}

getProviderImageFileIO(String logoImageUrl) {
  final File logoFile =
      logoImageUrl != null ? AppConstants.getImageFile(logoImageUrl) : null;
  return logoFile == null
      ? (logoImageUrl == null || logoImageUrl == ''
          ? AssetImage('assets/iitbhu.jpeg')
          : NetworkImage(logoImageUrl))
      : FileImage(logoFile);
}

Future<void> shareWithImageIO(Uri uri, String imageUrl, String logoImageUrl,
    BuiltWorkshopDetailPost workshopDetail) async {
  try {
    var request = (imageUrl != null && imageUrl != '')
        ? await HttpClient().getUrl(Uri.parse(imageUrl))
        : await HttpClient().getUrl(Uri.parse(logoImageUrl));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);

    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/pic_to_share.png').create();
    await file.writeAsBytes(bytes);

    await Share.shareFiles(['${tempDir.path}/pic_to_share.png'],
        subject: '${workshopDetail.title}',
        text:
            'Checkout this amazing workshop ${workshopDetail.title} to be held on ${workshopDetail.date} at ${workshopDetail.time}. To know more, follow this link: ${uri.toString()}');
  } catch (err) {
    shareWithoutImage(uri, workshopDetail);
  }
}

Future<void> shareWithoutImage(
    Uri uri, BuiltWorkshopDetailPost workshopDetail) async {
  Share.share(
    'Checkout this amazing workshop ${workshopDetail.title} to be held on ${workshopDetail.date} at ${workshopDetail.time}. To know more, follow this link: ${uri.toString()}',
    subject: '${workshopDetail.title}',
  );
}
