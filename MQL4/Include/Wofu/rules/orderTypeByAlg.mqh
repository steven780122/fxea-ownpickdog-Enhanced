/*
#include <Wofu\\rules\\orderTypeByMA.mqh>
#include <Wofu\\userparms\\sample\\orderTypeByMA.mqh>

double  iAlligator(
   string       symbol,            // symbol
   int          timeframe,         // timeframe
   int          jaw_period,        // Jaw line averaging period
   int          jaw_shift,         // Jaw line shift
   int          teeth_period,      // Teeth line averaging period
   int          teeth_shift,       // Teeth line shift
   int          lips_period,       // Lips line averaging period
   int          lips_shift,        // Lips line shift
   int          ma_method,         // averaging method
   int          applied_price,     // applied price
   int          mode,              // line index
   int          shift              // shift
   );


藍色顎線(jaw)
紅色齒線(teeth)
綠色唇線(lip)


由最靠近的K棒(fKFr)開始往前找到前K根(fKTo) ,0:當根,1:前1根

fEntryType==0
   藍色顎線(jaw)
   紅色齒線(teeth)
   綠色唇線(lip)

   BUY :綠>紅>藍 
   SELL:綠<紅<藍
   
   fEntryWay不影響結果

fEntryType==1
   未使用

*/
 
#include <Wofu\\enums\\EntryWay.mqh>
#include <Wofu\\Common\\getOppOrderType.mqh>
#include <Wofu\\Common\\logger.mqh>
#include <Wofu\\rules\\rulesParmCommon.mqh>
struct rulesParmAlg
{
   string             symbol;       
   ENUM_TIMEFRAMES    timeframe;    
   int                jawPeriod;   
   int                jawShift;    
   int                teethPeriod; 
   int                teethShift;  
   int                lipsPeriod;  
   int                lipsShift;   
   ENUM_MA_METHOD     maMethod;    
   ENUM_APPLIED_PRICE appliedPrice;
};

int orderTypeByAlg
(
   rulesParmAlg&    rps,
   rulesParmCommon& rpc
)
{
   int resultOrderType=-1;
   double jaw0=0,teeth0=0,lips0 =0,jaw1=0,teeth1=0,lips1=0;
   int    SymDigits=(int)SymbolInfoInteger(rps.symbol,SYMBOL_DIGITS);
   //濾網模式
   if( rpc.entryType==0 )rpc.kBarTo=rpc.kBarFr;

   
   for(int i=rpc.kBarFr;i<=rpc.kBarTo;i++)
   {
   #ifdef __MQL4__
     jaw0   = iAlligator(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORJAW  ,i);   //Gator Jaw (blue) 
     teeth0 = iAlligator(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORTEETH,i);   //Gator Teeth (red)  
     lips0  = iAlligator(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORLIPS ,i);   //Gator Lips (green)
   
     jaw1   = iAlligator(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORJAW  ,i+1); //Gator Jaw (blue) 
     teeth1 = iAlligator(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORTEETH,i+1); //Gator Teeth (red)  
     lips1  = iAlligator(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORLIPS ,i+1); //Gator Lips (green)
   #endif 
   #ifdef __MQL5__
     jaw0   = iAlligatorMQL4(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORJAW  ,i);   //Gator Jaw (blue) 
     teeth0 = iAlligatorMQL4(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORTEETH,i);   //Gator Teeth (red)  
     lips0  = iAlligatorMQL4(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORLIPS ,i);   //Gator Lips (green)
                        
     jaw1   = iAlligatorMQL4(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORJAW  ,i+1); //Gator Jaw (blue) 
     teeth1 = iAlligatorMQL4(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORTEETH,i+1); //Gator Teeth (red)  
     lips1  = iAlligatorMQL4(rps.symbol,rps.timeframe,rps.jawPeriod,rps.jawShift,rps.teethPeriod,rps.teethShift,rps.lipsPeriod,rps.lipsShift,rps.maMethod,rps.appliedPrice,MODE_GATORLIPS ,i+1); //Gator Lips (green)
   #endif 

      if( rpc.entryType==0 )  
      {
              if( lips0>teeth0 && teeth0>jaw0 )resultOrderType=ORDER_TYPE_BUY;  //綠>紅>藍
         else if( lips0<teeth0 && teeth0<jaw0 )resultOrderType=ORDER_TYPE_SELL; //綠<紅<藍
         else resultOrderType=-1;      

      }
      else 
      if( rpc.entryType==1 )  
      {
              if( lips0>teeth0 && teeth0>jaw0 )resultOrderType=ORDER_TYPE_BUY;  //綠>紅>藍
         else if( lips0<teeth0 && teeth0<jaw0 )resultOrderType=ORDER_TYPE_SELL; //綠<紅<藍
         else resultOrderType=-1;
      }
      else
         return(-999);
      
      if( resultOrderType==ORDER_TYPE_BUY || resultOrderType==ORDER_TYPE_SELL ) break;
   } //EOF for
   

   if( rpc.doLogger )logger(LOG_INFO,__FUNCTION__+": 判斷結果="+( (resultOrderType>=0)?EnumToString((ENUM_ORDER_TYPE)resultOrderType):(string)resultOrderType )+",lips="+DoubleToStr(lips0,SymDigits)+",teeth0="+DoubleToStr(teeth0,SymDigits)+",jaw0="+DoubleToStr(jaw0,SymDigits));
   if( rpc.resultOpp && resultOrderType>=0 )return(getOppOrderType((ENUM_ORDER_TYPE)resultOrderType));
   return(resultOrderType);
    
}
