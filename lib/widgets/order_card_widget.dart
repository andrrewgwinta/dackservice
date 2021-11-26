import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as global;
import '../providers/ordservice.dart';
import '../widgets/order_article_list.dart';
import '../widgets/dialog_worker_checked.dart';
import '../utilities.dart';

class OrderCard extends StatefulWidget {
  final ServiceItem service;

  const OrderCard({Key? key, required this.service}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  void doDonedInformation(String newValue) {
    if (newValue == '^^') {
      newValue = '';
    }

    if (newValue != widget.service.workersIdString) {
      Provider.of<OrdServices>(context, listen: false).updateDoneInformation(
          widget.service.id, newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAnother =
        ((global.fltDateType == FilterDateType.fdtAllNoDone) &&
            !(widget.service.datePlan == global.filterDate))
            ||
            ((global.fltMachineType == FilterMachineType.fdtAllVisible) &&
                !(widget.service.machineId == global.machineId));


    return Container(
      //color: Colors.black,
        height: widget.service.expanded ? 180 : 75,
        child: Card(
          child: Column(
            children: [
              Container(
                height: 59,
                //color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 55,
                      //color: Colors.red,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              widget.service.expanded =
                              !widget.service.expanded;
                            });
                            //print('before ${widget.service.expanded}');
                            //print('before ${after.service.expanded}');
                          },
                          icon: Icon(
                            widget.service.expanded
                                ? FontAwesomeIcons.arrowAltCircleUp
                                : FontAwesomeIcons.arrowAltCircleDown,
                            color: Colors.blue,
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Container(
                          width: 80,
                          //color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.service.name,
                                style: TextStyle(
                                  color: isAnother ? Colors.blue : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                widget.service.orderName,
                                style: TextStyle(
                                    color: isAnother ? Colors.blue : Colors
                                        .black,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16),
                              ),
                              Text(
                                isAnother
                                    ? '${DateFormat.yMMMd('ru').format(
                                    widget.service.datePlan)} ${widget.service
                                    .machineName}'
                                    : widget.service.atypeName,
                                style: TextStyle(
                                    color: isAnother ? Colors.blue : Colors
                                        .black,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 60,
                      //color: Colors.red,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return DialogWorkerChecked(
                                service: widget.service,
                                contentColor: isAnother ? Colors.blue : Colors
                                    .black,
                                pressOK: doDonedInformation,
                              );
                            },
                          );
                          //
                        },
                        child: CircleAvatar(
                          child: CircleAvatar(
                            backgroundColor:
                            widget.service.doned ? kIconColor : Colors.white,
                            radius: 10,
                          ),
                          backgroundColor:
                          widget.service.doned ? Colors.blue : kIconColor,
                          radius: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              if (widget.service.expanded)
                Expanded(child: Container(height: 59,
                  //color: Colors.yellow,
                  child: OrderArticleList(orderId: widget.service.orderId),)),
            ],
          ),
        ));
  }
}


