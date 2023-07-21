// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingView(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashView(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginView(key: args.key),
      );
    },
    CatalogRoute.name: (routeData) {
      final args = routeData.argsAs<CatalogRouteArgs>(
          orElse: () => const CatalogRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CatalogView(key: args.key),
      );
    },
    TipDetailRoute.name: (routeData) {
      final args = routeData.argsAs<TipDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TipDetailView(
          key: args.key,
          tipDetails: args.tipDetails,
        ),
      );
    },
    CreateCardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateCardView(),
      );
    },
    ImageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ImageView(),
      );
    },
    IntroFacebookRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const IntroFacebookView(),
      );
    },
    FacebookRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FacebookView(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileView(),
      );
    },
    EditCardRoute.name: (routeData) {
      final args = routeData.argsAs<EditCardRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditCardView(
          key: args.key,
          cardModel: args.cardModel,
        ),
      );
    },
  };
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingView]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [CatalogView]
class CatalogRoute extends PageRouteInfo<CatalogRouteArgs> {
  CatalogRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CatalogRoute.name,
          args: CatalogRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CatalogRoute';

  static const PageInfo<CatalogRouteArgs> page =
      PageInfo<CatalogRouteArgs>(name);
}

class CatalogRouteArgs {
  const CatalogRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'CatalogRouteArgs{key: $key}';
  }
}

/// generated route for
/// [TipDetailView]
class TipDetailRoute extends PageRouteInfo<TipDetailRouteArgs> {
  TipDetailRoute({
    Key? key,
    required List<TipDetailModel> tipDetails,
    List<PageRouteInfo>? children,
  }) : super(
          TipDetailRoute.name,
          args: TipDetailRouteArgs(
            key: key,
            tipDetails: tipDetails,
          ),
          initialChildren: children,
        );

  static const String name = 'TipDetailRoute';

  static const PageInfo<TipDetailRouteArgs> page =
      PageInfo<TipDetailRouteArgs>(name);
}

class TipDetailRouteArgs {
  const TipDetailRouteArgs({
    this.key,
    required this.tipDetails,
  });

  final Key? key;

  final List<TipDetailModel> tipDetails;

  @override
  String toString() {
    return 'TipDetailRouteArgs{key: $key, tipDetails: $tipDetails}';
  }
}

/// generated route for
/// [CreateCardView]
class CreateCardRoute extends PageRouteInfo<void> {
  const CreateCardRoute({List<PageRouteInfo>? children})
      : super(
          CreateCardRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateCardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ImageView]
class ImageRoute extends PageRouteInfo<void> {
  const ImageRoute({List<PageRouteInfo>? children})
      : super(
          ImageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ImageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [IntroFacebookView]
class IntroFacebookRoute extends PageRouteInfo<void> {
  const IntroFacebookRoute({List<PageRouteInfo>? children})
      : super(
          IntroFacebookRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroFacebookRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FacebookView]
class FacebookRoute extends PageRouteInfo<void> {
  const FacebookRoute({List<PageRouteInfo>? children})
      : super(
          FacebookRoute.name,
          initialChildren: children,
        );

  static const String name = 'FacebookRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileView]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditCardView]
class EditCardRoute extends PageRouteInfo<EditCardRouteArgs> {
  EditCardRoute({
    Key? key,
    required CardModel cardModel,
    List<PageRouteInfo>? children,
  }) : super(
          EditCardRoute.name,
          args: EditCardRouteArgs(
            key: key,
            cardModel: cardModel,
          ),
          initialChildren: children,
        );

  static const String name = 'EditCardRoute';

  static const PageInfo<EditCardRouteArgs> page =
      PageInfo<EditCardRouteArgs>(name);
}

class EditCardRouteArgs {
  const EditCardRouteArgs({
    this.key,
    required this.cardModel,
  });

  final Key? key;

  final CardModel cardModel;

  @override
  String toString() {
    return 'EditCardRouteArgs{key: $key, cardModel: $cardModel}';
  }
}
