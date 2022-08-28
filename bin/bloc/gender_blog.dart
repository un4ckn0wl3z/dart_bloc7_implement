import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import '../model/gender.dart';
import 'common.dart';

class GenderGetEvent extends Event {
  @override
  String toString() {
    return 'GenderGetEvent';
  }
}

class GenderGetStateSuccess extends State {
  final List<Gender> genders;
  GenderGetStateSuccess({required this.genders});

  @override
  String toString() {
    return genders.toString();
  }
}

class GenderBloc extends Bloc<Event, State> {
  GenderBloc() : super(StateUnInitialized());

  @override
  Stream<State> mapEventToState(Event event) async* {
    if (event is GenderGetEvent) {
      yield StateLoading(title: event.toString());

      final response = await http
          .get(Uri.parse('http://localhost:3001/registration/genders'));

      if (response.statusCode != HttpStatus.ok) {
        yield StateError(message: response.statusCode.toString());
        return;
      }

      final json = jsonDecode(response.body) as List; // list of map
      final genders = json.map((e) => Gender.fromJson(e)).toList();
      yield GenderGetStateSuccess(genders: genders);
    }
  }
}
