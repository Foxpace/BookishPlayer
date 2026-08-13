import 'package:bookish_player/core/presentation/book_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Book cover', () {
    testWidgets(
      'Given artwork, When the cover is built, Then heroes the complete cover bounds',
      (tester) async {
        // WHEN
        await tester.pumpWidget(
          const MaterialApp(
            home: BookCover(
              title: 'Dune',
              artworkPath: 'missing-cover.jpg',
              heroTag: 'book-id',
            ),
          ),
        );

        // THEN
        expect(
          find.ancestor(
            of: find.byType(Container),
            matching: find.byType(Hero),
          ),
          findsOneWidget,
        );
        expect(tester.widget<Image>(find.byType(Image)).fit, BoxFit.contain);
      },
    );

    testWidgets(
      'Given no artwork, When the cover is built, Then retains a fallback surface',
      (tester) async {
        // WHEN
        await tester.pumpWidget(
          const MaterialApp(home: BookCover(title: 'Dune')),
        );

        // THEN
        final cover = tester.widget<Container>(find.byType(Container));
        final decoration = switch (cover.decoration) {
          final BoxDecoration decoration => decoration,
          _ => throw TestFailure('Expected the cover decoration.'),
        };

        expect(decoration.color, isNotNull);
      },
    );
  });
}
