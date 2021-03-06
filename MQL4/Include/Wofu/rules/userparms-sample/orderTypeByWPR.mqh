#include <EagerFx\\Transformers\\enums\\EntryType.mqh>
#include <FNO1\\enums\\EntryWay.mqh>
#include <FNO1\\enums\\EntryWayCht.mqh>
input string SepLineTWPR = "---------";            //---< 威廉％Ｒ >---
input ENUM_ENTRY_TYPE WprEntryType=1;              //採用模式
input ENUM_TIMEFRAMES WprTf=PERIOD_CURRENT;        //時區
input int WprPeriod=14;                            //時間週期
input double WprBaseBB=-50;                        //BUY 進場基準值
input double WprBaseSB=-50;                        //SELL進場基準值
input double WprBaseBE=0;                          //BUY 濾網上限
input double WprBaseSE=-100;                       //SELL濾網下限

input ENUM_ENTRY_WAY_CHT  WprEntryWay=0;           //進場模式-進入方向(SELL單與BUY相反)
 int   WprKFr=1;                                   //進場模式-採用K棒數(起)
input int WprKTo=1;                                //進場模式-採用K棒數(在多少根K內發生都算)
input bool WprPreK=false;                          //濾網模式-與前K的WPR比對
input bool  WprOdOpp=false;                        //結果反向 
/*
   enum ENUM_ENTRY_WAY  { 往上進BUY=0, 往下進BUY=1 };
   enum ENUM_ENTRY_TYPE { 濾網=0, 進場=1 };
*/