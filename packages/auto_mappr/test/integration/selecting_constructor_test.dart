import 'package:test/test.dart';

import 'fixture/selecting_constructor.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  group('when no constructor selected', () {
    test(
      'with final target',
      () {
        final dto = fixture.TestEmptyDto(1, 2, 3);
        final converted = mappr.convert<fixture.TestEmptyDto, fixture.FinalTarget>(dto);

        expect(converted.a, 1);
        expect(converted.b, 2);
        expect(converted.c, 3);
      },
    );

    test(
      'with non final target',
      () {
        final dto = fixture.TestEmptyDto(1, 2, 3);
        final converted = mappr.convert<fixture.TestEmptyDto, fixture.NonFinalTarget>(dto);

        expect(converted.a, 1);
        expect(converted.b, 2);
        expect(converted.c, 3);
      },
    );
  });

  group('when alpha constructor selected', () {
    test(
      'with final target',
      () {
        final dto = fixture.TestAlphaDto(1, 2, 3);
        final converted = mappr.convert<fixture.TestAlphaDto, fixture.FinalTarget>(dto);

        expect(converted.a, 1);
        expect(converted.b, null);
        expect(converted.c, null);
      },
    );

    test(
      'with non final target',
      () {
        final dto = fixture.TestAlphaDto(1, 2, 3);
        final converted = mappr.convert<fixture.TestAlphaDto, fixture.NonFinalTarget>(dto);

        expect(converted.a, 1);
        expect(converted.b, 2);
        expect(converted.c, 3);
      },
    );
  });

  group('when beta constructor selected', () {
    test(
      'with final target',
      () {
        final dto = fixture.TestBetaDto(1, 2, 3);
        final converted = mappr.convert<fixture.TestBetaDto, fixture.FinalTarget>(dto);

        expect(converted.a, null);
        expect(converted.b, 2);
        expect(converted.c, null);
      },
    );

    test(
      'with non final target',
      () {
        final dto = fixture.TestBetaDto(1, 2, 3);
        final converted = mappr.convert<fixture.TestBetaDto, fixture.NonFinalTarget>(dto);

        expect(converted.a, 1);
        expect(converted.b, 2);
        expect(converted.c, 3);
      },
    );
  });

  group('when gama constructor selected', () {
    test(
      'with final target',
      () {
        final dto = fixture.TestGamaDto(1, 2, 3);
        final converted = mappr.convert<fixture.TestGamaDto, fixture.FinalTarget>(dto);

        expect(converted.a, null);
        expect(converted.b, null);
        expect(converted.c, 3);
      },
    );

    test(
      'with non final target',
      () {
        final dto = fixture.TestGamaDto(1, 2, 3);
        final converted = mappr.convert<fixture.TestGamaDto, fixture.NonFinalTarget>(dto);

        expect(converted.a, 1);
        expect(converted.b, 2);
        expect(converted.c, 3);
      },
    );
  });

  group('when nonsense constructor selected', () {
    test(
      'with final target',
      () {
        final dto = fixture.TestNonsenseDto(1, 2, 3);
        final converted = mappr.convert<fixture.TestNonsenseDto, fixture.FinalTarget>(dto);

        expect(converted.a, 1);
        expect(converted.b, 2);
        expect(converted.c, 3);
      },
    );

    test(
      'with non final target',
      () {
        final dto = fixture.TestNonsenseDto(1, 2, 3);
        final converted = mappr.convert<fixture.TestNonsenseDto, fixture.NonFinalTarget>(dto);

        expect(converted.a, 1);
        expect(converted.b, 2);
        expect(converted.c, 3);
      },
    );
  });

  group('factory constructors', () {
    test(
      'factory constructors are not selected when non-factory exists',
      () {
        final dto = fixture.TestFactoryDto(a: 1, b: 2, c: 3, d: 4);
        final converted = mappr.convert<fixture.TestFactoryDto, fixture.TestFactoryNotSelected>(dto);

        expect(converted, fixture.TestFactoryNotSelected.three(a: 1, b: 2, c: 3));
      },
    );

    test(
      'when class has only factory constructors, fromJson is not selected',
      () {
        final dto = fixture.TestFactoryDto(a: 1, b: 2, c: 3, d: 4);
        final converted = mappr.convert<fixture.TestFactoryDto, fixture.TestFactorySelected>(dto);

        expect(converted, fixture.TestFactorySelected.alpha(a: 1, b: 2, c: 3, d: 666));
      },
    );
  });
}
