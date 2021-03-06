input string SepLineTFIBO  = "---------";          //---< ZigZag黃金切割預掛單 >---
input ENUM_TIMEFRAMES    FBTf=PERIOD_CURRENT;      //ZigZag時區
input int                FBDepth=12;               //ZigZag Depth
//設置高低點是相對與過去多少個k棒
input int                FBDeviation=5;            //ZigZag Deviation
//重新計算高低點時與前一高低點的相對點差
input int                FBBackStep=3;             //ZigZag BackStep
//設置回退計算的k棒個數
int FBStart=1;
int FBCnt=500;
input int                FBRefMinPips=0;           //ZZ最少價差點數
input double             FBEntryRatio1=23.6;       //進場1-比率
input double             FBEntryLots1=0.0;         //進場1-手數
input double             FBEntryRatio2=38.2;       //進場2-比率
input double             FBEntryLots2=0.0;         //進場2-手數
input double             FBEntryRatio3=50.0;       //進場3-比率
input double             FBEntryLots3=0.0;         //進場3-手數
input double             FBCloseRatio=100.0;       //出場-比率
input bool FBOdOpp=false;                          //結果反向