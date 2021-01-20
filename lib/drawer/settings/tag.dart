import 'package:flutter/material.dart';
import 'package:mydiary/drawer/settings/taglist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class Tag extends StatefulWidget {
  final Color color;

  const Tag({Key key, this.color}) : super(key: key);
  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  List<String> tagsList=[];
  List<String> tagsSet=[];
  List<Widget> wids;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
  }

  Future getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('items');
  }
  ToList(val){
    if(this != "null"){
      return json.decode(val);
    }else{
      return null;
    }
  }
  indexAll(list,str){
    List<int> last=[];
    for(int i = 0; i < list.length; i++){
      if(str==list[i])
        last.add(i);
      else
        null;
    }
    return last;
  }
  getItems() async {
    List<String> data = await getList();
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        var snapshot = data[i].split('`');
        var _values = snapshot[14];
        if(_values!=null){
          var values= List<String>.from(ToList(_values.replaceAll('[','["').replaceAll(',','","').replaceAll(']','"]').replaceAll(' ','')));
          for(var value in values){
            if(value.trim()!=""){
              tagsList.add(value);
            }
          }
        }
      }
      if(tagsList!=null && tagsList !=[]){
        tagsSet=tagsList.toSet().toList();
        setState(() {
          wids=List.generate(tagsSet.length, (index) {
            return Column(children: <Widget>[
              ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TagList(tag: tagsSet[index],)),
                  );
                },
                title: Text("#"+tagsSet[index]),
                trailing: Text("${count(tagsList,tagsSet[index])} Enteries"),
              ),
              Divider()
            ],);
          });
        });
      }
    }
  }

  int count(List<String> list, String element) {
    if (list == null || list.isEmpty) {
      return 0;
    }

    int count = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == element) {
        count++;
      }
    }

    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tag Management',style: TextStyle(color: Colors.white,fontSize: 15),),
        backgroundColor: widget.color,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: wids!=null?SingleChildScrollView(child: Column(children: wids,),):Center(child: Text("No Tags Used",style: TextStyle(color: Colors.black38),),)),
    );
  }
}
