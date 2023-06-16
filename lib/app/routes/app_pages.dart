import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/account_setting_dokter/views/account_setting_dr_view.dart';

import '../modules/FAQ/bindings/faq_binding.dart';
import '../modules/FAQ/views/faq_view.dart';
import '../modules/Home_dokter_screen/bindings/home_dokter_screen_binding.dart';
import '../modules/Home_dokter_screen/views/home_dokter_screen_view.dart';
import '../modules/OTP/bindings/forget_password_binding.dart';
import '../modules/OTP/views/forget_password_view.dart';
import '../modules/account_setting_dokter/bindings/account_setting_dr_binding.dart';

import '../modules/account_settings/bindings/account_settings_binding.dart';
import '../modules/account_settings/views/account_settings_view.dart';
import '../modules/add_reminder/bindings/add_reminder_binding.dart';
import '../modules/add_reminder/views/add_reminder.dart';
import '../modules/appointment_setting/bindings/appointment_setting_binding.dart';
import '../modules/appointment_setting/views/appointment_setting_view.dart';
import '../modules/book_appointment/bindings/book_appointment_binding.dart';
import '../modules/book_appointment/views/book_appointment_view.dart';
import '../modules/change_password/bindings/security_binding.dart';
import '../modules/change_password/views/security_view.dart';
import '../modules/chat_dokter/bindings/chat_dokter_binding.dart';
import '../modules/chat_dokter/views/chat_dokter_view.dart';
import '../modules/list_chat_for_pasien/bindings/chat_pasien_binding.dart';
import '../modules/list_chat_for_pasien/views/chat_pasien_view.dart';
import '../modules/chat_setting_dr/bindings/chat_setting_dr_binding.dart';
import '../modules/chat_setting_dr/views/chat_setting_dr_view.dart';
import '../modules/covid_19/bindings/covid_19_binding.dart';
import '../modules/covid_19/views/covid_19_view.dart';
import '../modules/detailNews/bindings/detail_news_binding.dart';
import '../modules/detailNews/views/detail_news_view.dart';
import '../modules/detail_dokter/bindings/detail_dokter_binding.dart';
import '../modules/detail_dokter/views/detail_dokter_view.dart';
import '../modules/history_order/bindings/history_order_binding.dart';
import '../modules/history_order/views/history_order_view.dart';
import '../modules/history_patient/bindings/history_patient_binding.dart';
import '../modules/history_patient/views/history_patient_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction_screen/bindings/introduction_screen_binding.dart';
import '../modules/introduction_screen/views/introduction_screen_view.dart';
import '../modules/kritik_dan_saran/bindings/kritik_dan_saran_binding.dart';
import '../modules/kritik_dan_saran/views/kritik_dan_saran_view.dart';
import '../modules/login_screen/bindings/login_screen_binding.dart';
import '../modules/login_screen/views/login_screen_view.dart';
import '../modules/medicine_reminder/bindings/medicine_reminder_binding.dart';
import '../modules/medicine_reminder/views/medicine_reminder_view.dart';
import '../modules/myProfile/bindings/my_profile_binding.dart';
import '../modules/myProfile/views/my_profile_view.dart';

import '../modules/notification_page/bindings/notification_page_binding.dart';
import '../modules/notification_page/views/notification_page_view.dart';
import '../modules/notification_permission/bindings/notification_permission_binding.dart';
import '../modules/notification_permission/views/notification_permission_view.dart';
import '../modules/pilih_konsultasi/bindings/pilih_konsultasi_binding.dart';
import '../modules/pilih_konsultasi/views/pilih_konsultasi_view.dart';
import '../modules/pilihan_dokter/bindings/pilihan_dokter_binding.dart';
import '../modules/pilihan_dokter/views/pilihan_dokter_view.dart';
import '../modules/profile_doctor/bindings/profile_doctor_binding.dart';
import '../modules/profile_doctor/views/profile_doctor_view.dart';
import '../modules/room_chat/bindings/room_chat_binding.dart';
import '../modules/room_chat/views/room_chat_view.dart';
import '../modules/signIn_screen/bindings/sign_in_screen_binding.dart';
import '../modules/signIn_screen/views/sign_in_screen_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/welcome_screen/bindings/welcome_screen_binding.dart';
import '../modules/welcome_screen/views/welcome_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION_SCREEN,
      page: () => const IntroductionScreenView(),
      binding: IntroductionScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => const LoginScreenView(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN_SCREEN,
      page: () => const SignInScreenView(),
      binding: SignInScreenBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME_SCREEN,
      page: () => const WelcomeScreenView(),
      binding: WelcomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const OTPScreen(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOME_DOKTER_SCREEN,
      page: () => HomeDokterScreenView(),
      binding: HomeDokterScreenBinding(),
    ),
    GetPage(
      name: _Paths.MY_PROFILE,
      page: () => const MyProfileView(),
      binding: MyProfileBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_SETTINGS,
      page: () => const AccountSettingsView(),
      binding: AccountSettingsBinding(),
    ),
    GetPage(
      name: _Paths.MEDICINE_REMINDER,
      page: () => const MedicineReminderView(),
      binding: MedicineReminderBinding(),
    ),
    GetPage(
      name: _Paths.ADD_REMINDER,
      page: () => const AddReminder(),
      binding: AddReminderBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_NEWS,
      page: () => DetailNewsView(),
      binding: DetailNewsBinding(),
    ),
    GetPage(
      name: _Paths.SECURITY,
      page: () => const SecurityView(),
      binding: SecurityBinding(),
    ),
    GetPage(
      name: _Paths.PILIH_KONSULTASI,
      page: () => const PilihKonsultasiView(),
      binding: PilihKonsultasiBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_PAGE,
      page: () => const NotificationPageView(),
      binding: NotificationPageBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_ORDER,
      page: () => const HistoryOrderView(),
      binding: HistoryOrderBinding(),
    ),
    GetPage(
      name: _Paths.COVID_19,
      page: () => const Covid19View(),
      binding: Covid19Binding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_PERMISSION,
      page: () => const NotificationPermissionView(),
      binding: NotificationPermissionBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => const FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: _Paths.PILIHAN_DOKTER,
      page: () => const PilihanDokterView(),
      binding: PilihanDokterBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_DOKTER,
      page: () => const DetailDokterView(),
      binding: DetailDokterBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_APPOINTMENT,
      page: () => const BookAppointmentView(),
      binding: BookAppointmentBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_DOKTER,
      page: () => const ChatDokterView(),
      binding: ChatDokterBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_CHAT,
      page: () => const RoomChatView(),
      binding: RoomChatBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_PATIENT,
      page: () => const HistoryPatientView(),
      binding: HistoryPatientBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_PASIEN,
      page: () => ChatPasienView(),
      binding: ChatPasienBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SETTING_DR,
      page: () => const ChatSettingDrView(),
      binding: ChatSettingDrBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT_SETTING,
      page: () => const AppointmentSettingView(),
      binding: AppointmentSettingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_DOCTOR,
      page: () => const ProfileDoctorView(),
      binding: ProfileDoctorBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_SETTING_DR,
      page: () => const AccountSettingDrView(),
      binding: AccountSettingDrBinding(),
    ),
  ];
}
