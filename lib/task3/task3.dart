import 'package:flutter/material.dart';
List<int>  listofdata = [55,25,47,10,35,14,10];


List<int>  uniqedata = [];
void filterdata(List<int> selectedList){
uniqedata.clear();
//----------  Used For Remove Duplicates From List -------------\\
  for(int i = 0; i < selectedList.length; i++){
    if(!uniqedata.contains(selectedList[i])){
      uniqedata.add(selectedList[i]);
    }
  }
  print(uniqedata);

 int currentIndexvalue = 0;
  for(int i = 0; i < uniqedata.length; i++){


    for(int j = i + 1; j < uniqedata.length; j++){
      if(uniqedata[i] > uniqedata[j]){
             
            currentIndexvalue = uniqedata[i];
        uniqedata[i] = uniqedata[j];
        uniqedata[j] = currentIndexvalue;

    
      }

    }

  
  }

    print('Print Uniqe and Sort List $uniqedata');


}