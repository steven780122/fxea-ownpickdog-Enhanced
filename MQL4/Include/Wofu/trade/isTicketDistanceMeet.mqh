bool isTicketDistanceMeet(ENUM_ORDER_TYPE orderType,int ticket,int distancePips)
{
   bool returnValue=false;
   if( !OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES) )return(false);
   if( distancePips==0 )return(true);
   double nowDistance=0;
   
   
   if( orderType== ORDER_TYPE_BUY )
   {
      nowDistance=Ask-OrderOpenPrice();
      if( distancePips>0 && Ask>OrderOpenPrice() && MathAbs(nowDistance)>MathAbs(distancePips)*_Point )returnValue=true;
      else
      if( distancePips<0 && Ask<OrderOpenPrice() && MathAbs(nowDistance)>MathAbs(distancePips)*_Point )returnValue=true;
   }
   else
   if( orderType== ORDER_TYPE_SELL )
   {
      nowDistance=Bid-OrderOpenPrice();
      if( distancePips>0 && Bid<OrderOpenPrice() && MathAbs(nowDistance)>MathAbs(distancePips)*_Point )returnValue=true;
      else
      if( distancePips<0 && Bid>OrderOpenPrice() && MathAbs(nowDistance)>MathAbs(distancePips)*_Point )returnValue=true;
      
   }
   logger(LOG_INFO,"距離條件："+EnumToString(orderType)+(returnValue?"符合":"不符合")+",設定距離="+(string)distancePips+"pips,距離單號"+(string)ticket+"的距離="+(string)DoubleToString(nowDistance/_Point,0)+"pips");
   return(returnValue);
}