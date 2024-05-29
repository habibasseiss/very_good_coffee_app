import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/services.dart';

class GlobalRepositoryProvider extends StatelessWidget {
  const GlobalRepositoryProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(
      endpoint: 'coffee.alexflipnote.dev',
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CoffeeRepository>(
          create: (context) => ApiCoffeeRepository(
            apiService: apiService,
          ),
        ),
      ],
      child: child,
    );
  }
}
