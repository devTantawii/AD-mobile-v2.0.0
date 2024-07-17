import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/blocs/auth_bloc/auth_bloc.dart';
import 'home/layout_screan/layout_screan.dart';
import 'home/selectLanguage/selectLanguage.dart';

class ComposeUi extends StatelessWidget {
  const ComposeUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) =>
      state is Authenticated ? LayoutScreen() : SelectLanguage(true)
  );
}
