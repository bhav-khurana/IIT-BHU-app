import 'package:chopper/chopper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iit_app/data/post_api_service.dart';
import 'package:iit_app/data/workshop.dart';
import 'package:iit_app/model/built_post.dart';
import 'package:iit_app/model/database_helpers.dart';
import 'package:built_collection/built_collection.dart';

class AppConstants {
  static FirebaseUser currentUser;
  static PostApiService service;

  static List<Workshop> workshops;

  static populateWorkshops() async {
    workshops = [];

    DatabaseHelper helper = DatabaseHelper.instance;
    var database = await helper.workshopInfoDatabase;

    workshops = await helper.getAllWorkshopsInfo(db: database);
    print(' workshops is empty: ${(workshops.isEmpty == true).toString()}');

    if (workshops.isEmpty == true) {
      // insert all workshop information for the first time

      print('fetching workshops infos from json');

      Response<BuiltList<BuiltPost>> snapshots =
          await service.getUpcomingWorkshops();

      final posts = snapshots.body;

      for (var post in posts) {
        await helper.insertWorkshopInfoIntoDatabase(post: post);
      }

      // print(posts);
      // print('printing fetched workshop infos');
      // for (var workshop in workshops) {
      //   print(workshop.createMap());
      // }

      workshops = await helper.getAllWorkshopsInfo(db: database);
    }
    // helper.closeDatabase(db: database);
    print('workshops after fetching : $workshops');
  }

  static updateAndPopulateWorkshops() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    var database = await helper.workshopInfoDatabase;

    await helper.deleteWorkshopInfo(db: database);

    print('fetching workshops infos from json');

    Response<BuiltList<BuiltPost>> snapshots =
        await service.getUpcomingWorkshops();

    final posts = snapshots.body;

    for (var post in posts) {
      await helper.insertWorkshopInfoIntoDatabase(post: post);
    }

    workshops = await helper.getAllWorkshopsInfo(db: database);
    print('------------------------------------');
    // workshops = [];
    print('workshops after updation: $workshops');
    // helper.closeDatabase(db: database);
  }
}
