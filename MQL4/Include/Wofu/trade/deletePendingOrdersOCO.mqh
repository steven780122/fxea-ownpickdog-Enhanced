#include <Wofu\\trade\\getOrdersCnt.mqh>
#include <Wofu\\trade\\deleteAllPendingOrders.mqh>


bool deletePendingOrdersOCO
(
   string fSymbol,
   int fMagicNumber
)
{

      int outBuyCnts=0,outSellCnts=0,outBuyStopLimitCnts=0,outSellStopLimitCnts=0;

      getOrdersCnt(fSymbol,fMagicNumber,outBuyCnts,outSellCnts,outBuyStopLimitCnts,outSellStopLimitCnts);
      
      if( outBuyCnts>0 && outSellStopLimitCnts>0 )
      {
         deleteAllPendingOrders(fSymbol,MIXED_ODTYPE_SELL_STOPnLIMIT,fMagicNumber);
         return(true);
      }
      if( outSellCnts>0 && outBuyStopLimitCnts>0 )
      {
         deleteAllPendingOrders(fSymbol,MIXED_ODTYPE_BUY_STOPnLIMIT,fMagicNumber);         
         return(true);
      }
   return(false);

}

