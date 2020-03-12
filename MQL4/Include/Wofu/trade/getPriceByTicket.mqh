//#include <Wofu\\trade\\getOpPriceByTicket.mqh>
#include <Wofu\\enums\\OrderPrice.mqh>
double getPriceByTicket
(
   int fTicket,
   ENUM_ORDER_PRICE fPriceType=OD_PRICE_OPEN,
   int fWhichPool=MODE_TRADES,
)
{
   if( fWhichPool!=MODE_TRADES && fWhichPool!=MODE_HISTORY )return(-1);
   if( !OrderSelect(fTicket,SELECT_BY_TICKET,fWhichPool)  )return(-1);
   
   double SymPoint=SymbolInfoDouble(OrderSymbol(),SYMBOL_POINT);
   int    SymDigits=(int)SymbolInfoInteger(OrderSymbol(),SYMBOL_DIGITS);
   
   switch(fPriceType)
   {
      case OD_PRICE_OPEN :
         return(NormalizeDouble(OrderOpenPrice() ,SymDigits));
      case OD_PRICE_CLOSE :
         return(NormalizeDouble(OrderClosePrice(),SymDigits));
      case OD_PRICE_TP :
         return(NormalizeDouble(OrderTakeProfit(),SymDigits));
      case OD_PRICE_SL :
         return(NormalizeDouble(OrderStopLoss()  ,SymDigits));
      default:
         return(-1);
   
   }
}