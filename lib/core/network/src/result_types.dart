import 'package:playx/playx.dart' hide ResultFuture;

typedef ResultFuture<T> = Future<NetworkResult<T>>;
typedef ResultVoid = Future<NetworkResult<void>>;
