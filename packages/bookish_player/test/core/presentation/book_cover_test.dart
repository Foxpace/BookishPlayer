import 'package:bookish_player/core/presentation/book_cover.dart';
import 'package:material_ui/material_ui.dart';
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

    testWidgets(
      'Given portrait and square covers, When the hero flies, Then its artwork resizes with the flight',
      (tester) async {
        // GIVEN
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  const BookCover(
                    title: 'Dune',
                    heroTag: 'book-id',
                    layout: (
                      size: 64,
                      heightFactor: 1.22,
                      imageFit: BoxFit.contain,
                    ),
                  ),
                  Builder(
                    builder: (context) => TextButton(
                      onPressed: () => Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (_) => const Scaffold(
                            body: Center(
                              child: BookCover(
                                title: 'Dune',
                                heroTag: 'book-id',
                                layout: (
                                  size: 220,
                                  heightFactor: 1,
                                  imageFit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: const Text('Open'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        // WHEN
        await tester.tap(find.text('Open'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 150));

        // THEN
        final flyingCover = find.byWidgetPredicate(
          (widget) => widget is BookCover && widget.heroTag == null,
        );
        expect(flyingCover, findsOneWidget);
        final flightSize = tester.getSize(flyingCover);
        final flightLayout = tester.widget<BookCover>(flyingCover).layout;
        expect(flightSize.width, greaterThan(64));
        expect(flightSize.width, lessThan(220));
        expect(flightLayout.size, flightSize.width);
        expect(
          flightLayout.size * flightLayout.heightFactor,
          flightSize.height,
        );

        await tester.pumpAndSettle();
        expect(tester.getSize(find.byType(BookCover)), const Size(220, 220));
      },
    );
  });
}
