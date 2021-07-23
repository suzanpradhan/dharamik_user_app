class BugModel{
  String id;
  String name;
  String detail;
  String userId;
  String userName;
  String userPhotoUrl;

  BugModel(this.id, this.name, this.detail);


  BugModel.fromJson(bug){
    id = bug['id'];
    name = bug['name'];
    detail = bug['detail'];
    userId = bug['userId'];
    userName = bug['userName'];
    userPhotoUrl = bug['userPhotoUrl'];
  }

  toJson(){
    return {
      'id':id,
      'name':name,
      'detail':detail,
      'userId':userId,
      'userName':userName,
      'userPhotoUrl':userPhotoUrl
    };
  }


}