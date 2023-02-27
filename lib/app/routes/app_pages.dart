import 'package:flutter/animation.dart';

import 'package:get/get.dart';

import '../modules/booking_screen/bindings/booking_screen_binding.dart';
import '../modules/booking_screen/views/booking_screen_view.dart';
import '../modules/budget/bindings/budget_binding.dart';
import '../modules/budget/views/budget_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/destinations/bindings/destinations_binding.dart';
import '../modules/destinations/views/destinations_view.dart';
import '../modules/duration/bindings/duration_binding.dart';
import '../modules/duration/views/duration_view.dart';
import '../modules/favourites_screen/bindings/favourites_screen_binding.dart';
import '../modules/favourites_screen/views/favourites_screen_view.dart';
import '../modules/filter_screen/bindings/filter_screen_binding.dart';
import '../modules/filter_screen/views/filter_screen_view.dart';
import '../modules/get_started/bindings/get_started_binding.dart';
import '../modules/get_started/views/get_started_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lucky_draw/bindings/lucky_draw_binding.dart';
import '../modules/lucky_draw/views/lucky_draw_view.dart';
import '../modules/main_screen/bindings/main_screen_binding.dart';
import '../modules/main_screen/views/main_screen_view.dart';
import '../modules/nointernet/bindings/nointernet_binding.dart';
import '../modules/nointernet/views/nointernet_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/otp_screen/bindings/otp_screen_binding.dart';
import '../modules/otp_screen/views/otp_screen_view.dart';
import '../modules/passenger_details/bindings/passenger_details_binding.dart';
import '../modules/passenger_details/views/passenger_details_view.dart';
import '../modules/payment_screen/bindings/payment_screen_binding.dart';
import '../modules/payment_screen/views/payment_screen_view.dart';
import '../modules/payment_summary/bindings/payment_summary_binding.dart';
import '../modules/payment_summary/views/payment_summary_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/razorpay/bindings/razorpay_binding.dart';
import '../modules/razorpay/views/razorpay_view.dart';
import '../modules/rewards/bindings/rewards_binding.dart';
import '../modules/rewards/views/rewards_view.dart';
import '../modules/search_details/bindings/search_details_binding.dart';
import '../modules/search_details/views/search_details_view.dart';
import '../modules/search_view/bindings/search_view_binding.dart';
import '../modules/search_view/views/search_view_view.dart';
import '../modules/single_category/bindings/single_category_binding.dart';
import '../modules/single_category/views/single_category_view.dart';
import '../modules/single_tour/bindings/single_tour_binding.dart';
import '../modules/single_tour/views/single_tour_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/terms_and_conditions/bindings/terms_and_conditions_binding.dart';
import '../modules/terms_and_conditions/views/terms_and_conditions_view.dart';
import '../modules/token_screen/bindings/token_screen_binding.dart';
import '../modules/token_screen/views/token_screen_view.dart';
import '../modules/tours_view/bindings/tours_view_binding.dart';
import '../modules/tours_view/views/tours_view_view.dart';

// ignore_for_file: always_specify_types

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const String INITIAL = Routes.SPLASH_SCREEN;

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.zoom,
      curve: Curves.easeInOut,
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.leftToRightWithFade,
      curve: Curves.easeInOut,
      name: _Paths.GET_STARTED,
      page: () => const GetStartedView(),
      binding: GetStartedBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOut,
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      name: _Paths.MAIN_SCREEN,
      page: () => const MainScreenView(),
      binding: MainScreenBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.fade,
      curve: Curves.easeInOut,
      name: _Paths.OTP_SCREEN,
      page: () => const OtpScreenView(),
      binding: OtpScreenBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      name: _Paths.TERMS_AND_CONDITIONS,
      page: () => const TermsAndConditionsView(),
      binding: TermsAndConditionsBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      name: _Paths.LUCKY_DRAW,
      page: () => const LuckyDrawView(),
      binding: LuckyDrawBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.topLevel,
      curve: Curves.easeInOut,
      name: _Paths.PAYMENT_SCREEN,
      page: () => const PaymentScreenView(),
      binding: PaymentScreenBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.downToUp,
      curve: Curves.easeInOut,
      name: _Paths.PAYMENT_SUMMARY,
      page: () => const PaymentSummaryView(),
      binding: PaymentSummaryBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.FAVOURITES_SCREEN,
      page: () => const FavouritesScreenView(),
      binding: FavouritesScreenBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.BOOKING_SCREEN,
      page: () => const BookingScreenView(),
      binding: BookingScreenBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      name: _Paths.FILTER_SCREEN,
      page: () => const FilterScreenView(),
      binding: FilterScreenBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.DESTINATIONS,
      page: () => const DestinationsView(),
      binding: DestinationsBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.BUDGET,
      page: () => const BudgetView(),
      binding: BudgetBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.DURATION,
      page: () => const DurationView(),
      binding: DurationBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.circularReveal,
      curve: Curves.easeInOut,
      name: _Paths.SEARCH_VIEW,
      page: () => const SearchViewView(),
      binding: SearchViewBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.TOKEN_SCREEN,
      page: () => const TokenScreenView(),
      binding: TokenScreenBinding(),
    ),
    GetPage<dynamic>(
      transition: Transition.fade,
      curve: Curves.easeInOut,
      name: _Paths.REWARDS,
      page: () => const RewardsView(),
      binding: RewardsBinding(),
    ),
    GetPage(
      name: _Paths.RAZORPAY,
      page: () => const RazorpayView(),
      binding: RazorpayBinding(),
    ),
    GetPage(
      transition: Transition.leftToRightWithFade,
      curve: Curves.bounceIn,
      name: _Paths.SINGLE_TOUR,
      page: () => const SingleTourView(),
      binding: SingleTourBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOut,
      name: _Paths.PASSENGER_DETAILS,
      page: () => const PassengerDetailsView(),
      binding: PassengerDetailsBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      name: _Paths.SINGLE_CATEGORY,
      page: () => const SingleCategoryView(),
      binding: SingleCategoryBinding(),
    ),
    GetPage(
      transition: Transition.leftToRightWithFade,
      curve: Curves.easeInOut,
      name: _Paths.SEARCH_DETAILS,
      page: () => const SearchDetailsView(),
      binding: SearchDetailsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      transition: Transition.leftToRightWithFade,
      name: _Paths.NOINTERNET,
      page: () => const NointernetView(),
      binding: NointernetBinding(),
    ),
    GetPage(
      name: _Paths.TOURS_VIEW,
      page: () => const ToursViewView(),
      binding: ToursViewBinding(),
    ),
  ];
}
