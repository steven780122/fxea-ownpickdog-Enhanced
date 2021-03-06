#include <Wofu\\enums\\NextTimeMode.mqh>
#include <Wofu\\enums\\TimeWhere.mqh>
datetime getNextTime
(
   ENUM_NEXT_TIME_MODE fMode,
   datetime fTime,
   ENUM_TIME_WHERE fTimeWhere=TIME_LOCAL
)
{
   int TimeInteval=0;
   datetime fBaseTime;
   
   if(fTimeWhere==TIME_SERVER)
      fBaseTime=TimeCurrent();
   else
      fBaseTime=TimeLocal();
            
        if(fMode==NEXT_TIME_MODE_DAILY )TimeInteval=86400;
   else if(fMode==NEXT_TIME_MODE_WEEKLY)TimeInteval=604800;
   else if(fMode==NEXT_TIME_MODE_MONTHLY)
   {
   
      MqlDateTime fTimeStruct;
      TimeToStruct(fTime,fTimeStruct);
      while( fTime < fBaseTime )
      {
         if(fTimeStruct.mon==12)
            {fTimeStruct.mon=1;fTimeStruct.year++;}
         else
            {fTimeStruct.mon++;}
         fTime=StructToTime(fTimeStruct);
         
      }
   }

   if(TimeInteval > 0 )
      while( fTime < fBaseTime )
         fTime=fTime+TimeInteval;
   
   
   return(fTime);


}