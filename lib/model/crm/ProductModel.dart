class ProductModelList {
  int total;
  List<ProductModel> data;

  ProductModelList({this.total, this.data});

  ProductModelList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = new List<ProductModel>();
      json['data'].forEach((v) {
        data.add(new ProductModel.fromJson(v));
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

class ProductModel {
  String id;
  String proId;
  double sell;
  double amount;
  int count;
  String proNo;
  String proName;
  double price;
  String norms;
  String unit;
  String type;
  String remarks;
  String pic;
  String tenantId;
  bool status=false;
  String relationId;
  ProductModel(
      {this.id,
        this.proId,
        this.sell,
        this.amount,
        this.count,
        this.proNo,
        this.proName,
        this.price,
        this.norms,
        this.unit,
        this.type,
        this.remarks,
        this.pic,
        this.tenantId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    proId = json['proId'];
    sell = json['sell'];
    amount = json['amount'];
    count = json['count'];
    proNo = json['proNo'];
    proName = json['proName'];
    price = json['price'];
    norms = json['norms'];
    unit = json['unit'];
    type = json['type'];
    remarks = json['remarks'];
    pic = json['pic'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['proId'] = this.proId;
    data['sell'] = this.sell;
    data['amount'] = this.amount;
    data['count'] = this.count;
    data['proNo'] = this.proNo;
    data['proName'] = this.proName;
    data['price'] = this.price;
    data['norms'] = this.norms;
    data['unit'] = this.unit;
    data['type'] = this.type;
    data['remarks'] = this.remarks;
    data['pic'] = this.pic;
    data['tenantId'] = this.tenantId;
    data['relationId'] = this.relationId;

    return data;
  }
}


class ProModel{//用来产品传参给后台
  String proId;
  double sell;
  double amount;
  int count;
  String relationId;
  String type;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['proId'] = this.proId;
    data['sell'] = this.sell;
    data['amount'] = this.amount;
    data['count'] = this.count;
    data['type'] = this.type;
    data['relationId'] = this.relationId;
    return data;
  }
  ProModel({this.proId,this.sell,this.amount,this.count,this.relationId,this.type});

}