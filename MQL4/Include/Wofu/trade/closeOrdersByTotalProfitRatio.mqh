#include <Wofu\\trade\\getOrdersTotalProfitRatio.mqh>
#include <Wofu\\trade\\closeAllOrders.mqh>
#include <Wofu\\enums\\AccountMoneyType.mqh>
bool closeOrdersByTotalProfitRatio
(
   string fSymbol,
   MIXED_ORDER_TYPE fOdType,
   int fMagicNumber,
   int fSlPage,
   double fCloseRate,
   ENUM_ACCOUNT_MONEY_TYPE mode=ACCOUNT_MONEY_TYPE_BALANCE,  //0=AccountBalance,1=AccountEquity
) export
{
   if( fCloseRate==0 )return(false);
   double RateNow=getOrdersTotalProfitRatio(fSymbol,fOdType,fMagicNumber);
   if( fCloseRate<0 && RateNow>0 )return(false);
   if( fCloseRate>0 && RateNow<0 )return(false);
   
   if( MathAbs(RateNow) >= MathAbs(fCloseRate) )
   {
      closeAllOrders(fSymbol,fOdType,fMagicNumber,fSlPage);
      return(true);
   }
        
  return(false);
}