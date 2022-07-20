import 'package:flutter/widgets.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/food_details.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/pending_orders_screen.dart';
import 'package:food_delivery/screens/restaurant_details.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:go_router/go_router.dart';

import '../screens/add_food_screen.dart';
import '../screens/completed_orders_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import 'auth.dart';

class RouterHelper {
  static final router = GoRouter(initialLocation: "/login", routes: [
    GoRoute(
        path: '/',
        builder: (context, state) {
          return HomeScreen();
        },
        redirect: (state) {
          if (AuthHelper().user == null) {
            return "/login";
          }

          return null;
        },
        routes: [
          GoRoute(
        path: 'cart',
        builder: (context, state) {
          return CartListScreen();
        },

        ),
         GoRoute(
              path: 'pending_orders',
              builder: (context, state) {
                return PendingOrdersScreen();
              }),
         GoRoute(
              path: 'completed_orders',
              builder: (context, state) {
                return CompletedOrdersScreen();
              }),
          GoRoute(
              path: 'restaurant',
              builder: (context, state) {
                return RestaurantScreen();
              },
              routes: [
                GoRoute(
                    path: 'details',
                    builder: (context, state) {
                      return RestaurantDetails();
                    }),
                GoRoute(
                    path: 'add_food',
                    builder: (context, state) {
                      return AddFoodScreen();
                    }),
              ]),
        ]),
    GoRoute(
        path: '/login',
        builder: (context, state) {
          return LoginScreen();
        },
        redirect: (state) {
          if (AuthHelper().user != null) {
            return "/";
          }

          return null;
        },
        routes: [
          GoRoute(
              path: 'register',
              builder: (context, state) {
                return RegisterScreen();
              })
        ]),




  ]);
}
