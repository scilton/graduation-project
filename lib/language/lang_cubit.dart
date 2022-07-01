import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitial());

  static LangCubit get(context) => BlocProvider.of(context);

  void changeLanguage(BuildContext context, String lang) async {
    await EasyLocalization.of(context)!.setLocale(Locale(lang));
    emit(LanguageChange());
  }
}
