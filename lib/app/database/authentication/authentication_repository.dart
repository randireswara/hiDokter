import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/data/model/user_model.dart';
import 'package:hi_dokter/app/database/authentication/failed_authentication.dart';
import 'package:hi_dokter/app/database/user_repo/check_user.dart';

import 'package:hi_dokter/app/routes/app_pages.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  final checkUser = Get.put(CheckUser());
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var userModel = UserModel().obs;

  @override
  void onReady() {
    // TODO: implement onReady
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed(Routes.WELCOME_SCREEN);
    } else {
      await getUserData(user.email!);
      await cekRole(user.email);
    }
  }

  Future<void> cekRole(email) async {
    final checkUser =
        await _db.collection("Users").where("email", isEqualTo: email).get();
    final docs = checkUser.docs;
    List<Map<String, dynamic>> data =
        docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    if (data.isEmpty) {
      logOut();
    }
    String role = await data[0]['role'];

    if (role == "pasien") {
      Get.offAllNamed(Routes.HOME);
    } else if (role == "dokter") {
      Get.offAllNamed(Routes.HOME_DOKTER_SCREEN);
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    var user = _auth.currentUser;

    // Reauthenticate user
    AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!, password: oldPassword);

    try {
      await user.reauthenticateWithCredential(credential);

      // Change password
      await user
          .updatePassword(newPassword)
          .then((_) => _db
              .collection("Users")
              .doc(user.email!)
              .update({"password": newPassword}))
          .then((_) => Get.defaultDialog(
              title: "berhasil",
              middleText: "Berhasil mengubah password",
              onConfirm: () {
                Get.back();
                Get.back();
              },
              buttonColor: Colors.amber,
              textConfirm: "okayy",
              confirmTextColor: Colors.black));

      print('Password updated successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        print('Wrong password provided for reauthentication');
      } else {
        print('Error while changing password: ${e.message}');
      }
    }
  }

  Future<void> userUpdate(
      String name, String phoneNo, String spesialis, String biografi) async {
    userModel.update((user) {
      user?.fullName = name;
      user?.phoneNo = phoneNo;
      user?.spesialis = spesialis;
      user?.biografi = biografi;
    });
    userModel.refresh();
    Get.defaultDialog(
        title: "berhasil",
        middleText: "Berhasil mengubah profile",
        onConfirm: () {
          Get.back();
          Get.back();
        },
        buttonColor: Colors.amber,
        textConfirm: "okayy",
        confirmTextColor: Colors.black);
  }

  Future<void> userUpdatePhoto(String photoUrl) async {
    await _db
        .collection("Users")
        .doc(userModel.value.email)
        .update({'photoUrl': photoUrl});

    userModel.update((user) {
      user?.photoUrl = photoUrl;
    });
    userModel.refresh();
    Get.defaultDialog(
        title: "berhasil",
        middleText: "Berhasil mengubah foto profile",
        onConfirm: () {
          Get.back();
          Get.back();
        },
        buttonColor: Colors.amber,
        textConfirm: "okayy",
        confirmTextColor: Colors.black);
  }

  Future<void> getUserData(String email) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where("email", isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // periksa apakah ada dokumen yang ditemukan

        String uid = snapshot.docs.first.id;
        final data =
            snapshot.docs.first.data(); // ambil data dari dokumen pertama
        // ignore: unnecessary_null_comparison
        if (data != null) {
          userModel.value = UserModel.fromJson(data);
          UserModel(id: uid);

          userModel.refresh();
          print(userModel.value.role);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));

    return credentials.user != null ? true : false;
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The Provide phone number is not valid');
        } else {
          Get.snackbar('Error', 'Something Went Wrong');
        }
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await getUserData(email);
      firebaseUser.value != null
          ? Get.offAllNamed(Routes.HOME)
          : Get.offAllNamed(Routes.INTRODUCTION_SCREEN);
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailandPasswordFailure.code(e.code);
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailandPasswordFailure();
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (firebaseUser.value != null) {
        CollectionReference users = _db.collection("Users");

        final checkUser = await users.where("email", isEqualTo: email).get();
        final docs = checkUser.docs;

        List<Map<String, dynamic>> data =
            docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        String role = await data[0]['role'];

        if (role == "pasien") {
          Get.toNamed(Routes.HOME);
        } else if (role == "dokter") {
          Get.toNamed(Routes.HOME_DOKTER_SCREEN);
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "Password atau Email anda salah",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent.withOpacity(0.5),
          colorText: Colors.white);
      print(e.toString());
    } catch (_) {}
  }

  Future<void> loginWithEmailAndPasswordDok(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAllNamed(Routes.HOME_DOKTER_SCREEN)
          : Get.offAllNamed(Routes.INTRODUCTION_SCREEN);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(e.toString());
    } catch (_) {}
  }

  Future<void> logOut() async => await _auth.signOut();
}
