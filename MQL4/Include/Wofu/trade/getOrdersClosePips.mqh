
#include <Wofu\\trade\\getOrdersTotalProfitRatio.mqh>
#include <Wofu\\trade\\closeAllOrders.mqh>

int getOrdersClosePips
(
   int fTicketNo,
) export
{
   if( !OrderSelect(fTicketNo,SELECT_BY_TICKET) ) return(-1);
   if( OrderType() == ORDER_TYPE_BUY  )
      return( (int)(( SymbolInfoDouble(_Symbol,SYMBOL_BID)-OrderOpenPrice() )/_Point) );
   else
   if( OrderType() == ORDER_TYPE_SELL )
      return( (int)(( OrderOpenPrice()-SymbolInfoDouble(_Symbol,SYMBOL_ASK) )/_Point) );
   return(-1);




}