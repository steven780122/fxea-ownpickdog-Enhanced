   
/*
#include <Wofu\\rules\\orderTypeByIchimoku.mqh>
#include <Wofu\\userparms\\sample\\orderTypeByIchimoku.mqh>

double  iIchimoku(
   string       symbol,            // symbol
   int          timeframe,         // timeframe
   int          tenkan_sen,        // period of Tenkan-sen line
   int          kijun_sen,         // period of Kijun-sen line
   int          senkou_span_b,     // period of Senkou Span B line
   int          mode,              // line index (1 - MODE_TENKANSEN, 2 - MODE_KIJUNSEN, 3 - MODE_SENKOUSPANA, 4 - MODE_SENKOUSPANB, 5 - MODE_CHIKOUSPAN). 
   int          shift              // shift
   );


由最靠近的K棒(fKFr)開始往前找到前K根(fKTo) ,0:當根,1:前1根

fEntryType==0 濾網模式
   BUY :Ichimoku> 自訂BUY基準值 
   SELL:Ichimoku< 自訂SELL基準值

fEntryType==1 進場模式
   雲帶=MODE_SENKOUSPANA,MODE_SENKOUSPANB之間
   當fEntryWay==往上進BUY(0)
      BUY :由下而上穿過 雲帶上緣
      SELL:由上而下穿過 雲帶上緣
   當fEntryWay==往下進BUY(1)
      BUY :由上而下穿過 雲帶上緣
      SELL:由下而上穿過 雲帶上緣
      
   需要作為回碰雲帶出場，則使用 往下進BUY(1) +結果反向=true

   

fEntryType==10 濾網模式
   BUY :TK>TS
   SELL:TK<TS
   TS:MODE_TENKANSEN
   KS:MODE_KIJUNSEN

fEntryType==11 進場模式
   BUY :TK,TS黃金交叉
   SELL:TK,TS死亡交叉
   TS:MODE_TENKANSEN
   KS:MODE_KIJUNSEN
   

*/
 
#include <Wofu\\enums\\MarketOrderType.mqh>
#include <Wofu\\enums\\EntryWay.mqh>
#include <Wofu\\Common\\getOppMaketOrderType.mqh>
#include <Wofu\\Common\\logger.mqh>

#include <Wofu\\Common\\getOppOrderType.mqh>
#include <Wofu\\rules\\rulesParmCommon.mqh>

struct rulesParmIch
{
   //--[ 內建指標參數 ]----------------------
   string symbol;            // symbol
   ENUM_TIMEFRAMES tf;       // timeframe
   int tsPeriod;             // period of Tenkan-sen line 9
   int ksPeriod;             // period of Kijun-sen line 26
   int ssbPeriod;            // period of Senkou Span B line 52
   int bandWidthMin;         // 最小雲帶寬        
   int OCDiffPips;           // 開盤跳空超過距離(Pips)不下單(-1關閉)

};


