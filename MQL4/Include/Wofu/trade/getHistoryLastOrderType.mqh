//#include <Wofu\\trade\\getHistoryLastOrderType.mqh>
#include <Wofu\\trade\\getHistoryLastTicketNo.mqh>
int getHistoryLastOrderType(string fSymbol,ENUM_MIXED_ORDER_TYPE fOdType,int fMagicNumber) export
{
   
   int fTkNo=getHistoryLastTicketNo( fSymbol, fOdType, fMagicNumber);
   if( fTkNo>=0 && OrderSelect(fTkNo,SELECT_BY_TICKET,MODE_HISTORY) ){return(OrderType());}
   else { return(-1); }


}