import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.backgroundDune).existsSync(), isTrue);
    expect(File(AppImages.dune).existsSync(), isTrue);
    expect(File(AppImages.duneDetails).existsSync(), isTrue);
    expect(File(AppImages.paul).existsSync(), isTrue);
    expect(File(AppImages.sarc).existsSync(), isTrue);
    expect(File(AppImages.worstActor).existsSync(), isTrue);
  });
}
