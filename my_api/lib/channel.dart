import 'package:my_api/controller/person_controller.dart';
import 'package:my_api/util/config.dart';

import 'my_api.dart';

class MyApiChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final config = Config(options.configurationFilePath);
    final database = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);

    context = ManagedContext(dataModel, database);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/person/[:parameter]").link(() => PersonController(context));

    return router;
  }
}
