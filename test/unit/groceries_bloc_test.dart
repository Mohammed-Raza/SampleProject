import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sample_project/features/domain/entities/groceries_entity.dart';
import 'package:sample_project/features/domain/use_cases/grocery_use_cases.dart';
import 'package:sample_project/features/presentation/bloc/groceries/groceries_bloc.dart';

class MockGroceryUseCases extends Mock implements GroceryUseCases {}

void main() {
  late GroceriesBloc groceriesBloc;
  late MockGroceryUseCases mockGroceryUseCases;

  setUp(() {
    mockGroceryUseCases = MockGroceryUseCases();
    groceriesBloc = GroceriesBloc(mockGroceryUseCases);
  });

  tearDown(() {
    groceriesBloc.close();
  });

  group('GroceriesBloc - Quantity updates', () {
    late GroceriesEntity grocery;

    setUp(() {
      grocery = GroceriesEntity('1', name: 'Apple', prize: 10.0);
      // Initialize the bloc's internal list to simulate loaded data
      groceriesBloc.groceries = [grocery];
    });

    blocTest<GroceriesBloc, GroceriesState>(
      'emits [GroceryItemsSuccess] and increments outQty when AddOutQtyEvent is added',
      build: () => groceriesBloc,
      act: (bloc) => bloc.add(AddOutQtyEvent(grocery)),
      expect: () => [
        isA<GroceryItemsSuccess>(),
      ],
      verify: (_) {
        expect(grocery.outQty, 1);
        expect(grocery.totalAmount, 10.0);
        expect(grocery.controller.text, '1');
      },
    );

    blocTest<GroceriesBloc, GroceriesState>(
      'emits [GroceryItemsSuccess] and decrements outQty when SubtractOutQtyEvent is added',
      build: () {
        grocery.outQty = 2;
        grocery.totalAmount = 20.0;
        grocery.controller.text = '2';
        return groceriesBloc;
      },
      act: (bloc) => bloc.add(SubtractOutQtyEvent(grocery)),
      expect: () => [
        isA<GroceryItemsSuccess>(),
      ],
      verify: (_) {
        expect(grocery.outQty, 1);
        expect(grocery.totalAmount, 10.0);
        expect(grocery.controller.text, '1');
      },
    );

    blocTest<GroceriesBloc, GroceriesState>(
      'emits nothing when SubtractOutQtyEvent is added and outQty is 0',
      build: () {
        grocery.outQty = 0;
        grocery.totalAmount = 0.0;
        grocery.controller.text = '';
        return groceriesBloc;
      },
      act: (bloc) => bloc.add(SubtractOutQtyEvent(grocery)),
      expect: () => [],
      verify: (_) {
        expect(grocery.outQty, 0);
        expect(grocery.totalAmount, 0.0);
      },
    );
  });
}
