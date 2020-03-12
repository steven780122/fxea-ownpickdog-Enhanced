//+------------------------------------------------------------------+
//|                                                         Test.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   //MessageBox(ChartID());
   //ChartOpen("EURUSD", PERIOD_M15)
   //ChartScreenShot()

   
   printf(TerminalInfoString(TERMINAL_COMMONDATA_PATH));
   printf(TerminalInfoString(TERMINAL_DATA_PATH));
   
  }
//+------------------------------------------------------------------+
