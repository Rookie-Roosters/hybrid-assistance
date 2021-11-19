class SessionStore{ //idk si esto se necesita
  String _id = '';
  bool isProf = false;

  void setUser(String _id, bool isProf){
    this._id=_id;
    this.isProf=isProf;
  }
}