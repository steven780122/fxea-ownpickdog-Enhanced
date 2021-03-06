input string SepLineTRSI = "---------";        //---< RSI >---
input ENUM_TIMEFRAMES    RsiTF=PERIOD_CURRENT; //時區
input int                RsiPeriod=14;          //週期設定
input ENUM_APPLIED_PRICE RsiAp=PRICE_CLOSE;    //價格
input int                RsiBase=50;           //基準值
input int                RsiDiff1=0;           //誤差區間正負值
input int                RsiDiff2=0;           //背離區間正負值
input bool               RsiDiff1no=false;     //誤差區間不下單
input bool               RsiPreK=false;        //濾網模式-與前K的RSI比對
input bool  RsiOdOpp=false;                    //結果反向 
//BUY: 基準值+誤差值2>=RSI>基準值-誤差值1
//SELL:基準值+誤差值2<=RSI<基準值-誤差值1
//與前K的RSI比對，B：RSI越來越高，S：RSI越來越低