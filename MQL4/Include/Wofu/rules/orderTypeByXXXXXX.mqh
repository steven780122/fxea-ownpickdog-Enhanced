/*
#include <Wofu\\rules\\orderTypeByXXXXXX.mqh>
#include <Wofu\\userparms\\sample\\orderTypeByXXXXXX.mqh>

double  iXXXXXX(
   string       symbol,           // symbol
   int          timeframe,        // timeframe
   int          period,           // period
   int          applied_price,    // applied price
   int          shift             // shift
   );

由最靠近的K棒(fKFr)開始往前找到前K根(fKTo) ,0:當根,1:前1根

fEntryType==0
   當 自訂BUY基準值 > 自訂SELL基準值
      BUY :RSI> 自訂BUY基準值 
      SELL:RSI< 自訂SELL基準值
      落在自訂BUY基準值~自訂SELL基準值則無方向

   當 自訂BUY基準值 <= 自訂SELL基準值
      BUY :RSI> 自訂SELL基準值 或 
      SELL:RSI< 自訂BUY基準值 或
      落在 自訂BUY基準值~自訂SELL基準值則
      找到是從哪一邊進入 區間(自訂BUY基準值~自訂SELL基準值)
         BUY :由下而上穿過 自訂BUY 基準值
         SELL:由上而下穿過 自訂SELL基準值
   fEntryWay不影響結果

fEntryType==1
   當fEntryWay==往上進BUY(0)
      BUY :由下而上穿過 自訂BUY 基準值
      SELL:由上而下穿過 自訂SELL基準值
   當fEntryWay==往下進BUY(1)
      BUY :由上而下穿過 自訂BUY 基準值
      SELL:由下而上穿過 自訂SELL基準值

*/
 
#include <Wofu\\enums\\MarketOrderType.mqh>
#include <Wofu\\enums\\EntryWay.mqh>
#include <Wofu\\Common\\getOppMaketOrderType.mqh>
#include <Wofu\\Common\\logger.mqh>

MARKET_ORDER_TYPE orderTypeByXXXXXX
(
   //--[ 內建指標參數 ]----------------------
   string fSymbol,
   ENUM_TIMEFRAMES fTf,
   int fPeriod,
   ENUM_APPLIED_PRICE fPrice,
   //--[ 自有指標參數 ]----------------------
   int fEntryType,            //採用模式
   ENUM_ENTRY_WAY fEntryWay,  //進場模式-進入方向(SELL單與BUY相反)
   int fKFr,                  //採用K棒數-起
   int fKTo,                  //採用K棒數-迄
   bool fPreK,                //與前K的值比對
   bool fOdOpp,               //結果反向
   bool fLogger,              //是否寫出紀錄
   //--[ 自有參數-特殊 ]----------------------
   double fBaseBB,            //BUY 基準值 下限
   double fBaseBE,            //BUY 基準值 上限(fEntryType=0才會用到)
   double fBaseSB,            //SELL基準值 上限
   double fBaseSE,            //SELL基準值 下限(fEntryType=0才會用到)
)
{
   MARKET_ORDER_TYPE fOdType=OD_NA;
   double FLine0=0,FLine1=0;
   int    SymDigits=(int)SymbolInfoInteger(fSymbol,SYMBOL_DIGITS);
   //濾網模式
   if( fEntryType==0 )fKTo=fKFr;

   
   for(int i=fKFr;i<=fKTo;i++)
   {
      #ifdef __MQL4__
         FLine0 = iRSI(fSymbol,fTf,fPeriod,fPrice,i);
         FLine1 = iRSI(fSymbol,fTf,fPeriod,fPrice,i+1);
      #endif 
      #ifdef __MQL5__
         FLine0 = iRSIMQL4(fSymbol,fTf,fPeriod,fPrice,i);
         FLine1 = iRSIMQL4(fSymbol,fTf,fPeriod,fPrice,i+1);
      #endif 

      if( fEntryType==0 )  
      {
      

      }
      else 
      if( fEntryType==1 )  
      {
      }
      else
         return(OD_ERROR);
      
      if( fOdType==OD_BUY || fOdType==OD_SELL ) break;
   } //EOF for
   

   if(fLogger)logger(LOG_INFO,__FUNCTION__+": 判斷結果="+EnumToString(fOdType)+",WPR[0]="+DoubleToStr(FLine0,SymDigits)+",WPR[1]="+DoubleToStr(FLine1,SymDigits));
   if( fOdOpp && fOdType>=0 )return(getOppMaketOrderType(fOdType));
   return(fOdType);
    
}
