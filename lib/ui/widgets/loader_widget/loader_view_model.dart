import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/services/auth_service.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class LoaderViewModel{
  final BuildContext context;
  final _authService = AuthService();

  LoaderViewModel(this.context){
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authService.isAuth();
    final nextScreen = isAuth
        ? MainNavigationRoutesName.mainScreen
        : MainNavigationRoutesName.auth;
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(
      nextScreen
    );
  }
}