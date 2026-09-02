class Measurement {
  String sensorName;
  double value;
  String unit;
  String? comment;

  Measurement({
    required this.sensorName,
    required this.value,
    required this.unit,
    this.comment,
  });
}

class Limit {
  double? min;
  double? max;
  Limit({this.min, this.max});
}

class SensorManager {
  List<Measurement> measurements = [];

  void addMeasurement(Measurement measurement) {
    measurements.add(measurement);
  }

  void addMeasurements(List<Measurement> newMeasurements) {
    measurements.addAll(newMeasurements);
  }

  void displayAll() {
    for (Measurement measurement in measurements) {
      print(
        "${measurement.sensorName} - ${measurement.value} ${measurement.unit} - ${measurement.comment}",
      );
    }
  }

  void findSensor(String sensorName) {
    for (Measurement measurement in measurements) {
      if (measurement.sensorName == sensorName) {
        print(
          "${measurement.sensorName} - ${measurement.value} ${measurement.unit} - ${measurement.comment}",
        );
      }
    }
  }

  double average(String sensorName) {
    double total = 0;
    int count = 0;

    for (Measurement measurement in measurements) {
      if (measurement.sensorName == sensorName) {
        total += measurement.value;
        count++;
      }
    }
    if (count == 0) {
      print("$sensorName doesn't have ");
      return 0;
    }

    double result = total / count;
    print("Average of $sensorName: $result");

    return result;
  }

  void checkValueLimit(String sensorName, Limit limit) {
    for (Measurement measurement in measurements) {
      if (measurement.sensorName == sensorName) {
        double value = measurement.value;

        double? min = limit.min;
        double? max = limit.max;

        if ((min != null && value < min) || (max != null && value > max)) {
          print("$value - OUTSIDE RANGE");
        } else {
          print("$value - OK");
        }
      }
    }
  }
}

void main() {
  SensorManager manager = SensorManager();

  manager.addMeasurement(
    Measurement(
      sensorName: "temperature",
      value: 24.5,
      unit: "°C",
      comment: "Normal",
    ),
  );

  manager.addMeasurement(
    Measurement(sensorName: "speed", value: 7.8, unit: "km/s"),
  );

  manager.displayAll();

  manager.findSensor("temperature");

  manager.average("temperature");

  Limit temperatureLimit = Limit(min: 0, max: 50);
  manager.checkValueLimit("Temperature", temperatureLimit);

  Limit speedLimit = Limit(min: 0, max: 10);
  manager.checkValueLimit("speed", speedLimit);
}
