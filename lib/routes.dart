import 'package:flutter/widgets.dart';
import 'package:shopapp/screens/add_product/add_product_screen.dart';
import 'package:shopapp/screens/cart/cart_screen.dart';
import 'package:shopapp/screens/catlist/catlist_screen.dart';
import 'package:shopapp/screens/complete_profile/complete_profile_screen.dart';
import 'package:shopapp/screens/contactus/contact_screen.dart';
import 'package:shopapp/screens/details/details_screen.dart';
import 'package:shopapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:shopapp/screens/home/home_screen.dart';
import 'package:shopapp/screens/login_success/login_success_screen.dart';
import 'package:shopapp/screens/order_success/order_success_screen.dart';

import 'package:shopapp/screens/orders_tab/order_tab_screen.dart';
import 'package:shopapp/screens/otp/otp_screen.dart';
import 'package:shopapp/screens/prod_success/prod_success_screen.dart';
import 'package:shopapp/screens/profile/profile_screen.dart';
import 'package:shopapp/screens/profile_detail/profile_detail.dart';
import 'package:shopapp/screens/settings/settings.dart';
import 'package:shopapp/screens/sign_in/sign_in_screen.dart';
import 'package:shopapp/screens/splash/splash_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  ProdSuccessScreen.routeName: (context) => const ProdSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  AddProductScreen.routeName: (context) => const AddProductScreen(),
  CatlistScreen.routeName: (context) => const CatlistScreen(),
  ProfileDetailScreen.routeName: (context) => const ProfileDetailScreen(),
  OrderSuccessScreen.routeName: (context) => const OrderSuccessScreen(),
  OrdertabScreen.routeName: (context) => const OrdertabScreen(),
  ContactScreen.routeName: (context) =>
      const ContactScreen(title: "Contact us"),
  SettingsScreen.routeName: (context) => const SettingsScreen(title: "Settings")
};
