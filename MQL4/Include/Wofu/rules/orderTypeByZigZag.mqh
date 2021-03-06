/*
#include <Wofu\\rules\\getPriceByZigZag.mqh>
#include <Wofu\\userparms\\sample\\getPriceByZigZag.mqh>

double  iCustom(
   string       symbol,           // symbol
   int          timeframe,        // timeframe
   string       name,             // path/name of the custom indicator compiled program
   ...                            // custom indicator input parameters (if necessary)
   int          mode,             // line index
   int          shift             // shift
   );

MT4 ZigZag   
//---- indicator parameters
input int InpDepth=12;     // Depth
input int InpDeviation=5;  // Deviation
input int InpBackstep=3;   // Backstep
//---- indicator buffers
double ExtZigzagBuffer[];
double ExtHighBuffer[];
double ExtLowBuffer[];
   SetIndexBuffer(0,ExtZigzagBuffer);
   SetIndexBuffer(1,ExtHighBuffer);
   SetIndexBuffer(2,ExtLowBuffer);
   
ZIGZAG的計算 
高算高 低算低
互不影響
Depth-->
   回推幾根K棒找高點
   回推幾根K棒找低點
Backstep
   2個高點間至少會距離K棒數
   2個低點間至少會距離K棒數

由最靠近的K棒(fKFr)開始往前找到前K根(fKTo) ,0:當根,1:前1根


fEntryType==0
   BUY :
   SELL:

fEntryType==1
   BUY :
   SELL:

*/

#include <Wofu\\enums\\MarketOrderType.mqh>
#include <Wofu\\enums\\EntryWay.mqh>
#include <Wofu\\Common\\getOppMaketOrderType.mqh>
#include <Wofu\\Common\\logger.mqh>

ENUM_MARKET_ORDER_TYPE orderTypeByZigZag
(
   //--[ 內建指標參數 ]----------------------
   string fSymbol,
   ENUM_TIMEFRAMES fTf,
   int fDepth,
   int fDeviation,
   int fBackStep,
   //--[ 自有參數-常用 ]----------------------
   int fEntryType,            //採用模式
   ENUM_ENTRY_WAY fEntryWay,  //進場模式-進入方向(SELL單與BUY相反) //未使用
   int fKFr,                  //採用K棒數-起
   int fKTo,                  //採用K棒數-迄
   bool fPreK,                //與前K的值比對 //未使用
   bool fOdOpp,               //結果反向
   bool fLogger               //是否寫出紀錄
   //--[ 自有參數-特殊 ]----------------------
)
{
   
   ENUM_MARKET_ORDER_TYPE fOdType=-1;
   int    KbarShift=-1;
   double ZigZagM=0,ZigZagH=0,ZigZagL=0;
   int    SymDigits=(int)SymbolInfoInteger(fSymbol,SYMBOL_DIGITS);
   //double SLine0,,SLine1;
   if( fEntryType==0 )fKTo=fKFr;

   for(int i=fKFr;i<=fKTo;i++)
   {
      #ifdef __MQL4__
         ZigZagM=iCustom(fSymbol,fTf,"ZigZag",fDepth,fDeviation,fBackStep,0,i);
         ZigZagH=iCustom(fSymbol,fTf,"ZigZag",fDepth,fDeviation,fBackStep,1,i);
         ZigZagL=iCustom(fSymbol,fTf,"ZigZag",fDepth,fDeviation,fBackStep,2,i);
      #endif
      #ifdef __MQL5__      
         double IndArray[];
         ArraySetAsSeries(IndArray,true);
         int handle;
      
         handle=iCustom(fSymbol,fTf,"ZigZag",fDepth,fDeviation,fBackStep);
         if(handle==INVALID_HANDLE)return(-1);
         ArrayResize(IndArray,0);
         //0:Main,1:Highs,2:Lows
         if(CopyBuffer(handle,0,i,1,IndArray)<0)return(-1);
         ZigZagM = IndArray[0];

         ArrayResize(IndArray,0);
         //0:Main,1:Highs,2:Lows
         if(CopyBuffer(handle,1,i,1,IndArray)<0)return(-1);
         ZigZagH = IndArray[0];
         
         ArrayResize(IndArray,0);
         //0:Main,1:Highs,2:Lows
         if(CopyBuffer(handle,2,i,1,IndArray)<0)return(-1);
         ZigZagL = IndArray[0];
               
      #endif    
      
      if( fEntryType==0 )
      {
              if(ZigZagM>0 && ZigZagH>0)fOdType=OD_SELL; 
         else if(ZigZagM>0 && ZigZagL>0)fOdType=OD_BUY;
         else fOdType=OD_NA;
      }
      else
      if( fEntryType==1 )
      {

      }
      else
         return(OD_ERROR);
      
      //Logger(LOG_DEBUG,__FUNCTION__+": KD ("+(string)i+") OdType="+(string)fOdType+",FLine0="+DoubleToStr(FLine0,Digits)+",SLine0="+DoubleToStr(SLine0,Digits));
      if( fOdType==OD_BUY || fOdType==OD_SELL ) { KbarShift=i;break;}
   }

   if(fLogger)logger(LOG_INFO,__FUNCTION__+": 判斷結果="+EnumToString(fOdType)+"("+IntegerToString(KbarShift)+"),高點="+DoubleToStr(ZigZagH,SymDigits)+",低點="+DoubleToStr(ZigZagL,SymDigits));
   if( fOdOpp && fOdType>=0 )return(getOppMaketOrderType(fOdType));
   return(fOdType);
}