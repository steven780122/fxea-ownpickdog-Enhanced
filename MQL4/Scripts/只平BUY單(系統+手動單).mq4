//+------------------------------------------------------------------+
//|                       Copyright 2014, 英雄哥外匯贏家 Hero Forex. |
//|                                            http://www.HeroFx.biz |
//|                                          Editor:BANK 2014.08.19  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, 英雄哥外匯贏家 Hero Forex."
#property link      "http://www.HeroFx.biz"
#property version   "1.00"
#property description "==[ 關閉全部系統與手動 帳上BUY單 ]=="
#property strict
#define SlPage 5
#define OpenType OP_BUY
//全域參數
int gSlPage=5;
int LOG_NOT_ERROR=0,LOG_SYSTEM_ERROR=1,LOG_AUTH_ERROR=4,LOG_DEBUG=7,LOG_OTHER_ERROR=9,LOG_ORDER_SEND_ERROR=11,LOG_ORDER_MODIFY_ERROR=12,LOG_ORDER_CLOSE_ERROR=13;

void Logger(int fLoggerType,string fMessage)
 { printf("***** "+IntegerToString(fLoggerType)+","+fMessage+" *****"); }
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
 {
 
   int TotalOrderCnt=0;

   while(true)
    {
      TotalOrderCnt = GetOpPosCnt();
      if (TotalOrderCnt < 1) break;

      for(int i=OrdersTotal()-1;i>=0;i--)
       if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && OrderSymbol() == Symbol() && OrderType()==OpenType ) 
        {
         if ( !OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),SlPage,CLR_NONE) ) 
          Logger(LOG_ORDER_CLOSE_ERROR,"OrderTicket()="+IntegerToString(OrderTicket())+",CloseAllOrder ErrorCode="+IntegerToString(GetLastError()));
         Sleep(100);
       }

    }
     
 }
 
int GetOpPosCnt()
 {
  int fGetOpPosCnt=0; 
  for(int i=0;i<OrdersTotal();i++)
   { if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && OrderSymbol() == Symbol() && OrderType()==OpenType ) fGetOpPosCnt++; } 
  return(fGetOpPosCnt);
 }
//+------------------------------------------------------------------+



//另外一種方法
//因為Index會變所以要從最後面砍
//  for(int i=OrdersTotal()-1;i>=0;i--)
//   if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && OrderSymbol() == Symbol() && OrderType() == OpenType && ChkMagicNumber(OpenType,OrderMagicNumber()) ) 
//    if ( !OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),gSlPage,CLR_NONE) ) Logger(LOG_ORDER_CLOSE_ERROR,IntegerToString(GetLastError()));  
//  int CloseTicket[500];
//  int CTi=0;
//  for(int i=0;i<OrdersTotal();i++)
//   if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && OrderSymbol() == Symbol() && OrderType() == OpenType && ChkMagicNumber(OpenType,OrderMagicNumber()) ) 
//    {
//     CloseTicket[CTi]=OrderTicket();
//     CTi++;
//    }
//
//  for(int j=0;j<=CTi;j++)
//    if (OrderSelect(CloseTicket[j],SELECT_BY_TICKET,MODE_TRADES))
//     while ( !OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),gSlPage,CLR_NONE) ) Logger(LOG_ORDER_CLOSE_ERROR,IntegerToString(GetLastError()));  
