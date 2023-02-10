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
import '../modules/otp_screen/bindings/otp_screen_binding.dart';
import '../modules/otp_screen/views/otp_screen_view.dart';
import '../modules/payment_screen/bindings/payment_screen_binding.dart';
import '../modules/payment_screen/views/payment_screen_view.dart';
import '../modules/payment_summary/bindings/payment_summary_binding.dart';
import '../modules/payment_summary/views/payment_summary_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search_view/bindings/search_view_binding.dart';
import '../modules/search_view/views/search_view_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/terms_and_conditions/bindings/terms_and_conditions_binding.dart';
import '../modules/terms_and_conditions/views/terms_and_conditions_view.dart';
import '../modules/trip_details/bindings/trip_details_binding.dart';
import '../modules/trip_details/views/trip_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.GET_STARTED;

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
      name: _Paths.GET_STARTED,
      page: () => const GetStartedView(),
      binding: GetStartedBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_SCREEN,
      page: () => const MainScreenView(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: _Paths.OTP_SCREEN,
      page: () => const OtpScreenView(),
      binding: OtpScreenBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_CONDITIONS,
      page: () => const TermsAndConditionsView(),
      binding: TermsAndConditionsBinding(),
    ),
    GetPage(
      name: _Paths.LUCKY_DRAW,
      page: () => const LuckyDrawView(),
      binding: LuckyDrawBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_SCREEN,
      page: () => const PaymentScreenView(),
      binding: PaymentScreenBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_SUMMARY,
      page: () => const PaymentSummaryView(),
      binding: PaymentSummaryBinding(),
    ),
    GetPage(
      name: _Paths.FAVOURITES_SCREEN,
      page: () => const FavouritesScreenView(),
      binding: FavouritesScreenBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_SCREEN,
      page: () => const BookingScreenView(),
      binding: BookingScreenBinding(),
    ),
    GetPage(
      name: _Paths.TRIP_DETAILS,
      page: () => const TripDetailsView(),
      binding: TripDetailsBinding(),
    ),
    GetPage(
      name: _Paths.FILTER_SCREEN,
      page: () => const FilterScreenView(),
      binding: FilterScreenBinding(),
    ),
    GetPage(
      name: _Paths.DESTINATIONS,
      page: () => const DestinationsView(),
      binding: DestinationsBinding(),
    ),
    GetPage(
      name: _Paths.BUDGET,
      page: () => const BudgetView(),
      binding: BudgetBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.DURATION,
      page: () => const DurationView(),
      binding: DurationBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_VIEW,
      page: () => const SearchViewView(),
      binding: SearchViewBinding(),
    ),
  ];
}
