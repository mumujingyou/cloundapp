class UndoApplyCountModel {
  int interviewCount;
  int hrApplyCount;
  int contractCount;
  int oaApplyCount;

  UndoApplyCountModel(
      {this.interviewCount,
        this.hrApplyCount,
        this.contractCount,
        this.oaApplyCount});

  UndoApplyCountModel.fromJson(Map<String, dynamic> json) {
    interviewCount = json['interviewCount'];
    hrApplyCount = json['hrApplyCount'];
    contractCount = json['contractCount'];
    oaApplyCount = json['oaApplyCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interviewCount'] = this.interviewCount;
    data['hrApplyCount'] = this.hrApplyCount;
    data['contractCount'] = this.contractCount;
    data['oaApplyCount'] = this.oaApplyCount;
    return data;
  }
}