int orderTypeByIchimoku
(
   rulesParmIch&    rps,
   rulesParmCommon& rpc
)
{
   int fOdType=-1;
   double KO0=0,KO1=0,KC0=0,KC1=0;
   double ICHSSA0=0,ICHSSB0=0,ICHSSA1=0,ICHSSB1=0;
   double ICHTS0=0,ICHKS0=0,ICHTS1=0,ICHKS1=0;
   int    SymDigits=(int)SymbolInfoInteger(rps.symbol,SYMBOL_DIGITS);
   
   //濾網模式
   if( rpc.entryType==0  )rpc.kBarTo=rpc.kBarFr;
   if( rpc.entryType==10 )rpc.kBarTo=rpc.kBarFr;

   
   for(int i=rpc.kBarFr;i<=rpc.kBarTo;i++)
   {
   
      KO0=iOpen(rps.symbol,rps.tf,i);
      KO1=iOpen(rps.symbol,rps.tf,i+1);
      
      KC0=iClose(rps.symbol,rps.tf,i);
      KC1=iClose(rps.symbol,rps.tf,i+1);
      #ifdef __MQL4__
         if( rpc.entryType==0 || rpc.entryType==1 )
         {  
            ICHSSA0=iIchimoku(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_SENKOUSPANA,i);
            ICHSSA1=iIchimoku(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_SENKOUSPANA,i+1);
   
            ICHSSB0=iIchimoku(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_SENKOUSPANB,i);
            ICHSSB1=iIchimoku(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_SENKOUSPANB,i+1);
         }
         else
         if( rpc.entryType==10 || rpc.entryType==11 )
         {
            ICHTS0=iIchimoku(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_TENKANSEN,i);
            ICHTS1=iIchimoku(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_TENKANSEN,i+1);
   
            ICHKS0=iIchimoku(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_KIJUNSEN,i);
            ICHKS1=iIchimoku(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_KIJUNSEN,i+1);
         }
      #endif
      #ifdef __MQL5__
         if( rpc.entryType==0 || rpc.entryType==1 )
         {
            ICHSSA0=iIchimokuMQL4(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_SENKOUSPANA,i);
            ICHSSA1=iIchimokuMQL4(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_SENKOUSPANA,i+1);
   
            ICHSSB0=iIchimokuMQL4(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_SENKOUSPANB,i);
            ICHSSB1=iIchimokuMQL4(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_SENKOUSPANB,i+1);
         }
         else
         if( rpc.entryType==10 || rpc.entryType==11 )
         {
            ICHTS0=iIchimokuMQL4(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_TENKANSEN,i);
            ICHTS1=iIchimokuMQL4(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_TENKANSEN,i+1);
   
            ICHKS0=iIchimokuMQL4(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_KIJUNSEN,i);
            ICHKS1=iIchimokuMQL4(rps.symbol,rps.tf,rps.tsPeriod,rps.ksPeriod,rps.ssbPeriod,MODE_KIJUNSEN,i+1);
         }
      #endif 
      
      if( rps.OCDiffPips!=-1 && MathAbs(KO0-KO1)/Point >rps.OCDiffPips )continue;
      
      if( rpc.entryType==0 )  
      {
              if( KC0> MathMax(ICHSSA0,ICHSSB0)  )fOdType=OD_BUY;  //雲帶上方
         else if( KC0< MathMin(ICHSSA0,ICHSSB0)  )fOdType=OD_SELL; //雲帶下方
         else fOdType=-1;
      }
      else 
      if( rpc.entryType==1 )  
      {
         if (rpc.entryWay==ENTRY_BUY_CROSSUP) //往上進BUY
         {
                 if( KC0> MathMax(ICHSSA0,ICHSSB0) && KC1 <= MathMax(ICHSSA1,ICHSSB1) && MathAbs(ICHSSA0-ICHSSB0)>=rps.bandWidthMin*_Point )fOdType=OD_BUY;  //穿出雲帶上緣
            else if( KC0< MathMin(ICHSSA0,ICHSSB0) && KC1 >= MathMin(ICHSSA1,ICHSSB1) && MathAbs(ICHSSA0-ICHSSB0)>=rps.bandWidthMin*_Point )fOdType=OD_SELL; //穿出雲帶下緣
            else fOdType=-1;
         }
         else
         if (rpc.entryWay==ENTRY_BUY_CROSSDOWN) //往下進BUY
         {
                 if( KC0< MathMax(ICHSSA0,ICHSSB0) && KC1 >= MathMax(ICHSSA1,ICHSSB1) && MathAbs(ICHSSA0-ICHSSB0)>=rps.bandWidthMin*_Point )fOdType=OD_BUY;  //穿入雲帶上緣
            else if( KC0> MathMin(ICHSSA0,ICHSSB0) && KC1 <= MathMin(ICHSSA1,ICHSSB1) && MathAbs(ICHSSA0-ICHSSB0)>=rps.bandWidthMin*_Point )fOdType=OD_SELL; //穿入雲帶下緣
            else fOdType=-1;
         }
      }
      else
      if( rpc.entryType==10 )  
      {
              if( ICHTS0 > ICHKS0 )fOdType=OD_BUY;  //黃金交叉
         else if( ICHTS0 < ICHKS0 )fOdType=OD_SELL; //死亡交叉
         else fOdType=-1;

      }
      else
      if( rpc.entryType==11 )  
      {
   
              if(ICHTS1 <= ICHKS1 && ICHTS0 > ICHKS0 )fOdType=OD_BUY;  //黃金交叉
         else if(ICHTS1 >= ICHKS1 && ICHTS0 < ICHKS0 )fOdType=OD_SELL; //死亡交叉
         else fOdType=-1;
      }
      else
         return(OD_ERROR);
      
      if( fOdType==OD_BUY || fOdType==OD_SELL ) break;
   } //EOF for
   
   if( rpc.doLogger )logger(LOG_INFO,__FUNCTION__+": 判斷結果="+( (fOdType>=0)?EnumToString((ENUM_ORDER_TYPE)fOdType):(string)fOdType )+",收盤="+DoubleToStr(KC0,SymDigits)+",雲帶上緣="+DoubleToStr(MathMax(ICHSSA0,ICHSSB0),SymDigits)+",雲帶下緣="+DoubleToStr(MathMin(ICHSSA1,ICHSSB1),SymDigits)+",設定進入方向:"+EnumToString(rpc.entryWay) );
   if( rpc.resultOpp && fOdType>=0 )return(getOppOrderType((ENUM_ORDER_TYPE)fOdType));
   return(fOdType);
    
}

