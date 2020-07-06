class ProductTypeListModel {
  int total;
  List<ProductTypeModel> data;

  ProductTypeListModel({this.total, this.data});

  ProductTypeListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<ProductTypeModel>();
      json['data'].forEach((v) {
        data.add(new ProductTypeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductTypeModel {
  String id;
  String typeNo;
  String typeName;
  String createBy;
  String createTime;
  String updateBy;
  String updateTime;
  int delFlag;
  String tenantId;

  ProductTypeModel(
      {this.id,
        this.typeNo,
        this.typeName,
        this.createBy,
        this.createTime,
        this.updateBy,
        this.updateTime,
        this.delFlag,
        this.tenantId});

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeNo = json['typeNo'];
    typeName = json['typeName'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateBy = json['updateBy'];
    updateTime = json['updateTime'];
    delFlag = json['delFlag'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typeNo'] = this.typeNo;
    data['typeName'] = this.typeName;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateBy'] = this.updateBy;
    data['updateTime'] = this.updateTime;
    data['delFlag'] = this.delFlag;
    data['tenantId'] = this.tenantId;
    return data;
  }
}