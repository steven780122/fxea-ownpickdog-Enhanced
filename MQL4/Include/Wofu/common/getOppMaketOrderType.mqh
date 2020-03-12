#include <Wofu\\enums\\MarketOrderType.mqh>

ENUM_MARKET_ORDER_TYPE getOppMaketOrderType(ENUM_MARKET_ORDER_TYPE fOdType) export
{
   switch(fOdType)
   {
      case OD_BUY:
         return(OD_SELL);
      case OD_SELL:
         return(OD_BUY);
         /*
      case OD_BUY_STOP:
         return(OD_SELL_STOP);
      case OD_SELL_STOP:
         return(OD_BUY_STOP);
      case OD_BUY_LIMIT:
         return(OD_SELL_LIMIT);
      case OD_SELL_LIMIT:
         return(OD_BUY_LIMIT);
         */
      default:
         return(fOdType);
   }      


}