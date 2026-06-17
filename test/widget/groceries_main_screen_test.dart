import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/features/presentation/pages/groceries/grocery.dart';
import 'package:sample_project/features/presentation/bloc/groceries/groceries_bloc.dart';
import 'package:sample_project/features/domain/entities/groceries_entity.dart';
import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/l10n/app_localizations.dart';
import 'package:sample_project/features/presentation/widgets/common_widgets.dart';
import 'package:sample_project/features/presentation/widgets/page_error.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:sample_project/generated/assets.dart';

class MockGroceriesBloc extends MockBloc<GroceriesEvent, GroceriesState> implements GroceriesBloc {}

void main() {
  late MockGroceriesBloc mockGroceriesBloc;

  setUpAll(() {
    registerFallbackValue(LoadGroceriesEvent(''));
  });

  setUp(() {
    mockGroceriesBloc = MockGroceriesBloc();
    // Default state
    when(() => mockGroceriesBloc.state).thenReturn(GroceriesInitial());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<GroceriesBloc>.value(
        value: mockGroceriesBloc,
        child: const GroceriesMainScreen(groceryType: GroceryType.fruits),
      ),
    );
  }

  testWidgets('adds LoadGroceriesEvent on initState', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    verify(() => mockGroceriesBloc.add(any(that: isA<LoadGroceriesEvent>()))).called(1);
  });

  testWidgets('shows CircularIndicator when state is GroceryItemsLoading', (WidgetTester tester) async {
    when(() => mockGroceriesBloc.state).thenReturn(GroceryItemsLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularIndicator), findsOneWidget);
  });

  testWidgets('shows PageErrorWidget when state is GroceryItemsError', (WidgetTester tester) async {
    when(() => mockGroceriesBloc.state).thenReturn(GroceryItemsError(('Error message', Assets.gifsPageError)));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(PageErrorWidget), findsOneWidget);
    
    // Using a predicate to find the text within RichText if find.text fails
    final richTextFinder = find.byWidgetPredicate((widget) => 
      widget is RichText && widget.text.toPlainText().contains('Error message'));
    expect(richTextFinder, findsOneWidget);
  });

  testWidgets('shows no items text when state is GroceryItemsSuccess and list is empty', (WidgetTester tester) async {
    when(() => mockGroceriesBloc.state).thenReturn(GroceryItemsSuccess(const []));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('No grocery items are available to show'), findsOneWidget);
  });

  testWidgets('shows list of groceries when state is GroceryItemsSuccess', (WidgetTester tester) async {
    // Set a larger screen size to avoid overflow
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    final grocery = GroceriesEntity('1', name: 'Apple', prize: 10.0, content: 'Red apple', images: ['https://example.com/apple.png']);
    grocery.totalAmount = 10.0;
    
    when(() => mockGroceriesBloc.state).thenReturn(GroceryItemsSuccess([grocery]));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('Red apple'), findsOneWidget);
    expect(find.textContaining('10.00'), findsOneWidget);
  });
}
