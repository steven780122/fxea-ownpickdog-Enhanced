//依照訂單類型回傳目前在倉獲利總額
#include <Wofu\\trade\\omsIsMyOrder.mqh>
double getOrdersTotalProfit
(string fSymbol,ENUM_MIXED_ORDER_TYPE fOdType,int fMagicNumber) export
{
  double fGetOrderProfit=0; 
  for(int i=0;i<OrdersTotal();i++)
   { 
    if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && omsIsMyOrder(fSymbol,fOdType,fMagicNumber) ) 
     fGetOrderProfit+=OrderProfit() + OrderCommission() + OrderSwap();
   } //End of for
  return(fGetOrderProfit);
}


#ifdef OLD_ALIAS
   double GetOrderProfit(string fSymbol,MIXED_ORDER_TYPE fOdType,int fMagicNumber) export
   {  return(getOrdersTotalProfit(fSymbol, fOdType, fMagicNumber)); }
#endif 