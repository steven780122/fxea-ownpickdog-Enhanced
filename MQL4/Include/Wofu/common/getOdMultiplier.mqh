int getOdMultiplier(int fOdType)
 {
  if( fOdType==ORDER_TYPE_BUY  || fOdType==ORDER_TYPE_BUY_STOP  || fOdType==ORDER_TYPE_BUY_LIMIT  )return(1);
  if( fOdType==ORDER_TYPE_SELL || fOdType==ORDER_TYPE_SELL_STOP || fOdType==ORDER_TYPE_SELL_LIMIT )return(-1);
  return(0);
 }
 
 
#ifdef OLD_ALIAS
   int GetMultiplier(int fOdType)
   {  return(getOdMultiplier(fOdType));}
#endif 
