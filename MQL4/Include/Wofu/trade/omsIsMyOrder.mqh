/*
依照
OrderSymbol
OrderType (999:不管訂單型態,99:BS,98:全部預掛,97:全部LIMIT,96:全部STOP )
   ORDER_TYPE_BUY       0 Buy operation
   ORDER_TYPE_SELL      1 Sell operation
   ORDER_TYPE_BUY_LIMIT  2 Buy limit pending order
   ORDER_TYPE_SELL_LIMIT 3 Sell limit pending order
   ORDER_TYPE_BUY_STOP   4 Buy stop pending order
   ORDER_TYPE_SELL_STOP  5 Sell stop pending order
OrderMagicNumber
判斷是否為是自己的訂單


int MAGIC_NUMBER=0;
void SetMagicNumber(int magicno)
{ MAGIC_NUMBER=magicno; }
*/
#include <Wofu\\enums\\MixedOrderType.mqh>

bool omsIsMyOrder(string fSymbol,ENUM_MIXED_ORDER_TYPE fOdType,int fMagicNumber)
{
   bool fChkMagicNumber=(fMagicNumber!=-1 )?( OrderMagicNumber()==fMagicNumber ):true;
   bool fChkSymbol     =(fSymbol!="ALL"   )?( OrderSymbol()     ==fSymbol      ):true;
   bool fChkOdType=false;
   switch(fOdType)
   {
      case MIXED_ODTYPE_ALL:
         fChkOdType=true;
         break;
      case MIXED_ODTYPE_BUY_SELL:
         if(OrderType()==ORDER_TYPE_BUY||OrderType()==ORDER_TYPE_SELL)fChkOdType=true;
         break;
      case MIXED_ODTYPE_STOP_LIMIT:
         if(OrderType()==ORDER_TYPE_BUY_LIMIT||OrderType()==ORDER_TYPE_SELL_LIMIT||OrderType()==ORDER_TYPE_BUY_STOP||OrderType()==ORDER_TYPE_SELL_STOP)fChkOdType=true;
         break;
      case MIXED_ODTYPE_LIMIT:
         if(OrderType()==ORDER_TYPE_BUY_LIMIT||OrderType()==ORDER_TYPE_SELL_LIMIT)fChkOdType=true;
         break;
      case MIXED_ODTYPE_STOP:
         if(OrderType()==ORDER_TYPE_BUY_STOP||OrderType()==ORDER_TYPE_SELL_STOP)fChkOdType=true;
         break;
      case MIXED_ODTYPE_BUY_STOPnLIMIT:
         if(OrderType()==ORDER_TYPE_BUY_LIMIT||OrderType()==ORDER_TYPE_BUY_STOP)fChkOdType=true;
         break;
      case MIXED_ODTYPE_SELL_STOPnLIMIT:
         if(OrderType()==ORDER_TYPE_SELL_LIMIT||OrderType()==ORDER_TYPE_SELL_STOP)fChkOdType=true;
         break;
      case MIXED_ODTYPE_BUY_ALL:
         if(OrderType()==ORDER_TYPE_BUY ||OrderType()==ORDER_TYPE_BUY_LIMIT ||OrderType()==ORDER_TYPE_BUY_STOP )fChkOdType=true;
         break;
      case MIXED_ODTYPE_SELL_ALL:
         if(OrderType()==ORDER_TYPE_SELL||OrderType()==ORDER_TYPE_SELL_LIMIT||OrderType()==ORDER_TYPE_SELL_STOP)fChkOdType=true;
         break;
      default:
         if( OrderType()==fOdType )fChkOdType=true;
         break;
   }

   if( fChkSymbol && fChkOdType && fChkMagicNumber )return(true);
   return(false);
}   


#ifdef OLD_ALIAS
   bool IsMyOrder(string fSymbol,int fOdType,int fMagicNumber)
   {  return omsIsMyOrder(fSymbol,(MIXED_ORDER_TYPE)fOdType,fMagicNumber); }
#endif