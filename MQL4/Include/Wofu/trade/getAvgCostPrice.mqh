#include <Wofu\\enums\\MixedOrderType.mqh>

#include <Wofu\\trade\\isMyOrder.mqh>

double getAvgCostPrice
(
   string fSymbol,
   ENUM_MIXED_ORDER_TYPE fOdType,  
   // MIXED_ORDER_TYPE fOdType, // Vol哥ori
   int fMagicNumber, 
   int fWhichPool=MODE_TRADES
) export
{

   int fOrderTotalCnt=(fWhichPool==MODE_TRADES)?OrdersTotal():OrdersHistoryTotal();
   //double SymPoint=SymbolInfoDouble(fSymbol,SYMBOL_POINT);
   int    SymDigits=(int)SymbolInfoInteger(fSymbol,SYMBOL_DIGITS);
   
   double fGetOrderAmt=0,fGetOrderLots=0;

   for(int i=0;i<fOrderTotalCnt;i++)
   { 
    if( OrderSelect(i,SELECT_BY_POS,fWhichPool) && isMyOrder(fSymbol,fOdType,fMagicNumber)   )
     {
      fGetOrderAmt+=OrderOpenPrice()*OrderLots();
      fGetOrderLots+=OrderLots();
     }  
   } //End of for
   if(fGetOrderLots!=0){return(NormalizeDouble(fGetOrderAmt/fGetOrderLots,SymDigits));}
   else{ return(0.0);}

}