library globals;

import 'package:dackservice/utilities.dart';


bool starting = true;

//seesion information
String serverName='';
String token = '';
String userId ='';
String userName ='';
String machineId ='';
String machineName ='';

//filter information
DateTime filterDate = DateTime.now();
FilterDateType fltDateType = FilterDateType.fdtOneDayNoDone;
String fltOrdNum='';
String fltOrdPerson='';
String fltOrdNum1C='';
FilterMachineType fltMachineType = FilterMachineType.fmtOnlyCurrent;