/*
#include <Wofu\\rules\\orderTypeByBands.mqh>
#include <Wofu\\userparms\\sample\\orderTypeByBands.mqh>
double  iBands( 
   string       symbol,           // symbol --> fSymbol
   int          timeframe,        // timeframe --> fTf
   int          period,           // averaging period --> fPeriod
   double       deviation,        // standard deviations --> fDeviation
   int          bands_shift,      // bands shift --> fBandsShift
   int          applied_price,    // applied price 
   int          mode,             // line index --> (0 - MODE_MAIN, 1 - MODE_UPPER, 2 - MODE_LOWER)
   int          shift             // shift 
   
   
由最靠近的K棒(fKFr)開始往前找到前K根(fKTo) ,0:當根,1:前1根
fEntryType==1 
   當fEntryWay==往上進BUY(0)
      BUY : 當收盤價 由下向上 穿越下軌
      SELL: 當收盤價 由上向下 穿越上軌
   當fEntryWay==往下進BUY(1)
      BUY : 當收盤價 由上向下 穿越下軌
      SELL: 當收盤價 由下向上 穿越上軌

fEntryType==2
   當fEntryWay==往上進BUY(0)
      BUY : 當收盤價 由下向上 穿越中軌
      SELL: 當收盤價 由上向下 穿越中軌
   當fEntryWay==往下進BUY(1)
      BUY : 當收盤價 由上向下 穿越中軌
      SELL: 當收盤價 由下向上 穿越中軌
*/

#include <Wofu\\enums\\MarketOrderType.mqh>
#include <Wofu\\enums\\EntryWay.mqh>
#include <Wofu\\Common\\getOppMaketOrderType.mqh>
#include <Wofu\\Common\\logger.mqh>

MARKET_ORDER_TYPE orderTypeByBands
(
   //--[ 內建指標參數 ]----------------------
   string fSymbol,
   ENUM_TIMEFRAMES fTf,
   int fPeriod,
   double fDeviation,
   int fBandsShift,
   ENUM_APPLIED_PRICE fPrice,
   //--[ 自有參數-常用 ]----------------------
   int fEntryType,            //採用模式
   ENUM_ENTRY_WAY fEntryWay,  //進場模式-進入方向(SELL單與BUY相反)
   int fKFr,                  //採用K棒數-起
   int fKTo,                  //採用K棒數-迄
   bool fPreK,                //與前K的值比對 //尚無使用
   bool fOdOpp,               //結果反向
   bool fLogger,              //是否寫出紀錄
   //--[ 自有參數-特殊 ]----------------------
)
{
   MARKET_ORDER_TYPE fOdType=OD_NA;
   double MLine0,ULine0,LLine0,KC0;
   double MLine1,ULine1,LLine1,KC1;
   int    SymDigits=(int)SymbolInfoInteger(fSymbol,SYMBOL_DIGITS);
   

   for(int i=fKFr;i<=fKTo;i++)
   {
      #ifdef __MQL4__
         //中軌
         MLine0 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_MAIN,i);
         MLine1 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_MAIN,i+1);
         //上軌
         ULine0 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_UPPER,i);
         ULine1 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_UPPER,i+1);
         //下軌
         LLine0 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_LOWER,i);
         LLine1 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_LOWER,i+1);
         //收盤價
         KC0 = iClose(fSymbol,fTf,i);
         KC1 = iClose(fSymbol,fTf,i+1);
      #endif 
      
      #ifdef __MQL5__
         //中軌
         MLine0 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_MAIN,i);
         MLine1 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_MAIN,i+1);
         //上軌
         ULine0 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_UPPER,i);
         ULine1 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_UPPER,i+1);
         //下軌
         LLine0 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_LOWER,i);
         LLine1 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_LOWER,i+1);
         //收盤價
         KC0 = iCloseMQL4(fSymbol,fTf,i);
         KC1 = iCloseMQL4(fSymbol,fTf,i+1);
      #endif   
   
      if( fEntryType==1 )  
      {
         if (fEntryWay==0) //往上進BUY
         {
            if ( KC0 > LLine0 && KC1 <= LLine1 )fOdType=OD_BUY;
            else
            if ( KC0 < ULine0 && KC1 >= ULine1 )fOdType=OD_SELL;
            else fOdType=OD_NA;
         }
         else
         if (fEntryWay==1) //往下進BUY
         {
            if ( KC0 < LLine0 && KC1 >= LLine1 )fOdType=OD_BUY;
            else
            if ( KC0 > ULine0 && KC1 <= ULine1 )fOdType=OD_SELL;
            else fOdType=OD_NA;
         }
         
      }
      else 
      if( fEntryType==2 )  
      {
         if (fEntryWay==0) //往上進BUY
         {
            if ( KC0 > MLine0 && KC1 <= MLine1 )fOdType=OD_BUY;
            else
            if ( KC0 < MLine0 && KC1 >= MLine1 )fOdType=OD_SELL;
            else fOdType=OD_NA; 
         }
         else
         if (fEntryWay==1) //往下進BUY
         {
            if ( KC0 < MLine0 && KC1 >= MLine1 )fOdType=OD_BUY;
            else
            if ( KC0 > MLine0 && KC1 <= MLine1 )fOdType=OD_SELL;
            else fOdType=OD_NA; 
         }  
      }
      else
         return(OD_ERROR);
      
      if( fOdType==OD_BUY || fOdType==OD_SELL ) break;
      
   } //EOF for
   
   if(fLogger)logger(LOG_INFO,__FUNCTION__+": 布林通道 OdType="+(string)fOdType+",ULine0="+DoubleToStr(ULine0,SymDigits)+",ULine1="+DoubleToStr(ULine1,SymDigits));
   
   if( fOdOpp && fOdType>=0 )return(getOppMaketOrderType(fOdType));
   return(fOdType);
    
}

