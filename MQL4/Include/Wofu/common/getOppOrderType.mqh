enum ENUM_OPP_ORDERTYPE_MODE
{
   OPP_ORDERTYPE_MODE_NORMAL=1,
   OPP_ORDERTYPE_MODE_STOP=2,
   OPP_ORDERTYPE_MODE_LIMIT=3,
};
ENUM_ORDER_TYPE getOppOrderType(ENUM_ORDER_TYPE fOdType,ENUM_OPP_ORDERTYPE_MODE fMode=OPP_ORDERTYPE_MODE_NORMAL) export
{
   if(fMode==OPP_ORDERTYPE_MODE_NORMAL)
   {
      switch(fOdType)
      {
         case ORDER_TYPE_BUY:
            return(ORDER_TYPE_SELL);
         case ORDER_TYPE_SELL:
            return(ORDER_TYPE_BUY);
         case ORDER_TYPE_BUY_STOP:
            return(ORDER_TYPE_SELL_STOP);
         case ORDER_TYPE_SELL_STOP:
            return(ORDER_TYPE_BUY_STOP);
         case ORDER_TYPE_BUY_LIMIT:
            return(ORDER_TYPE_SELL_LIMIT);
         case ORDER_TYPE_SELL_LIMIT:
            return(ORDER_TYPE_BUY_LIMIT);
         default:
            return(fOdType);
      }
   }
   else
   if(fMode==OPP_ORDERTYPE_MODE_STOP)
   {
      switch(fOdType)
      {
         case ORDER_TYPE_BUY:
            return(ORDER_TYPE_SELL_STOP);
         case ORDER_TYPE_SELL:
            return(ORDER_TYPE_BUY_STOP);
         default:
            return(fOdType);
      }
   }
   else
   if(fMode==OPP_ORDERTYPE_MODE_LIMIT)
   {
      switch(fOdType)
      {
         case ORDER_TYPE_BUY:
            return(ORDER_TYPE_SELL_LIMIT);
         case ORDER_TYPE_SELL:
            return(ORDER_TYPE_BUY_LIMIT);
         default:
            return(fOdType);
      }
   }
   
   return(fOdType);
         
}
