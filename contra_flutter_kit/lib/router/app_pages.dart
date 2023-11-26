import 'package:contra_flutter_kit/pages/onboarding/onboard_main.dart';
import 'package:contra_flutter_kit/pages/onboarding/type1/pager.dart';
import 'package:contra_flutter_kit/pages/onboarding/type2/pager.dart';
import 'package:contra_flutter_kit/pages/onboarding/welcome_screen.dart';
import 'package:get/route_manager.dart';

class Routes {
  static final List<GetPage> getPages = [
    GetPage(name: '/onboard_all', page: () => const OnboardPageMain()),
    GetPage(
        name: '/onboard_type_one', page: () => const OnboardingPagerTypeOne()),
    GetPage(
        name: '/onboard_type_two', page: () => const OnboardingPagerTypeTwo()),
    // GetPage(
    //     name: '/onboard_type_three',
    //     page: () => const OnboardingPagerTypeThree()),
    // GetPage(
    //     name: '/onboard_type_four', page: () => const OnboardPageTypeFour()),
    // GetPage(name: '/empty_state', page: () => const EmptyState()),
    GetPage(name: '/welcome_screen', page: () => const WelcomeScreenPage()),
    // GetPage(name: '/login_all', page: () => const LoginMainPage()),
    // GetPage(name: '/login_type_one', page: () => const LoginFormTypeOne()),
    // GetPage(name: '/login_type_two', page: () => const LoginFormTypeTwo()),
    // GetPage(name: '/login_type_three', page: () => const LoginFormTypeThree()),
    // GetPage(name: '/login_type_four', page: () => const LoginFormTypeFour()),
    // GetPage(
    //     name: '/login__type_verification',
    //     page: () => const VerificationType()),
    // GetPage(name: '/contact_us_form', page: () => const ContactUsForm()),
    // GetPage(name: '/chat_home', page: () => const ChatHomePage()),
    // GetPage(name: '/chat_screen_page', page: () => const ChatListPage()),
    // GetPage(name: '/chat_list_page', page: () => const ChatMessagesPage()),
    // GetPage(name: '/shopping_main_page', page: () => const ShoppingMainPage()),
    // GetPage(
    //     name: '/shopping_list_page_one',
    //     page: () => const ShoppingListPageOne()),
    // GetPage(
    //     name: '/shopping_list_page_two',
    //     page: () => const ShoppingListPageTwo()),
    // GetPage(name: '/shopping_home_page', page: () => const ShoppingHomePage()),
    // GetPage(
    //     name: '/shopping_home_page_one',
    //     page: () => const ShoppingHomePageOne()),
    // GetPage(
    //     name: '/shopping_home_page_two',
    //     page: () => const ShoppingHomePageTwo()),
    // GetPage(
    //     name: '/shopping_detail_page_one',
    //     page: () => const ShoppingDetailPageOne()),
    // GetPage(
    //     name: '/shopping_detail_page_two',
    //     page: () => const ShoppingDetailPageTwo()),
    // GetPage(name: '/blog_main_page', page: () => const BlogMainPage()),
    // GetPage(name: '/blog_home_page', page: () => const BlogHomePage()),
    // GetPage(name: '/blog_list_page_one', page: () => const BlogListPageOne()),
    // GetPage(name: '/blog_list_page_two', page: () => const BlogListPageTwo()),
    // GetPage(
    //     name: '/blog_list_page_three', page: () => const BlogListPageThree()),
    // GetPage(name: '/blog_list_page_four', page: () => const BlogListPageFour()),
    // GetPage(
    //     name: '/blog_staggered_page_four',
    //     page: () => const BlogStaggeredGridPage()),
    // GetPage(name: '/blog_detail_page', page: () => const BlogDetailPage()),
    // GetPage(
    //     name: '/blog_featured_page', page: () => const ShoppingDetailPageTwo()),
    // GetPage(name: '/payment_main_page', page: () => const PaymentMainPage()),
    // GetPage(name: '/payment_page_type_one', page: () => const PaymentPageOne()),
    // GetPage(name: '/payment_page_type_two', page: () => const PaymentPageTwo()),
    // GetPage(
    //     name: '/payment_page_type_three', page: () => const PaymentPageThree()),
    // GetPage(name: '/alarm_main_page', page: () => const AlarmMainPage()),
    // GetPage(name: '/alarm_list_page', page: () => const AlarmListPage()),
    // GetPage(name: '/add_alarm_page', page: () => const AddAlarmPage()),
    // GetPage(name: '/clock_list_page', page: () => const ClockListPage()),
    // GetPage(name: '/weather_list_page', page: () => const WeatherListPage()),
    // GetPage(name: '/weather_page', page: () => const WeatherDetailPage()),
    // GetPage(name: '/chart_main_page', page: () => const ChartMainPage()),
    // GetPage(name: '/bar_chart_page', page: () => const ChartsPage()),
    // GetPage(name: '/line_chart_page', page: () => const ChartsPage()),
    // GetPage(name: '/map_main_page', page: () => const LocationMapMainPage()),
    // GetPage(
    //     name: '/location_list_page', page: () => const LocationListingPage()),
    // GetPage(
    //     name: '/location_detail_page', page: () => const LocationDetailPage()),
    // GetPage(
    //     name: '/content_text_main_page', page: () => const ContentMainPage()),
    // GetPage(name: '/content_blog_home', page: () => const BlogHome()),
    // GetPage(
    //     name: '/detail_screen_one', page: () => const DetailScreenPageOne()),
    // GetPage(name: '/image_and_text', page: () => const ImageTextPager()),
    // GetPage(
    //     name: '/detail_screen_two', page: () => const DetailScreenPageTwo()),
    // GetPage(
    //     name: '/detail_screen_three',
    //     page: () => const DetailScreenPageThree()),
    // GetPage(
    //     name: '/detail_screen_four', page: () => const DetailScreenPageFour()),
    // GetPage(
    //     name: '/detail_screen_grid', page: () => const DetailScreenGridPage()),
    // GetPage(
    //     name: '/home_list_page', page: () => const PopularCoursesHomePage()),
    // GetPage(name: '/user_listing_page', page: () => const UserListPage()),
    // GetPage(name: '/user_invite_page', page: () => const InviteListPage()),
    // GetPage(
    //     name: '/menu_settings_main_page',
    //     page: () => const MenuSettingsMainPage()),
    // GetPage(name: '/menu_type_one', page: () => const MenuPageOne()),
    // GetPage(name: '/menu_type_two', page: () => const MenuPageTwo()),
    // GetPage(name: '/settings_type_one', page: () => const SettingsPageOne()),
    // GetPage(name: '/settings_type_two', page: () => const SettingsPageTwo()),
    // GetPage(
    //     name: '/settings_type_three', page: () => const SettingsPageThree()),
  ];
}
