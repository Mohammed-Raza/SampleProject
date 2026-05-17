import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_project/features/data/models/groceries_model.dart';
import 'package:sample_project/features/domain/repository/groceries_repo.dart';
import 'package:sample_project/features/domain/use_cases/grocery_use_cases.dart';

import 'grocery_repo_test.mocks.dart';

@GenerateMocks([GroceriesRepository])
void main() {
  late GroceryUseCases useCases;
  late MockGroceriesRepository mockRepository;

  setUp(() {
    mockRepository = MockGroceriesRepository();
    useCases = GroceryUseCases(mockRepository);
  });

  group('GroceryUseCases', () {
    test('loadCategories should return a list of GroceryCategoryModel',
        () async {
      // Arrange
      final categories = [
        GroceryCategoryModel('1', 'Fruits', 'fruits'),
        GroceryCategoryModel('2', 'Vegetables', 'veg'),
      ];
      when(mockRepository.fetchGroceryCategories())
          .thenAnswer((_) async => categories);

      // Act
      final result = await useCases.loadCategories();

      // Assert
      expect(result, categories);
      verify(mockRepository.fetchGroceryCategories()).called(1);
    });

    test('loadGroceryItems should return a list of GroceriesEntity', () async {
      // Arrange
      final models = [
        GroceriesModel('1', name: 'Apple', prize: 2.0),
        GroceriesModel('2', name: 'Banana', prize: 1.0),
      ];
      when(mockRepository.fetchGroceryItems('1'))
          .thenAnswer((_) async => models);

      // Act
      final result = await useCases.loadGroceryItems('1');

      // Assert
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[0].name, 'Apple');
      expect(result[1].id, '2');
      expect(result[1].name, 'Banana');
      verify(mockRepository.fetchGroceryItems('1')).called(1);
    });
  });
}
