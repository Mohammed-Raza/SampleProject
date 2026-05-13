import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_project/core/environments/environment.dart';
import 'package:sample_project/features/presentation/widgets/responsive_page.dart';

void main() {
  testWidgets('responsive page renders content', (WidgetTester tester) async {
    Environment().configure();

    await tester.pumpWidget(
      const MaterialApp(
        home: ResponsivePage(
          title: 'Sample Project',
          child: Text('Responsive UI ready'),
        ),
      ),
    );

    expect(find.text('Sample Project'), findsOneWidget);
    expect(find.text('Responsive UI ready'), findsOneWidget);
  });
}