/*===============================================
由最靠近的K棒(fKFr)開始往前找到前K根(fKTo) ,0:當根,1:前1根
fEntryType==1
上軌向上開, 下軌向下開
BUY : 當收盤價>=上軌向上 且 上軌角度>=fUAngle 且 下軌軌角度<=fLAngle 
SELL: 當收盤價<=下軌向下 且 上軌角度>=fUAngle 且 下軌軌角度<=fLAngle
*/

MARKET_ORDER_TYPE orderTypeByBands
(
   //--[ 內建指標參數 ]----------------------
   string fSymbol,
   ENUM_TIMEFRAMES fTf,
   int fPeriod,
   double fDeviation,
   int fBandsShift,
   ENUM_APPLIED_PRICE fPrice,
   //--[ 自有指標參數 ]----------------------
   int fBars,          // 前N個K棒(用於計算用K[0]~K[N]間布林值角度)
   int fXBarUnit,      // K棒數/單位長度K棒數
   double fYPriceUnit, // 價格/單位長度價格
   double fUAngle,     // K棒間上軌張開角度, > 0 表向上開, < 0 表向下開
   double fLAngle,     // K棒間下軌張開角度, > 0 表向上開, < 0 表向下開
   int fEntryType,
   int fKFr,
   int fKTo,
   bool fOdOpp=false,
)
{
   MARKET_ORDER_TYPE fOdType=OD_NA;
   double MLine0,ULine0,LLine0,KC0;
   double MLine1,ULine1,LLine1,KC1;
   double ULineN,LLineN;
   double UAngle,LAngle;

   for(int i=fKFr;i<=fKTo;i++)
   {
      #ifdef __MQL4__
         //中軌
         MLine0 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_MAIN,i);
         MLine1 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_MAIN,i+1);
         //上軌
         ULine0 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_UPPER,i);
         ULine1 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_UPPER,i+1);
         ULineN = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_UPPER,i+fBars);
         //下軌
         LLine0 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_LOWER,i);
         LLine1 = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_LOWER,i+1);
         LLineN = iBands(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_LOWER,i+fBars);
         //收盤價
         KC0 = iClose(fSymbol,fTf,i);
         KC1 = iClose(fSymbol,fTf,i+1);
      #endif 
      
      #ifdef __MQL5__
         //中軌
         MLine0 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_MAIN,i);
         MLine1 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_MAIN,i+1);
         //上軌
         ULine0 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_UPPER,i);
         ULine1 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_UPPER,i+1);
         ULineN = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_UPPER,i+fBars);
         //下軌
         LLine0 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_LOWER,i);
         LLine1 = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_LOWER,i+1);
         LLineN = iBandsMQL4(fSymbol,fTf,fPeriod,fDeviation,fBandsShift,fPrice,MODE_LOWER,i+fBars);
         //收盤價
         KC0 = iCloseMQL4(fSymbol,fTf,i);
         KC1 = iCloseMQL4(fSymbol,fTf,i+1);
      #endif
      
      //上軌[N]~上軌[0]開的角度 
      UAngle = getAngleByTan(fBars+i,i,fXBarUnit,ULine0,ULineN,fYPriceUnit);
      //下軌[N]~下軌[0]開的角度 
      LAngle = getAngleByTan(fBars+i,i,fXBarUnit,LLine0,LLineN,fYPriceUnit);
         
      if( fEntryType==1 )  
      {
         if(KC0 > KC1 && KC1 >= ULine1 && UAngle >= fUAngle && LAngle <= fLAngle )fOdType=OD_BUY;
         else
         if(KC0 < KC1 && KC1 <= LLine1 && UAngle >= fUAngle && LAngle <= fLAngle )fOdType=OD_SELL;
         else fOdType=OD_NA;         
      }
      else
         return(OD_ERROR);
      
      if( fOdType==OD_BUY || fOdType==OD_SELL ) break;
      
   } //EOF for
   
   #ifdef EA_51AREA
      Logger(LOG_DEBUG,__FUNCTION__+": Bands OdType="+(string)fOdType+",ULine0="+DoubleToStr(ULine0,Digits)+",ULine1="+DoubleToStr(ULine1,Digits));
   #endif
   
   if( fOdOpp && fOdType>=0 )return(getOppMaketOrderType(fOdType));
   return(fOdType);
    
}
/*
以三角形底及高之長度計算斜邊與底邊的角度, 回傳值介於-90度~90度
角度 = 180度/PI*弧度
弧度 = (高/底)的反正切值
高 = Y軸值差/單位長度
底 = X軸值差/單位長度
*/
double getAngleByTan
(
   double fXFr,      // X軸起值
   double fXTo,      // X軸迄值
   double fXUnit,    // X軸單位長度
   double fYFr,      // Y軸起值
   double fYTo,      // Y軸迄值
   double fYUnit,    // Y軸單位長度
)
{
   if( fXFr != fXTo && fXUnit > 0 && fYUnit > 0 )       
      return 180*M_1_PI*MathArctan(((fYFr-fYTo)/fYUnit)/((fXFr-fXTo)/fXUnit));
   return 0;
}
