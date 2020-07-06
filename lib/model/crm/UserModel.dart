class User {
  int id;
  String username;
  String password;
  String nickname;
  String headImgUrl;
  String phone;
  int sex;
  int deptId;
  String dept;
  bool enabled;
  String type;
  String createTime;
  String updateTime;
  String tenantId;
  String name;

  User(
      {this.id,
        this.username,
        this.password,
        this.nickname,
        this.headImgUrl,
        this.phone,
        this.sex,
        this.deptId,
        this.enabled,
        this.type,
        this.createTime,
        this.updateTime,
        this.tenantId,
        this.dept,
      this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    nickname = json['nickname'];
    headImgUrl = json['headImgUrl'];
    phone = json['phone'];
    sex = json['sex'];
    deptId = json['deptId'];
    enabled = json['enabled'];
    type = json['type'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    tenantId = json['tenantId'];
    name = json['name'];
    dept = json['dept'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['nickname'] = this.nickname;
    data['headImgUrl'] = this.headImgUrl;
    data['phone'] = this.phone;
    data['sex'] = this.sex;
    data['deptId'] = this.deptId;
    data['enabled'] = this.enabled;
    data['type'] = this.type;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['tenantId'] = this.tenantId;
    data['name'] = this.name;
    data['dept'] = this.dept;

    return data;
  }
}