ENUM_MARKET_ORDER_TYPE orderTypeByIchimoku
(
   //--[ 內建指標參數 ]----------------------
   string fSymbol,            // symbol
   ENUM_TIMEFRAMES fTf,       // timeframe
   int fTsPeriod,             // period of Tenkan-sen line 9
   int fKsPeriod,             // period of Kijun-sen line 26
   int fSsbPeriod,            // period of Senkou Span B line 52
   //--[ 自有參數-常用 ]----------------------
   int fEntryType,            //採用模式
   ENUM_ENTRY_WAY fEntryWay,  //進場模式-進入方向(SELL單與BUY相反) (1使用)
   int fKFr,                  //採用K棒數-起
   int fKTo,                  //採用K棒數-迄
   bool fPreK,                //與前K的值比對 //尚無使用
   bool fOdOpp,               //結果反向
   bool fLogger,              //是否寫出紀錄
   //--[ 自有參數-特殊 ]----------------------
   int fOCDiffPips           //開盤跳空超過距離(Pips)不下單(-1關閉)
)
{
   ENUM_MARKET_ORDER_TYPE fOdType=OD_NA;
   double KO0=0,KO1=0,KC0=0,KC1=0;
   double ICHSSA0=0,ICHSSB0=0,ICHSSA1=0,ICHSSB1=0;
   double ICHTS0=0,ICHKS0=0,ICHTS1=0,ICHKS1=0;
   int    SymDigits=(int)SymbolInfoInteger(fSymbol,SYMBOL_DIGITS);
   
   //濾網模式
   if( fEntryType==0 )fKTo=fKFr;
   if( fEntryType==10 )fKTo=fKFr;

   
   for(int i=fKFr;i<=fKTo;i++)
   {
   
      KO0=iOpen(fSymbol,fTf,i);
      KO1=iOpen(fSymbol,fTf,i+1);
      
      KC0=iClose(fSymbol,fTf,i);
      KC1=iClose(fSymbol,fTf,i+1);
      #ifdef __MQL4__
         if( fEntryType==0 || fEntryType==1 )
         {  
            ICHSSA0=iIchimoku(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_SENKOUSPANA,i);
            ICHSSA1=iIchimoku(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_SENKOUSPANA,i+1);
   
            ICHSSB0=iIchimoku(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_SENKOUSPANB,i);
            ICHSSB1=iIchimoku(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_SENKOUSPANB,i+1);
         }
         else
         if( fEntryType==10 || fEntryType==11 )
         {
            ICHTS0=iIchimoku(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_TENKANSEN,i);
            ICHTS1=iIchimoku(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_TENKANSEN,i+1);
   
            ICHKS0=iIchimoku(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_KIJUNSEN,i);
            ICHKS1=iIchimoku(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_KIJUNSEN,i+1);
         }
      #endif
      #ifdef __MQL5__
         if( fEntryType==0 || fEntryType==1 )
         {
            ICHSSA0=iIchimokuMQL4(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_SENKOUSPANA,i);
            ICHSSA1=iIchimokuMQL4(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_SENKOUSPANA,i+1);
   
            ICHSSB0=iIchimokuMQL4(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_SENKOUSPANB,i);
            ICHSSB1=iIchimokuMQL4(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_SENKOUSPANB,i+1);
         }
         else
         if( fEntryType==10 || fEntryType==11 )
         {
            ICHTS0=iIchimokuMQL4(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_TENKANSEN,i);
            ICHTS1=iIchimokuMQL4(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_TENKANSEN,i+1);
   
            ICHKS0=iIchimokuMQL4(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_KIJUNSEN,i);
            ICHKS1=iIchimokuMQL4(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod,MODE_KIJUNSEN,i+1);
         }
      #endif 
      
      if( fOCDiffPips!=-1 && MathAbs(KO0-KO1)/Point >fOCDiffPips )continue;
      
      if( fEntryType==0 )  
      {
              if( KC0> MathMax(ICHSSA0,ICHSSB0)  )fOdType=OD_BUY;  //雲帶上方
         else if( KC0< MathMin(ICHSSA0,ICHSSB0)  )fOdType=OD_SELL; //雲帶下方
         else fOdType=OD_NA;
      }
      else 
      if( fEntryType==1 )  
      {
         if (fEntryWay==ENTRY_BUY_CROSSUP) //往上進BUY
         {
                 if( KC0> MathMax(ICHSSA0,ICHSSB0) && KC1 <= MathMax(ICHSSA1,ICHSSB1) )fOdType=OD_BUY;  //穿出雲帶上緣
            else if( KC0< MathMin(ICHSSA0,ICHSSB0) && KC1 >= MathMin(ICHSSA1,ICHSSB1) )fOdType=OD_SELL; //穿出雲帶下緣
            else fOdType=OD_NA;
         }
         else
         if (fEntryWay==ENTRY_BUY_CROSSDOWN) //往下進BUY
         {
                 if( KC0< MathMax(ICHSSA0,ICHSSB0) && KC1 >= MathMax(ICHSSA1,ICHSSB1) )fOdType=OD_BUY;  //穿入雲帶上緣
            else if( KC0> MathMin(ICHSSA0,ICHSSB0) && KC1 <= MathMin(ICHSSA1,ICHSSB1) )fOdType=OD_SELL; //穿入雲帶下緣
            else fOdType=OD_NA;
         }
      }
      else
      if( fEntryType==10 )  
      {
              if( ICHTS0 > ICHKS0 )fOdType=OD_BUY;  //黃金交叉
         else if( ICHTS0 < ICHKS0 )fOdType=OD_SELL; //死亡交叉
         else fOdType=OD_NA;

      }
      else
      if( fEntryType==11 )  
      {
   
              if(ICHTS1 <= ICHKS1 && ICHTS0 > ICHKS0 )fOdType=OD_BUY;  //黃金交叉
         else if(ICHTS1 >= ICHKS1 && ICHTS0 < ICHKS0 )fOdType=OD_SELL; //死亡交叉
         else fOdType=OD_NA;
      }
      else
         return(OD_ERROR);
      
      if( fOdType==OD_BUY || fOdType==OD_SELL ) break;
   } //EOF for
   
   if(fLogger)logger(LOG_INFO,__FUNCTION__+": 判斷結果="+EnumToString(fOdType)+",收盤="+DoubleToStr(KC0,SymDigits)+",雲帶上緣="+DoubleToStr(MathMax(ICHSSA0,ICHSSB0),SymDigits)+",雲帶下緣="+DoubleToStr(MathMin(ICHSSA1,ICHSSB1),SymDigits)+",設定進入方向:"+EnumToString(fEntryWay) );
   if( fOdOpp && fOdType>=0 )return(getOppMaketOrderType(fOdType));
   return(fOdType);
    
}

