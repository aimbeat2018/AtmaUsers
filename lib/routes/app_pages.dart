import 'package:doctor/routes/app_routes.dart';
import 'package:doctor/ui/add_number_screen/binding/add_number_binding.dart';
import 'package:doctor/ui/add_number_screen/view/add_number_screen.dart';
import 'package:doctor/ui/add_patient_screen/binding/add_patient_binding.dart';
import 'package:doctor/ui/add_patient_screen/view/add_patient_screen.dart';
import 'package:doctor/ui/apply_coupon_screen/binding/apply_coupon_binding.dart';
import 'package:doctor/ui/apply_coupon_screen/view/apply_coupon_screen.dart';
import 'package:doctor/ui/appointment_screen/binding/appointment_screen_binding.dart';
import 'package:doctor/ui/appointment_screen/view/appointment_screen.dart';
import 'package:doctor/ui/booking_information_screen/binding/booking_information_binding.dart';
import 'package:doctor/ui/booking_information_screen/view/booking_information_screen.dart';
import 'package:doctor/ui/booking_screen/binding/booking_screen_binding.dart';
import 'package:doctor/ui/booking_screen/view/booking_screen.dart';
import 'package:doctor/ui/bottom_bar/binding/bottom_bar_binding.dart';
import 'package:doctor/ui/bottom_bar/view/bottom_bar_screen.dart';
import 'package:doctor/ui/call_connect_screen/binding/call_connect_binding.dart';
import 'package:doctor/ui/call_connect_screen/view/call_connect_screen.dart';
import 'package:doctor/ui/call_receive_screen/binding/call_receive_binding.dart';
import 'package:doctor/ui/call_receive_screen/view/call_receive_screen.dart';
import 'package:doctor/ui/category_detail_screen/binding/category_detail_binding.dart';
import 'package:doctor/ui/category_detail_screen/view/category_detail_screen.dart';
import 'package:doctor/ui/category_screen/binding/category_screen_binding.dart';
import 'package:doctor/ui/category_screen/view/category_screen.dart';
import 'package:doctor/ui/chat_boat_screen/binding/chat_boat_binding.dart';
import 'package:doctor/ui/chat_boat_screen/view/chat_boat_screen.dart';
import 'package:doctor/ui/chat_screen/binding/chat_screen_binding.dart';
import 'package:doctor/ui/chat_screen/view/chat_screen.dart';
import 'package:doctor/ui/complain_screen/binding/complain_screen_binding.dart';
import 'package:doctor/ui/complain_screen/view/complain_screen.dart';
import 'package:doctor/ui/confirm_appointment_screen/binding/confirm_appointment_binding.dart';
import 'package:doctor/ui/confirm_appointment_screen/view/confirm_appointment_screen.dart';
import 'package:doctor/ui/confirm_booking_screen/binding/confirm_booking_binding.dart';
import 'package:doctor/ui/confirm_booking_screen/view/confirm_booking_screen.dart';
import 'package:doctor/ui/edit_profile_screen/binding/edit_profile_binding.dart';
import 'package:doctor/ui/edit_profile_screen/view/edit_profile_screen.dart';
import 'package:doctor/ui/forgot_password_screen/binding/forgot_password_binding.dart';
import 'package:doctor/ui/forgot_password_screen/view/forgot_password_screen.dart';
import 'package:doctor/ui/help_desk_history_screen/binding/help_desk_history_binding.dart';
import 'package:doctor/ui/help_desk_history_screen/view/help_desk_history_screen.dart';
import 'package:doctor/ui/help_task_screen/binding/help_desk_screen_binding.dart';
import 'package:doctor/ui/help_task_screen/view/help_desk_screen.dart';
import 'package:doctor/ui/history_screen/binding/history_screen_binding.dart';
import 'package:doctor/ui/history_screen/view/history_screen.dart';
import 'package:doctor/ui/home_screen/binding/home_screen_binding.dart';
import 'package:doctor/ui/home_screen/view/home_screen.dart';
import 'package:doctor/ui/language_screen/binding/language_screen_binding.dart';
import 'package:doctor/ui/language_screen/view/language_screen.dart';
import 'package:doctor/ui/login_screen/binding/login_screen_binding.dart';
import 'package:doctor/ui/login_screen/view/login_screen.dart';
import 'package:doctor/ui/main_screen/binding/main_screen_binding.dart';
import 'package:doctor/ui/main_screen/view/main_screen.dart';
import 'package:doctor/ui/med_clips_screen/binding/med_clips_binding.dart';
import 'package:doctor/ui/med_clips_screen/view/med_clips_screen.dart';
import 'package:doctor/ui/my_appointment_screen/binding/my_appointment_binding.dart';
import 'package:doctor/ui/my_appointment_screen/view/my_appointment_screen.dart';
import 'package:doctor/ui/my_wallet_screen/binding/my_wallet_binding.dart';
import 'package:doctor/ui/my_wallet_screen/view/my_wallet_screen.dart';
import 'package:doctor/ui/notification_screen/binding/notification_binding.dart';
import 'package:doctor/ui/notification_screen/view/notification_screen.dart';
import 'package:doctor/ui/number_otp_screen/binding/number_otp_binding.dart';
import 'package:doctor/ui/number_otp_screen/view/number_otp_screen.dart';
import 'package:doctor/ui/payment_screen/binding/payment_screen_binding.dart';
import 'package:doctor/ui/payment_screen/view/payment_screen.dart';
import 'package:doctor/ui/personal_chat_screen/binding/personal_chat_binding.dart';
import 'package:doctor/ui/personal_chat_screen/view/personal_chat_screen.dart';
import 'package:doctor/ui/profile_screen/binding/profile_screen_binding.dart';
import 'package:doctor/ui/profile_screen/view/profile_screen.dart';
import 'package:doctor/ui/rating_screen/binding/rating_screen_binding.dart';
import 'package:doctor/ui/rating_screen/view/rating_screen.dart';
import 'package:doctor/ui/re-schedule_screen/binding/schedule_binding.dart';
import 'package:doctor/ui/re-schedule_screen/view/schedule_screen.dart';
import 'package:doctor/ui/registration_screen/binding/registration_binding.dart';
import 'package:doctor/ui/registration_screen/view/registration_screen.dart';
import 'package:doctor/ui/saved_doctor_screen/binding/saved_doctor_binding.dart';
import 'package:doctor/ui/saved_doctor_screen/view/saved_doctor_screen.dart';
import 'package:doctor/ui/search_screen/binding/search_screen_binding.dart';
import 'package:doctor/ui/search_screen/view/search_screen.dart';
import 'package:doctor/ui/set_password_screen/binding/set_password_binding.dart';
import 'package:doctor/ui/set_password_screen/view/set_password_screen.dart';
import 'package:doctor/ui/specialist_detail_screen/binding/specialist_detail_binding.dart';
import 'package:doctor/ui/specialist_detail_screen/view/specialist_detail_screen.dart';
import 'package:doctor/ui/splash_screen/binding/splash_screen_binding.dart';
import 'package:doctor/ui/splash_screen/view/splash_screen.dart';
import 'package:doctor/ui/top_specialist_screen/binding/top_specialist_binding.dart';
import 'package:doctor/ui/top_specialist_screen/view/top_specialist_screen.dart';
import 'package:doctor/ui/upcoming_appointment_screen/binding/upcoming_appointment_binding.dart';
import 'package:doctor/ui/upcoming_appointment_screen/view/upcoming_appointment_screen.dart';
import 'package:doctor/ui/verification_otp_screen/binding/verification_otp_binding.dart';
import 'package:doctor/ui/verification_otp_screen/view/verification_otp_screen.dart';
import 'package:doctor/ui/video_call_screen/binding/video_call_binding.dart';
import 'package:doctor/ui/video_call_screen/view/video_call_screen.dart';
import 'package:doctor/ui/video_player_screen/binding/video_player_binding.dart';
import 'package:doctor/ui/video_player_screen/view/video_player_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static List<GetPage> list = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.registration,
      page: () => const RegistrationScreen(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.addNumber,
      page: () => const AddNumberScreen(),
      binding: AddNumberBinding(),
    ),
    GetPage(
      name: AppRoutes.numberOtpVerification,
      page: () => const NumberOtpScreen(),
      binding: NumberOtpBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.verificationOtp,
      page: () => const VerificationOtpScreen(),
      binding: VerificationOtpBinding(),
    ),
    GetPage(
      name: AppRoutes.setPassword,
      page: () => const SetPasswordScreen(),
      binding: SetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.bottom,
      page: () => const BottomBarScreen(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.appointment,
      page: () => const AppointmentScreen(),
      binding: AppointmentScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.medClips,
      page: () => const MedClipsScreen(),
      binding: MedClipsBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      binding: ChatScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.upcomingAppointment,
      page: () => const UpcomingAppointmentScreen(),
      binding: UpcomingAppointmentBinding(),
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
      binding: SearchScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.category,
      page: () => const CategoryScreen(),
      binding: CategoryScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.categoryDetail,
      page: () => const CategoryDetailScreen(),
      binding: CategoryDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.topSpecialist,
      page: () => const TopSpecialistScreen(),
      binding: TopSpecialistBinding(),
    ),
    GetPage(
      name: AppRoutes.specialistDetail,
      page: () => const SpecialistDetailScreen(),
      binding: SpecialistDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.rating,
      page: () => const RatingScreen(),
      binding: RatingScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.booking,
      page: () => const BookingScreen(),
      binding: BookingScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.addPatient,
      page: () => const AddPatientScreen(),
      binding: AddPatientBinding(),
    ),
    GetPage(
      name: AppRoutes.confirmBooking,
      page: () => const ConfirmBookingScreen(),
      binding: ConfirmBookingBinding(),
    ),
    GetPage(
      name: AppRoutes.confirmAppointment,
      page: () => const ConfirmAppointmentScreen(),
      binding: ConfirmAppointmentBinding(),
    ),
    GetPage(
      name: AppRoutes.applyCoupon,
      page: () => const ApplyCouponScreen(),
      binding: ApplyCouponBinding(),
    ),
    GetPage(
      name: AppRoutes.schedule,
      page: () => const ScheduleScreen(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: AppRoutes.bookingInformation,
      page: () => const BookingInformationScreen(),
      binding: BookingInformationBinding(),
    ),
    GetPage(
      name: AppRoutes.chatBoat,
      page: () => const ChatBoatScreen(),
      binding: ChatBoatBinding(),
    ),
    GetPage(
      name: AppRoutes.personalChat,
      page: () => const PersonalChatScreen(),
      binding: PersonalChatBinding(),
    ),
    GetPage(
      name: AppRoutes.videoPlayer,
      page: () => const VideoPlayerScreen(),
      binding: VideoPlayerBinding(),
    ),
    GetPage(
      name: AppRoutes.callConnect,
      page: () => const CallConnectScreen(),
      binding: CallConnectBinding(),
    ),
    GetPage(
      name: AppRoutes.videoCall,
      page: () => const VideoCallScreen(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: AppRoutes.callReceive,
      page: () => const CallReceiveScreen(),
      binding: CallReceiveBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.savedDoctor,
      page: () => const SavedDoctorScreen(),
      binding: SavedDoctorBinding(),
    ),
    GetPage(
      name: AppRoutes.myAppointment,
      page: () => const MyAppointmentScreen(),
      binding: MyAppointmentBinding(),
    ),
    GetPage(
      name: AppRoutes.helpDesk,
      page: () => const HelpDeskScreen(),
      binding: HelpDeskScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.helpDeskHistory,
      page: () => const HelpDeskHistoryScreen(),
      binding: HelpDeskHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.complain,
      page: () => const ComplainScreen(),
      binding: ComplainScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.language,
      page: () => const LanguageScreen(),
      binding: LanguageScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.myWallet,
      page: () => const MyWalletScreen(),
      binding: MyWalletBinding(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryScreen(),
      binding: HistoryScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentScreen(),
      binding: PaymentScreenBinding(),
    ),
  ];
}
