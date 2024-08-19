import 'package:aplikasi_catatan/Feature/Home/model/ModelData.dart';
import 'package:flutter/cupertino.dart';

abstract class ModelData{
  final List<Note> list;
  final String? ussername;
  final String? email;
  final String? uid;
  final int index;
  ModelData(this.list,this.ussername, this.email, this.uid,this.index);
}
abstract class HomeEvent{

}
class ModelIntial extends ModelData{
  ModelIntial() : super([],"","","",0);
}
class ModelUpdate extends ModelData{

  ModelUpdate(List<Note>list,String ussername,String email, String uid,int index):super(list,ussername,email, uid,index);

}
class OnHomeEvent extends HomeEvent{
  final int index;
  OnHomeEvent(this.index);
}
class LogoutEvent extends HomeEvent{
  final BuildContext context;
  LogoutEvent(this.context);
}
