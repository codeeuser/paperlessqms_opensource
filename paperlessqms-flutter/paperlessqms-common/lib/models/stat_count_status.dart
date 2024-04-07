class StatCountStatus {
  int? countWait;
  int? countQueue;
  int? countCompleted;
  int? countRecall;
  int? countTimeout;
  int? countCancel;
  List<(DateTime, int)>? dateCountList;
  StatCountStatus({
    this.countWait,
    this.countQueue,
    this.countCompleted,
    this.countRecall,
    this.countTimeout,
    this.countCancel,
    this.dateCountList,
  });
}