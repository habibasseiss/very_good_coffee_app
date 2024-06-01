import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:very_good_coffee_app/bootstrap.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/repositories/favorites/favorites.dart';
import 'package:very_good_coffee_app/services/api_service/coffee_api_service.dart';
import 'package:very_good_coffee_app/services/database_service/database_service.dart';
import 'package:very_good_coffee_app/services/services.dart';

/// {@template global_repository_provider}
/// A provider widget that provides global repositories to the widget tree. It
/// instantiates [ApiService], [CoffeeRepository] and [FavoritesRepository].
/// {@endtemplate}
class GlobalRepositoryProvider extends StatelessWidget {
  /// {@macro global_repository_provider}
  const GlobalRepositoryProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final coffeeApiService = CoffeeApiService(
      baseUrl: 'coffee.alexflipnote.dev',
      httpClient: http.Client(),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CoffeeRepository>(
          create: (context) => ApiCoffeeRepository(
            coffeeApiService: coffeeApiService,
          ),
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (context) => ApiFavoritesRepository(
            databaseService: locator.get<DatabaseService>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
