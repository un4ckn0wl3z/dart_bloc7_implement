import 'package:africa_bloc7/africa_bloc7.dart' as africa_bloc7;

import 'bloc/gender_blog.dart';

void main(List<String> arguments) {
  final genderBloc = GenderBloc();
  genderBloc.stream.listen(print);

  genderBloc.add(GenderGetEvent());

  genderBloc.close();
}
