//偵測是否有新的 K 棒產生

bool isNewBar(string fSymbol,ENUM_TIMEFRAMES fTf,bool fFirstRun)
  {
//--- memorize the time of opening of the last bar in the static variable
   static datetime last_time=0;
//--- current time
   datetime lastbar_time=(datetime)SeriesInfoInteger(fSymbol,fTf,SERIES_LASTBAR_DATE);

//--- if it is the first call of the function
   if(last_time==0)
     {
      //--- set the time and exit
      last_time=lastbar_time;
      return(fFirstRun);
     }

//--- if the time differs
   if(last_time!=lastbar_time)
     {
      //--- memorize the time and return true
      last_time=lastbar_time;
      return(true);
     }
//--- if we passed to this line, then the bar is not new; return false
   return(false);
  }


#ifdef TRASHCAN
/* Not working on mql5

long BarsPre=0;
bool ChkNewBar() export
{
   RefreshRates();
   bool NewBar=(BarsPre!=Bars);
   BarsPre=Bars;
   return(NewBar);
}
*/

/*
bool isNewBar() {
   static datetime lastBarOpenTime;
   //if( UninitializeReason()==REASON_PARAMETERS )lastBarOpenTime=0;
   MqlRates BarData[1]; 
   CopyRates(_Symbol, Period(), 0, 1, BarData);

   datetime currentBarOpenTime = BarData[0].time;
   
   if(lastBarOpenTime != currentBarOpenTime) {
     lastBarOpenTime = currentBarOpenTime;
     return true;
   } else {
     return false;
   }
}
*/

#endif