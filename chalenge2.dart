class Artist {
  final String name;

  Artist({required this.name});
}

class Performance {
  Artist artist;
  String stage;
  DateTime startTime;
  DateTime endTime;

  Performance({
    required this.artist,
    required this.stage,
    required this.startTime,
    required this.endTime,
  });
}

class Schedule {
  List<Performance> performances = [];
  Map<String, List<Performance>> stagePerformances = {};
  Rules rules;
  Schedule({required this.rules});

  void addPerformance(Performance performance) {

    if (performances.length >= rules.maximumPerformances) {
      print("Maximum number of performances reached.");
      return;
    }

    performances.add(performance);

    var stage = stagePerformances[performance.stage];

    if (stage == null) {
      stage = [];
      stagePerformances[performance.stage] = stage;
    }

    stage.add(performance);

  }
 
}

class Rules {
  int minimumGap;
  int maximumPerformances;
  bool allowOverlap;

  Rules({
    required this.minimumGap,
    required this.maximumPerformances,
    required this.allowOverlap,
  });
}

void main() {
  Artist artist1 = Artist(name: "Dara");

  Artist artist2 = Artist(name: "Sok");

  Performance performance1 = Performance(
    artist: artist1,
    stage: "Stage A",
    startTime: DateTime(2026, 9, 2, 19, 0),
    endTime: DateTime(2026, 9, 2, 20, 0),
  );

  Performance performance2 = Performance(
    artist: artist2,
    stage: "Stage B",
    startTime: DateTime(2026, 9, 2, 19, 30),
    endTime: DateTime(2026, 9, 2, 20, 30),
  );

  Rules rules = Rules(
    minimumGap: 0,
    maximumPerformances: 20,
    allowOverlap: false,
  );

  Schedule schedule = Schedule(rules: rules);

  schedule.addPerformance(performance1);
  schedule.addPerformance(performance2);

  for (Performance performance in schedule.performances) {
    print("Artist: ${performance.artist.name} - Stage: ${performance.stage}");
    print("Start: ${performance.startTime}");
    print("End: ${performance.endTime}");
  }


}
