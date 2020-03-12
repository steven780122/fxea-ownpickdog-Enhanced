#include <Wofu\\common\\logTradeError.mqh>

void modifyOrder
(  
   int    fOrderTicket,
   double fOpenPrice=0, 
   double fTakeProfitPrice = 0, 
   double fStopLossPrice = 0
)
{
   if( OrderSelect(fOrderTicket,SELECT_BY_TICKET,MODE_TRADES) )
      if( OrderOpenPrice()!=fOpenPrice || OrderTakeProfit()!=fTakeProfitPrice || OrderStopLoss()!=fStopLossPrice )
         if(!OrderModify(fOrderTicket,fOpenPrice,fStopLossPrice,fTakeProfitPrice,0))
            logTradeError(__FUNCTION__,fOrderTicket,GetLastError(),"OpenPrice="+(string)fOpenPrice+",TP="+(string)fTakeProfitPrice+",SL="+(string)fStopLossPrice);

}