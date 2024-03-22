import 'package:flutter_getit/flutter_getit.dart';

class BindingInitialApplication extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        // Bind.lazySingleton<ClientRepository>((i) => ClientRepositoryImpl()),
        // Bind.lazySingleton((i) => ClientController(clientRepository: i()))
      ];
}