//-----------------------------------------
//與前K比較處理
/*
if( fPreK )
{
   if( fOdType==OD_BUY  && FLine0 <= FLine1 )fOdType=OD_NA;
   if( fOdType==OD_SELL && FLine0 >= FLine1 )fOdType=OD_NA;
}
*/
   
/*
      #ifdef __MQL5__
         double IndArray[];
         ArraySetAsSeries(IndArray,true);
         int handle;
         ArrayResize(IndArray,0);
         if(CopyClose(fSymbol,fTf, fShift, 2, IndArray)<0)return(-1);
         KC0=IndArray[0];
         KC1=IndArray[1];
         
         handle=iIchimoku(fSymbol,fTf,fTsPeriod,fKsPeriod,fSsbPeriod);
         if(handle==INVALID_HANDLE)return(-1);
         //The buffer numbers: 0 - TENKANSEN_LINE, 1 - KIJUNSEN_LINE, 2 - SENKOUSPANA_LINE, 3 - SENKOUSPANB_LINE, 4 - CHIKOUSPAN_LINE.
         ArrayResize(IndArray,0);
         if(CopyBuffer(handle,2,fShift,2,IndArray)<0)return(-1);
         ICHSSA0 = IndArray[0];
         ICHSSA1 = IndArray[1];
      
         //The buffer numbers: 0 - TENKANSEN_LINE, 1 - KIJUNSEN_LINE, 2 - SENKOUSPANA_LINE, 3 - SENKOUSPANB_LINE, 4 - CHIKOUSPAN_LINE.
         ArrayResize(IndArray,0);
         if(CopyBuffer(handle,3,fShift,2,IndArray)<0)return(-1);
         ICHSSB0 = IndArray[0];
         ICHSSB1 = IndArray[1];

         
      #endif   
         double IndArray[];
         ArraySetAsSeries(IndArray,true);
         int handle;
         ArrayResize(IndArray,0);
         if(CopyOpen(fSymbol,fTf, i, 2, IndArray)<0)return(-1);
         KO0=IndArray[0];
         KO1=IndArray[1];
             
         handle=iIchimoku(fSymbol,fTf,fTS,fKS,fSSB);
         if(handle==INVALID_HANDLE)return(-1);
         //The buffer numbers: 0 - TENKANSEN_LINE, 1 - KIJUNSEN_LINE, 2 - SENKOUSPANA_LINE, 3 - SENKOUSPANB_LINE, 4 - CHIKOUSPAN_LINE.
         ArrayResize(IndArray,0);
         if(CopyBuffer(handle,0,i,2,IndArray)<0)return(-1);
         ICHTS0 = IndArray[0];
         ICHTS1 = IndArray[1];
      
         //The buffer numbers: 0 - TENKANSEN_LINE, 1 - KIJUNSEN_LINE, 2 - SENKOUSPANA_LINE, 3 - SENKOUSPANB_LINE, 4 - CHIKOUSPAN_LINE.
         ArrayResize(IndArray,0);
         if(CopyBuffer(handle,1,i,2,IndArray)<0)return(-1);
         ICHKS0 = IndArray[0];
         ICHKS1 = IndArray[1];
*/      