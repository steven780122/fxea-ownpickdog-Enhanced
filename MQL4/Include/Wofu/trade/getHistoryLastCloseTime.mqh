//#include <Wofu\\trade\\getHistoryLastOrderType.mqh>
#include <Wofu\\trade\\getHistoryLastTicketNo.mqh>
datetime getHistoryLastCloseTime(string fSymbol,ENUM_MIXED_ORDER_TYPE fOdType,int fMagicNumber) export
{
   
   int fTkNo=getHistoryLastTicketNo( fSymbol, fOdType, fMagicNumber);
   if( fTkNo>=0 && OrderSelect(fTkNo,SELECT_BY_TICKET,MODE_HISTORY) ){return(OrderCloseTime());}
   else { return(D'2015.01.01 00:00'); }


}