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

#include <Wofu\\Common\\logger.mqh>
#include <Wofu\\enums\\EntryTypeZigZag.mqh>
//fEntryType=0:HIGH,1:LOW
double getPriceByZigZag
(
   //--[ 內建指標參數 ]----------------------
   string fSymbol,
   ENUM_TIMEFRAMES fTf,
   int fDepth,
   int fDeviation,
   int fBackStep,
   //--[ 自有參數-常用 ]----------------------
   ENTRY_TYPE_ZIGZAG fEntryType,
   int fKFr,
   int fKTo,
   bool fLogger,              //是否寫出紀錄
   //--[ 自有參數-特殊 ]----------------------
   int fCntStart        //第幾個開始算，通常第1個因為未確定則不使用，需要設置成2
)
{
   double ZigZagM,ZigZagH,ZigZagL;
   int cnt=0;
   int    SymDigits=(int)SymbolInfoInteger(fSymbol,SYMBOL_DIGITS);
   for(int i=fKFr;i<=fKTo;i++)
   { 
      //printf("fKFr="+fKFr+",i="+i);  
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
      if(ZigZagM>0)cnt++;
      //fCntStart=2 則 捨棄第1段 
      if( cnt<fCntStart )continue;
      
      //MQL5直接改寫iHighest,iLowest放在mql4_to_mql5.mqh
      
      
      
      if( fEntryType==ET_ZIGZAG_FIND_HIGH )
      {
         //如果到ZigZag的高點之間已經有更高的價額，那就在往前找到更高的價額
         if( ZigZagM>0 && ZigZagH>0 )
            if( i == iHighest(fSymbol,fTf,MODE_HIGH,i+1,fKFr) )
            {
               if(fLogger)logger(LOG_INFO,__FUNCTION__+": ZigZag高點,K棒數("+(string)i+"),ZZ數="+(string)cnt+",Price="+(string)NormalizeDouble(ZigZagM,SymDigits));
               return(NormalizeDouble(ZigZagM,SymDigits));
            }
      }
      else
      if( fEntryType==ET_ZIGZAG_FIND_LOW )
      {
         //如果到ZigZag的低點之間已經有更低的價額，那就在往前找到更低的價額
         if( ZigZagM>0 && ZigZagL>0 )
            if( i == iLowest(fSymbol,fTf,MODE_LOW,i+1,fKFr) )
            {
               if(fLogger)logger(LOG_INFO,__FUNCTION__+": ZigZag低點,K棒數("+(string)i+"),ZZ數="+(string)cnt+",Price="+(string)NormalizeDouble(ZigZagM,SymDigits));
               return(NormalizeDouble(ZigZagM,SymDigits));
            }
      }
      
      // ZigZagM="+(string)ZigZagM+",ZigZagH="+(string)ZigZagH+",ZigZagL="+(string)ZigZagL);
         
   }
   return(0);
}


void getPriceByZigZag
(
   //--[ 內建指標參數 ]----------------------
   string fSymbol,
   ENUM_TIMEFRAMES fTf,
   int fDepth,
   int fDeviation,
   int fBackStep,
   //--[ 自有參數-常用 ]----------------------
   int fKFr,
   int fKTo,
   double& outPrice1,
   double& outPrice2
)
{
   double ZigZagM=0,ZigZagH=0,ZigZagL=0;
   int    cntH=0,cntL=0;
   outPrice1=0;
   outPrice2=0;
   int    SymDigits=(int)SymbolInfoInteger(fSymbol,SYMBOL_DIGITS);
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
         if(handle==INVALID_HANDLE)return;
         ArrayResize(IndArray,0);
         //0:Main,1:Highs,2:Lows
         if(CopyBuffer(handle,0,i,1,IndArray)<0)return;
         ZigZagM = IndArray[0];

         ArrayResize(IndArray,0);
         //0:Main,1:Highs,2:Lows
         if(CopyBuffer(handle,1,i,1,IndArray)<0)return;
         ZigZagH = IndArray[0];
         
         ArrayResize(IndArray,0);
         //0:Main,1:Highs,2:Lows
         if(CopyBuffer(handle,2,i,1,IndArray)<0)return;
         ZigZagL = IndArray[0];
               
      #endif     


      if( ZigZagM>0 && ( ZigZagH>0 || ZigZagL>0 ) )
      { 
         if(outPrice1<=0)outPrice1=NormalizeDouble(ZigZagM,SymDigits); 
         else
         if(outPrice2<=0)outPrice2=NormalizeDouble(ZigZagM,SymDigits); 
      }
      //logger(LOG_DEBUG,__FUNCTION__+": ZigZagLastPrice "+(string)i+" outPrice1="+(string)outPrice1+",outPrice2="+(string)outPrice2);
      if( outPrice1>0 && outPrice2>0 )return;
         
   }
}

