#include <EagerFx\\Transformers\\enums\\EntryType.mqh>
#include <FNO1\\enums\\EntryWay.mqh>
#include <FNO1\\enums\\EntryWayCht.mqh>
input string SepLineTRsi = "---------";            //---< RSI >---
input ENUM_ENTRY_TYPE RsiEntryType=1;              //採用模式
input ENUM_TIMEFRAMES RsiTf=PERIOD_CURRENT;        //時區
input int RsiPeriod=14;                            //時間週期
input ENUM_APPLIED_PRICE RsiAppPrice=PRICE_CLOSE;  //價格
input double RsiBaseBB=50;                         //BUY 進場基準值
input double RsiBaseSB=50;                         //SELL進場基準值
input double RsiBaseBE=100;                        //BUY 濾網上限
input double RsiBaseSE=0;                          //SELL濾網下限
input ENUM_ENTRY_WAY_CHT  RsiEntryWay=0;           //進場模式-進入方向(SELL單與BUY相反)
 int   RsiKFr=1;                                   //進場模式-採用K棒數(起)
input int RsiKTo=1;                                //進場模式-採用K棒數(在多少根K內發生都算)
input bool RsiPreK=false;                          //濾網模式-與前K的RSI比對
input bool  RsiOdOpp=false;                        //結果反向 
/*
   enum ENUM_ENTRY_WAY  { 往上進BUY=0, 往下進BUY=1 };
   enum ENUM_ENTRY_TYPE { 濾網=0, 進場=1 };
*/