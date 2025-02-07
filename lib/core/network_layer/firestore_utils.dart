import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:untitled3/core/services/snackbar_service.dart';
import 'package:untitled3/core/utils/my_date_time.dart';
import 'package:untitled3/models/task_model.dart';
import 'package:untitled3/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
class FirestoreUtils {
  static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) =>
          TaskModel.fromFireStore(snapshot.data()!),
      toFirestore: (taskModel, _) => taskModel.toFireStore(),
    );
  }

  static Future<void> addTask(TaskModel taskModel) async {
    var collection = getCollection();
    var doc = collection.doc();
    taskModel.id = doc.id;
    return doc.set(taskModel);
  }

  static Future<List<TaskModel>> getDataFromFirestore() async {
    var snapshots = await getCollection().get();
    // List <QuerySnapshot<TaskModel>>  ---> List<TaskModel>
    List<TaskModel> tasksList =
    snapshots.docs.map((element) => element.data()).toList();
    return tasksList;
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDataFromFirestore(
      DateTime dateTime) {
    return getCollection()
        .where("dateTime",
        isEqualTo:
        MyDateTime.externalDateOnly(dateTime).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteData(TaskModel model) {
    var collectionRef = getCollection().doc(model.id);
    return collectionRef.delete();
  }

  static Future<void> isDoneTask(TaskModel model) async {
    getCollection().doc(model.id).update({'isDone': !model.isDone!});
  }

  static Future<void> updateTask(TaskModel model) async {
    getCollection().doc(model.id).update(model.toFireStore());
  }

// Future<void> updateTask(TaskModel taskModel) async {
//   await getCollection().doc(taskModel.id).update(taskModel.toFireStore());
// }
//

//
// Future<List<TaskModel>> getTasks() async {}
}
*/
class FirebaseUtils {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static String uid = auth.currentUser?.uid ?? "";

  static CollectionReference<TaskModel> getCollectionReference() {
    return FirebaseFirestore.instance
        .collection('TasksCollection') // Main collection
        .doc(uid) // User-specific document within the main collection
        .collection(
            'tasks') // Subcollection for tasks within the user's document
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toJson(),
        );
  }

  static CollectionReference<UserModel> getUsersCollectionRef() {
    return FirebaseFirestore.instance.collection("Users").withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<void> addTaskToFirestore(TaskModel taskModel) async {
    var collectionReference = getCollectionReference();
    var docRef = collectionReference.doc();
    taskModel.id = docRef.id;
    taskModel.uid = uid;
    return docRef.set(taskModel);
  }

  static Future<List<TaskModel>> readOnetimeFromFirestore(
      DateTime selectedDate) async {
    var collectionRef = getCollectionReference()
        .where(
          "selectedDate",
          isEqualTo: externalDateOnly(selectedDate).millisecondsSinceEpoch,
        )
        .where("uid", isEqualTo: uid);
    var data = await collectionRef.get();
    var tasksList = data.docs.map((e) => e.data()).toList();
    return tasksList;
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeData(
      DateTime selectedDate) {
    var collectionRef = getCollectionReference().where(
      "selectedDate",
      isEqualTo: externalDateOnly(selectedDate).millisecondsSinceEpoch,
    );
    return collectionRef.snapshots();
  }

  static Future<void> updateTask(TaskModel taskModel) async {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.update(taskModel.toJson());
  }

  static Future<void> deleteTask(TaskModel taskModel) async {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.delete();
  }

  static Future<void> isDoneTask(TaskModel model) async {
    getCollectionReference().doc(model.id).update({'isDone': !model.isDone});
  }

  static Future<bool> createAccount(
    String name,
    String emailAddress,
    String password,
    BuildContext context,
  ) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      addUser(
        UserModel(
          name: name,
          email: emailAddress,
          password: password,
        ),
      );

      FirebaseFirestore.instance
          .collection('TasksCollection') // Main collection
          .doc(uid) // User-specific document within the main collection
          .withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJson(snapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );

      credential.user!.sendEmailVerification();
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarService.showErrorMessage(
            AppLocalizations.of(context)!.thePasswordProvidedIsTooWeak);
        EasyLoading.dismiss();
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        SnackBarService.showErrorMessage(
            AppLocalizations.of(context)!.theAccountAlreadyExistsForThatEmail);
        EasyLoading.dismiss();
        return Future.value(false);
      }
    } catch (e) {
      SnackBarService.showErrorMessage(
          AppLocalizations.of(context)!.noNetworkPleaseCheckInternetConnection);
      EasyLoading.dismiss();
      return Future.value(false);
    }
    SnackBarService.showErrorMessage(
        AppLocalizations.of(context)!.somethingWentWrong);
    EasyLoading.dismiss();
    return Future.value(false);
  }

  static Future<bool> singIn(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      uid = credential.user!.uid;
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarService.showErrorMessage(
            AppLocalizations.of(context)!.noUserFoundForThatEmail);
        EasyLoading.dismiss();
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        SnackBarService.showErrorMessage(
            AppLocalizations.of(context)!.wrongPasswordProvidedForThatUser);
        EasyLoading.dismiss();
        return Future.value(false);
      } else if (e.code == 'invalid-credential') {
        SnackBarService.showErrorMessage(
            AppLocalizations.of(context)!.invalidEmailOrPassword);
        return Future.value(false);
      }
    } catch (e) {
      SnackBarService.showErrorMessage(
          AppLocalizations.of(context)!.somethingWentWrong);
    }
    EasyLoading.dismiss();
    return Future.value(false);
  }

  static signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> addUser(UserModel user) async {
    var collectionRef = getUsersCollectionRef();
    var docRef = collectionRef.doc();
    user.id = docRef.id;
    return docRef.set(user);
  }
}
