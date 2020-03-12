double getTradePriceNow(string fSymbol,ENUM_ORDER_TYPE OdType)
{
   #ifdef __MQL4__
      RefreshRates();
   #endif 
   if(OdType==ORDER_TYPE_BUY ||OdType==ORDER_TYPE_BUY_LIMIT || OdType==ORDER_TYPE_BUY_STOP )return(SymbolInfoDouble(fSymbol, SYMBOL_ASK));
   else
   if(OdType==ORDER_TYPE_SELL||OdType==ORDER_TYPE_SELL_LIMIT|| OdType==ORDER_TYPE_SELL_STOP)return(SymbolInfoDouble(fSymbol, SYMBOL_BID));
   else
      return(0);
}
