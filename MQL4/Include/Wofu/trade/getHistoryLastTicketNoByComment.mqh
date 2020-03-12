
#include <Wofu\\trade\\omsIsMyOrder.mqh>
int getHistoryLastTicketNoByComment
(
   string fSymbol,
   MIXED_ORDER_TYPE fOdType,
   int fMagicNumber,
   string fCommentPrefix,
   datetime fOrderOpenTimeMin =D'2000.01.01 00:00:00',
   datetime fOrderOpenTimeMax =D'2999.12.31 23:59:59',
   datetime fOrderCloseTimeMin=D'2000.01.01 00:00:00',
   datetime fOrderCloseTimeMax=D'2999.12.31 23:59:59',
   ) export
 {
  int fLtNo=-1;
  datetime fOrderCloseTime=StringToTime("2000.1.1");
  for(int i=0;i<OrdersHistoryTotal();i++)
   { if( OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)  && 
         omsIsMyOrder(fSymbol,fOdType,fMagicNumber) && 
         StringFind(OrderComment(),fCommentPrefix)>=0 &&
         OrderCloseTime() > fOrderCloseTime && 
         OrderOpenTime()  >= fOrderOpenTimeMin &&
         OrderOpenTime()  <= fOrderOpenTimeMax &&
         OrderCloseTime() >= fOrderCloseTimeMin &&
         OrderCloseTime() <= fOrderCloseTimeMax 
         
         ) 
      { 
       fOrderCloseTime=OrderCloseTime(); 
       fLtNo=OrderTicket();
      }
   } //EOF for 
   return(fLtNo);
 }