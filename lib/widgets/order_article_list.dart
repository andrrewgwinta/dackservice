import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../providers/ordarticle.dart';
import '../utilities.dart';

class OrderArticleList extends StatelessWidget {
  final String? orderId;

  const OrderArticleList({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<OrdArticles>(context, listen: false)
          .loadArticle(orderId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else
        //if ((snapshot.error != null) || (!snapshot.hasData)) {
        if (snapshot.error != null) {
          return const Center(child: Text('что-то не так'));
        }
        // else
        //   if (!snapshot.hasData){
        //     return const Center(child : Text('что-то не так hasData'));
        //   }
        else {
          return Consumer<OrdArticles>(
            builder: (ctx, articleData, child) => (articleData.items.isEmpty)
                ? Container(
                decoration: API.kOrdArticleDecoration(),
                child: const Center(child: Text('в заказе нет материалов', style: TextStyle(color: Colors.red, fontSize: 24),)))
                :
                // Card(
                //     shape: kShapeBorder,
                //       elevation: 12,
                //
                //       child:
                Container(
                    decoration: API.kOrdArticleDecoration(),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),

                    //decoration: kBoxDecoration,
                    child: ListView.builder(
                      itemCount: articleData.items.length,
                      itemBuilder: (ctx, index) => ArticleRow(
                          article: articleData.items[
                              index]), /*OrderItem(orderData.orders[i]),*/
                    ),
                  ),
            //),
          );
        }
      },
    );
  }
}

class ArticleRow extends StatelessWidget {
  final Article article;

  const ArticleRow({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
                child: Text(
              article.name!,
              softWrap: true,
              maxLines: 2,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            )),
            SizedBox(width: 40, child: Text(article.sQuantity)),
            SizedBox(width: 60, child: Text(article.sCost)),
          ],
        ),
    );

  }
}
