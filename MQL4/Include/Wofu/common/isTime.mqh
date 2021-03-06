#include <Wofu\\enums\\TimeWhere.mqh>
#include <Wofu\\common\\logger.mqh>
#include <Wofu\\common\\stringExtractAlpha.mqh>


//檢查 現在時間是否在 給定的區間內
bool isTime
(
   string fDoWkNo,          //符合的星期 (1234560)
   string fDoFrToTime,      //判斷現在是否在這個時間內 格式 HH1:MM1-HH2:MM2
   int    fNowTimeQuick=30, //把現在的時間調快，等同延後下單
   ENUM_TIME_WHERE NowTimeMode=TIME_LOCAL    //0:
) export
{
   datetime fNowTime=(NowTimeMode==TIME_LOCAL)?TimeLocal():TimeCurrent();
   fNowTime=fNowTime+fNowTimeQuick;
   
   string   fNowWkNo=IntegerToString(TimeDayOfWeek(fNowTime)); 
   if(StringFind(fDoWkNo,fNowWkNo,0)<0 )return(false);
   
   //int fNow=TimeHour(fNowTime)*60*60+TimeMinute(fNowTime)*60+TimeSeconds(fNowTime);
      
   fDoFrToTime=stringExtractAlpha(fDoFrToTime,"1:-");
   string DoFrToTime[],DoFrTime[],DoToTime[];
   StringSplit(fDoFrToTime,'-',DoFrToTime);
   if(ArraySize(DoFrToTime)!=2){ logger(LOG_ERROR,__FUNCTION__+" DoFrToTime ERROR!!");return(false);}
   StringSplit(DoFrToTime[0],':',DoFrTime);
   if(ArraySize(DoFrTime)!=2){ logger(LOG_ERROR,__FUNCTION__+" DoFrTime ERROR!!");return(false);}
   StringSplit(DoFrToTime[1],':',DoToTime);
   if(ArraySize(DoToTime)!=2){ logger(LOG_ERROR,__FUNCTION__+" DoToTime ERROR!!");return(false);}
   
   return( isTime( (int)DoFrTime[0], (int)DoFrTime[1], (int)DoToTime[0], (int)DoToTime[1], fNowTime, fDoWkNo ) );
}


bool isTime
(
   int fFrHr,
   int fFrMin,
   int fToHr,
   int fToMin,
   datetime fNowTime,       //現在時間
   string fWkNo="1234560"   //符合的星期 (1234560)
) export
{
   string   fNowWkNo=IntegerToString(TimeDayOfWeek(fNowTime)); 
   if(StringFind(fWkNo,fNowWkNo,0)<0 )return(false);
   
   int fNow=TimeHour(fNowTime)*60*60+TimeMinute(fNowTime)*60+TimeSeconds(fNowTime);
   
   int DoFr=fFrHr*60*60+fFrMin*60;
   int DoTo=fToHr*60*60+fToMin*60+59;
   if( DoFr >=24*60*60 ||  DoTo>=24*60*60 )return(false);
   // 1:30-19:59
   if( DoFr <= DoTo && fNow >= DoFr && fNow <= DoTo )return(true);
   // 19:59-1:30
   if( DoFr >  DoTo && ( (fNow >= DoFr && fNow < 24*60*60) || ( fNow>=0 && fNow <= DoTo ) ) )return(true);
   return(false);

}

#ifdef OLD_ALIAS
   bool IsTime(string fDoWkNo,string fDoFrToTime,int fNowTimeQuick=30,ENUM_TIME_WHERE NowTimeMode=0) export
   {  return( isTime( fDoWkNo, fDoFrToTime, fNowTimeQuick, NowTimeMode) ); }
#endif 


