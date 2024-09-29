import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/Theme/app_button_style.dart';

import 'package:the_movie_db/ui/widgets/auth/auth_model.dart';



class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Войти в свою учётную запись', style: TextStyle(color: Colors.white),)),
      ),
      body: ListView(children: const [
        _HeaderWidget(),
      ],),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
            fontSize: 16,
            color: Colors.black
          );
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25,),
          const _FormWidget(),
          const SizedBox(height: 25,),
          const Text("Чтобы пользоваться правкой и возможностями рейтинга TMDB, а также получить персональные рекомендации, необходимо войти в свою учётную запись. Если у вас нет учётной записи, её регистрация является бесплатной и простой.",
          style: textStyle
          ),
          const SizedBox(height: 5,),
          TextButton(onPressed: null, style: AppButtonStyle.linkButton, child: const Text("Регистрация"),),
          const SizedBox(height: 25,),
          const Text("Если Вы зарегистрировались, но не получили письмо для подтверждения.",
          style: textStyle,
          ),
          const SizedBox(height: 5,),
          TextButton(onPressed: null, style: AppButtonStyle.linkButton, child: const Text("Подтверждение email"),),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget();
  
  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();
    
    const textStyle = TextStyle(
        fontSize: 16,
        color: Color(0xFF212529),
    );
    const textFieldDecoration = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessageWidget(),
        const Text("Логин", style: textStyle,),
        const SizedBox(height: 5,),
        TextField(
          controller: model.loginTextController,
          decoration: textFieldDecoration,
        ),
        const SizedBox(height: 20,),
        const Text("Пароль", style: textStyle,),
        const SizedBox(height: 5,),
        TextField(
          controller: model.passwordTextController,
          decoration: textFieldDecoration, obscureText: true,
        ),
        const SizedBox(height: 25,),
        Row(
          children: [
            const _AuthButtonWidget(),
            const SizedBox(width: 30,),
            TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton, child: const Text("Забыли пароль?"),
            )
          ],)
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget();


  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthModel>();
    const color = Color(0xFF01B4E4);
    final onPressed = model.canStartAuth ? () => model.auth(context) : null;
    final child = model.isAuthProgress ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2.0)) : const Text("Логин",);
    return TextButton(
      onPressed: onPressed,    
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle:  MaterialStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 15, vertical: 8))
      ), 
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((AuthModel m) => m.errorMessage);

    if(errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child:Text(
        errorMessage, 
        style: const TextStyle(
          color: Colors.red, 
          fontSize: 17),
        )
      );
  }
}