import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class SignOut extends WhenWithWorld<FlutterWorld> {
  SignOut() : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r"When I signout");

  @override
  Future<void> executeStep() async {
    final signout = find.byValueKey("signout");
    await FlutterDriverUtils.tap(world.driver, signout, timeout: timeout);
  }
}