import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:hi_dokter/app/modules/account_setting_dokter/views/account_setting_dr_view.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_doctor_controller.dart';

class ProfileDoctorView extends GetView<ProfileDoctorController> {
  const ProfileDoctorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final repo = Get.put(AuthenticationRepository());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Doctor',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Header(),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MyAccount",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ToDetail(
                      logo: const Icon(Icons.person_2),
                      title: "Account Setting",
                      onTap: () {
                        Get.to(() => const AccountSettingDrView());
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  ToDetail(
                      logo: const Icon(Icons.notifications),
                      title: "Notification Setting",
                      onTap: () {
                        Get.toNamed(Routes.NOTIFICATION_PERMISSION);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Help Centre",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ToDetail(
                      logo: const Icon(Icons.question_answer),
                      title: "FAQ",
                      onTap: () {
                        Get.toNamed(Routes.FAQ);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Security",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ToDetail(
                      logo: const Icon(Icons.security),
                      title: "Change Password",
                      onTap: () {
                        Get.toNamed(Routes.SECURITY);
                      }),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            repo.logOut();
                          },
                          icon: const Icon(Icons.logout_outlined),
                          label: const Text("Log Out")),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());
    return Row(
      children: [
        Obx(
          () => CachedNetworkImage(
            imageUrl: controller.userModel.value.photoUrl!,
            imageBuilder: (context, imageProvider) => Hero(
              tag: 'imageHero',
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Color.fromARGB(255, 255, 229, 229),
                foregroundColor: Colors.black38,
                backgroundImage:
                    imageProvider, // ganti dengan path gambar lokal Anda
              ),
            ),
            placeholder: (context, url) => const Hero(
              tag: 'imageHero',
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Color.fromARGB(255, 255, 229, 229),
                foregroundColor: Colors.black38,
                backgroundImage: AssetImage(
                    'assets/images/nopicture.jpg'), // ganti dengan path gambar lokal Anda
              ),
            ),
            errorWidget: (context, url, error) => const Hero(
              tag: 'imageHero',
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Color.fromARGB(255, 255, 229, 229),
                foregroundColor: Colors.black38,
                backgroundImage: AssetImage(
                    'assets/images/nopicture.jpg'), // ganti dengan path gambar lokal Anda
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.userModel.value.fullName!,
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    controller.userModel.value.email!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    controller.userModel.value.phoneNo!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              )),
        )
      ],
    );
  }
}

class ToDetail extends StatelessWidget {
  const ToDetail(
      {super.key,
      required this.logo,
      required this.title,
      required this.onTap});

  final String title;
  final Icon logo;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  color: Colors.transparent),
              child: logo,
            ),
            Expanded(
              child: Container(
                height: 70,
                padding: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black38,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 30.0),
                      height: 30,
                      width: 30,
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
