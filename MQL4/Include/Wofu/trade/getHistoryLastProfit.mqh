#include <Wofu\\trade\\getHistoryLastTicketNo.mqh>
double getHistoryLastProfit
(string fSymbol,ENUM_MIXED_ORDER_TYPE fOdType,int fMagicNumber,datetime fOrderCloseTimeMax=D'2999.12.31' )
{
   int HistoryLastTicketNo=getHistoryLastTicketNo(fSymbol,fOdType,fMagicNumber,fOrderCloseTimeMax);
   if( OrderSelect(HistoryLastTicketNo,SELECT_BY_TICKET,MODE_HISTORY) )
      return( OrderProfit() + OrderCommission() + OrderSwap() );
   
   
   return(0);
}