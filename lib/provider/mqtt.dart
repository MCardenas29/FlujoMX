import 'package:FlujoMX/entity/fee.dart';
import 'package:FlujoMX/entity/flow.dart';
import 'package:FlujoMX/provider/database.dart';
import 'package:FlujoMX/provider/fee.dart';
import 'package:FlujoMX/repository/flow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
part '../generated/provider/mqtt.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
MqttServerClient mqttClient(Ref ref) {
  final client = MqttServerClient.withPort("10.0.2.2", "client-1", 1883);
  // client.logging(on: true);
  return client;
}

@Riverpod(keepAlive: true, dependencies: [mqttClient, flowRepository])
Stream<Flow> mqttFlow(Ref ref) async* {
  final client = ref.read(mqttClientProvider);
  final repo = ref.read(flowRepositoryProvider);
  final state = await client.connect();
  print(state?.state);

  client.subscribe('flow/add', MqttQos.atMostOnce);
  await for (final event in client.published!) {
    final message =
        MqttPublishPayload.bytesToStringAsString(event.payload.message);
    var flow = Flow(value: double.parse(message), timestamp: DateTime.now());

    flow = await repo.save(flow);
    print(message);
    yield flow;
  }
}

@Riverpod(dependencies: [mqttFlow, flowRepository])
Future<double> usage(Ref ref) async {
  final flow = ref.watch(mqttFlowProvider);
  final repo = ref.read(flowRepositoryProvider);
  return repo.getUsage();
}

@Riverpod(dependencies: [usage, feePrice])
List<Range>? usageRange(Ref ref) {
  final usage = ref.watch(usageProvider);
  final prices = ref.watch(feePriceProvider);
  if (prices == null) return null;
  var _t = usage.value ?? 0;
  var ranges = <Range>[];

  for (final price in prices) {
    if (_t <= 0) break;
    ranges.add(price);
    _t -= price.maxUsage;
  }

  return ranges;
}

@Riverpod(dependencies: [usage, usageRange])
Future<double> cost(Ref ref) async {
  final usage = ref.watch(usageProvider).value ?? 0;
  final prices = ref.watch(usageRangeProvider);
  if (prices == null) return 0;
  double total = 0;
  var _t = usage;
  for (final price in prices) {
    total += price.inRange(_t) ? price.cost : _t * price.total;
    _t -= price.maxUsage;
  }
  return total;
}
