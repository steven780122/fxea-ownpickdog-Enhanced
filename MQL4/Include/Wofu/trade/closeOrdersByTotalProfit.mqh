#include <Wofu\\trade\\getOrdersTotalProfit.mqh>
#include <Wofu\\trade\\closeAllOrders.mqh>

bool closeOrdersByTotalProfit
(
   string fSymbol,
   MIXED_ORDER_TYPE fOdType,
   int fMagicNumber,
   int fSlPage,
   double fCloseAmt,
) export
{
   if( fCloseAmt==0 )return(false);
   double RateAmt=getOrdersTotalProfit(fSymbol,fOdType,fMagicNumber);
   if( fCloseAmt<0 && RateAmt>0 )return(false);
   if( fCloseAmt>0 && RateAmt<0 )return(false);
   
   if( MathAbs(RateAmt) >= MathAbs(fCloseAmt) )
   {
      closeAllOrders(fSymbol,fOdType,fMagicNumber,fSlPage);
      return(true);
   }
        
  return(false);
}