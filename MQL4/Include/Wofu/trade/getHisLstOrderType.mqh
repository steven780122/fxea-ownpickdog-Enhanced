//#include <Wofu\\trade\\getHisLstOrderType.mqh>
#include <Wofu\\trade\\getHisLstTicketNo.mqh>
int getHisLstOrderType(string fSymbol,MIXED_ORDER_TYPE fOdType,int fMagicNumber) export
{
   
   int fTkNo=getHisLstTicketNo( fSymbol, fOdType, fMagicNumber);
   if( fTkNo>=0 && OrderSelect(fTkNo,SELECT_BY_TICKET,MODE_HISTORY) ){return(OrderType());}
   else { return(-1); }


}