class ApiConstant {
  static const BASE_URL = "https://admin.atmaprimehealthcare.com/" ;
     /* "https://app.atmaprimehealthcare.com/"; */// Enter your base URL like :: http://182.168.20.243:5000/
  static const SECRET_KEY =
      "JIICGbfFkpwq01wQOfDNGEaKAdqGjJDC"; // Enter your key like :: ssf45sd1fs5d1sdf1s56165s15sdf1s

  /// =================== User =================== ///
  static const registrationUser = "user/loginSignup";
  static const checkUser = "user/checkUser?";
  static const getUserProfile = "user/profile?";
  static const updateUserProfile = "user/update?";
  static const deleteUser = "user/delete?";

  /// =================== Forgot Password =================== ///
  static const forgotPassword = "user/forgetPassword/sendOtp?";
  static const verificationOtp = "user/forgetPassword/verifyOtp?";
  static const setPassword = "user/forgetPassword/otpLogin?";

  /// =================== Services =================== ///
  static const getAllService = "user/service";

  /// =================== Doctor's =================== ///
  static const getSavedDoctor = "user/doctor/saveDoctor?";
  static const getDoctorDetail = "user/doctor/doctorProfile?";
  static const getAllSavedDoctor = "user/doctor/allSavedDoctors?";
  static const getDoctorsServiceWise = "user/doctor/getDoctorsServiceWise";
  static const getFilteredDoctors = "user/doctor/getFilteredDoctors";

  /// =================== Sub Patient =================== ///
  static const addPatient = "user/subPatient/add?";
  static const getPatient = "user/subPatient?";

  /// =================== Appointment(Booking) =================== ///
  static const getBooking = "user/appointment/checkDate?";
  static const createAppointment = "user/appointment/newAppointment";
  static const getAppointment = "user/appointment/getUserAppointment?";
  static const cancelAppointment = "user/appointment/cancelAppointment?";
  static const rescheduleAppointment = "user/appointment/rescheduleAppointment";
  static const getAppointmentInformation = "user/appointment/getAppointment?";
  static const getUpcomingAppointment = "doctor/appointment/upcomingBookings?";

  /// =================== Med Clips(Videos) =================== ///
  static const getAllVideo = "user/video/doctorVideos?";
  static const likeOrDislikeVideo = "user/video/likeOrDislikeOfVideo?";
  static const createComment = "user/video/commentOfVideo?";
  static const getAllComment = "user/video/getvideoComments?";
  static const shareCountVideo = "user/video/shareCountOfVideo?";
  static const createWatchHistory = "user/video/createWatchHistory?";

  /// =================== Chat =================== ///
  static const getChatThumbList = "user/chatTopic/get?";
  static const getOldChat = "user/chat/getOldChat?";
  static const createChatImage = "user/chat/createChatUser?";
  static const chatBoatCreate = "user/chatBoat/createChatBoat";
  static const chatBoatGet = "user/chatBoat/getChatBoat?";

  /// =================== Call Enable =================== ///
  static const getCallEnable = "user/appointment/isCallEnableForUser?";

  /// =================== Notification =================== ///
  static const getNotification = "user/notification/get?";

  /// =================== Wallet =================== ///
  static const getWallet = "user/wallet?";
  static const loadWallet = "user/wallet/loadWallet?";
  static const getWalletHistory = "user/wallet/getWalletHistory?";

  /// =================== Coupon =================== ///
  static const getWalletCoupon = "user/coupon/get?";
  static const getCouponDiscountAmount = "user/coupon/getDiscountAmount?";

  /// =================== Banner =================== ///
  static const getAllBanner = "user/banner/getAll";

  /// =================== Review =================== ///
  static const getDoctorReview = "user/review/doctorReview?";
  static const postReview = "user/review/postReview";

  /// =================== Complain =================== ///
  static const raiseComplain = "user/complain/raiseComplain";
  static const getComplain = "user/complain/get?";

  /// =================== Tax =================== ///
  static const getTax = "user/appointment/getTax?";

  /// =================== Setting =================== ///
  static const getSetting = "user/setting/get";

  /// =================== Membership =================== ///
  static const getMembershipPackage = "user/package/get";
  static const buyMembershipPackage = "user/package/buy_membership";
  static const getMembershipData = "user/package/user-membership";
}
