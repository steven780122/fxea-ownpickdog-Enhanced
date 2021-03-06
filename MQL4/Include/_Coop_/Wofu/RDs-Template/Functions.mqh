#include <Wofu\\common\\getInfoUrl.mqh>
#include <Wofu\\common\\isTime.mqh>
//#include <Wofu\\common\\getOppOrderType.mqh>
#include <Wofu\\draw\\chartPreSet.mqh>
#include <Wofu\\draw\\deleteAllObjects.mqh>
#include <Wofu\\draw\\createLabelText.mqh>
#include <Wofu\\draw\\createButton.mqh>

#include <Wofu\\trade\\sendOrder.mqh>
#include <Wofu\\trade\\closeAllOrders.mqh>
#include <Wofu\\trade\\setTpByPips.mqh>
#include <Wofu\\trade\\setSlByPips.mqh>
#include <Wofu\\common\\getLotsBySlPips.mqh>
//#include <Wofu\\rules\\getPriceByZigZag.mqh>



/* ================================================================= */
/* ================================================================= */
/* ================================================================= */

//+------------------------------------------------------------------+
//| Tick管理                                                         |
//+------------------------------------------------------------------+
bool isTickWork()
{
   if(!IsTradeAllowed()||!IsExpertEnabled())
      {        
         //第一次發生的時候做紀錄
         string msgMustRule="Expert Enabled Button="+(string)IsExpertEnabled()+
               ",Allow Live Trading="+(string)IsTradeAllowed()+
               ",Allow DLLs imports="+(string)IsDllsAllowed()+
               ",Allow import of external experts="+(string)IsLibrariesAllowed();
         if(g_isTickWork)logger(LOG_INFO,"Setting is NOT correct!"+msgMustRule);
         return(false); 
      }
      
   if(!g_isAuth)
      {
         if(g_isTickWork)logger(LOG_INFO,"Auth is NOT Corrrect!!"); 
         return(false); //畫面由Timer控制
      }
   
   if(g_tick_stop.isGvStop())
      {
         if(g_isTickWork)logger(LOG_INFO,"EA Tick Stop Time!!"+TimeToStr(TimeLocal(),TIME_DATE|TIME_SECONDS)+","+TimeToStr((datetime)GlobalVariableGet(EA_NAME_E+g_tickStop+"_E"),TIME_DATE|TIME_SECONDS)); 
         return(false); //畫面由Timer控制
      
      }

   if(!g_isTickWork)logger(LOG_INFO,"Ea Tick Go ");
   return(true);

}
//+------------------------------------------------------------------+
//| Tick資料蒐集(放置同一個TICK不會改變的資訊，供全部程式使用)       |
//+------------------------------------------------------------------+
void genReferenceTickInfo()
{
//----- [ 新K棒 判斷 ] -------
   if(g_isNewBar && g_orders_trades_info.countOpen==0 ){
      g_orders_trades_info.getInfo(_Symbol,orderMagicNumber);

   }
}
//+------------------------------------------------------------------+
//| 風險管理-在倉處理                                                |
//+------------------------------------------------------------------+
bool riskManager()
{
   g_orders_trades_info.getInfo(_Symbol,orderMagicNumber);
   
//----- [ 進場先平反向單 ] -------
   if(u_CloseByOrder){
      if( g_orders_trades_info.countOpen>0 ){
         if(g_rti.entryBuy){
            closeAllOrders(_Symbol,(ENUM_MIXED_ORDER_TYPE)ORDER_TYPE_SELL,orderMagicNumber,orderSlPage);
            g_orders_trades_info.getInfo(_Symbol,orderMagicNumber);
         }
         if(g_rti.entrySell){
            closeAllOrders(_Symbol,(ENUM_MIXED_ORDER_TYPE)ORDER_TYPE_BUY ,orderMagicNumber,orderSlPage);
            g_orders_trades_info.getInfo(_Symbol,orderMagicNumber);
         }
      }
   }
//----- [ 停利偵測 ] -------
   if( g_orders_trades_info.profitAll>0 ){
      if( (u_TpAmt>0          && g_orders_trades_info.profitAll >= u_TpAmt ) ||
          (u_TpBalanceRatio>0 && g_orders_trades_info.profitAll >= AccountBalance()*u_TpBalanceRatio/100 ) ||
          (u_TpEquityRatio>0  && g_orders_trades_info.profitAll >= AccountEquity()*u_TpEquityRatio/100   )   ){ 
            closeAllOrders(_Symbol,MIXED_ODTYPE_BUY_SELL,orderMagicNumber,orderSlPage);
            g_orders_trades_info.getInfo(_Symbol,orderMagicNumber); 
        }
   }
//----- [ 停損偵測 ] -------
   else
   if( g_orders_trades_info.profitAll<0 )
   {
      if( (u_SlAmt>0          && MathAbs(g_orders_trades_info.profitAll) >= u_SlAmt ) ||
          (u_SlBalanceRatio>0 && MathAbs(g_orders_trades_info.profitAll) >= AccountBalance()*u_SlBalanceRatio/100 ) ||
          (u_SlEquityRatio>0  && MathAbs(g_orders_trades_info.profitAll) >= AccountEquity()*u_SlEquityRatio/100   ) ){ 
            closeAllOrders(_Symbol,MIXED_ODTYPE_BUY_SELL,orderMagicNumber,orderSlPage);
            g_orders_trades_info.getInfo(_Symbol,orderMagicNumber); 
        }
   }
//----- [ 依照每張訂單設定SL,TP ] -------
   int SelectTicketNo=-1;
   if( OrdersTotal()>0 && ( u_TpPips>0 || u_SlPips>0 )  ){
        for(int i=0;i<OrdersTotal();i++){ 
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && isMyOrder(_Symbol,MIXED_ODTYPE_BUY_SELL,orderMagicNumber) ){
               SelectTicketNo=OrderTicket();
               //----- [ 設定停利/損點 ] -------
               if( u_TpPips>0 )setTpByPips(SelectTicketNo,u_TpPips,false);               
               if( u_SlPips>0 )setSlByPips(SelectTicketNo,u_SlPips,false,false);
            }
         } 
    }
   return(true);
}

//+------------------------------------------------------------------+
//| 進場管理-進場處理                                                |
//+------------------------------------------------------------------+
bool tradeManager()
{
//----- [ 圖表K棒進場 ] -------
   if(g_isNewBar)
   {
      logger(LOG_INFO,"新K棒產生");
   //----- [ 進場時間 ] -------
      if( isTime(u_opWkNo,u_opFrTo,30,0) )
      {
         logger(LOG_INFO,"下單時間內，偵測下單");
         g_orders_trades_info.getInfo(_Symbol,orderMagicNumber);
         if( g_orders_trades_info.countOpen==0 )
         {
            if(g_rti.entryBuy)
            {
               sendOrder(TRADE_WAY_ONLY_LONG_AND_SHORT,_Symbol,ORDER_TYPE_BUY ,getOrderLots(ORDER_TYPE_BUY ),orderMagicNumber,EA_NAME_E+orderCommentPrefix+"B",orderSlPage,Ask,0,0);
            }
            if(g_rti.entrySell)
            {
               sendOrder(TRADE_WAY_ONLY_LONG_AND_SHORT,_Symbol,ORDER_TYPE_SELL,getOrderLots(ORDER_TYPE_SELL),orderMagicNumber,EA_NAME_E+orderCommentPrefix+"S",orderSlPage,Bid,0,0);
            }
         }
      }
   }
   return(true);
}

double getOrderLots(ENUM_ORDER_TYPE orderType)
{
   
   if(u_LotsMode==LOTS_MODE_FIX)return(u_Lots);
   else
   if(u_LotsMode==LOTS_MODE_SLAMT)
            return(getLotsBySlPips(_Symbol,u_SlPips,u_SlAmt));   
   return(0);

}

//+------------------------------------------------------------------+
//| 畫面繪製OnTick                                                   |
//+------------------------------------------------------------------+
void drawOnTick()
{

}
//+------------------------------------------------------------------+
//| 畫面繪製OnTimer                                                  |
//+------------------------------------------------------------------+
void drawOnTimer()
{

}

//+------------------------------------------------------------------+
//| 畫面繪製OnTimer                                                  |
//+------------------------------------------------------------------+
void drawOnInit()
{
//----- [ 通用畫面繪製 ] -------
    chartPreSet();
//----- [ 人工暫停按鈕 ] -------     
    createButton(0,EA_NAME_E+"TickStopBtn",0,8,8,8,8,CORNER_RIGHT_LOWER,"■",EA_FONT,8); 
//----- [ EA註解 EaRemarks ] -------     
    createLabelTextRU(EA_NAME_E+"Remarks",10*StringLen(u_Remarks)+125+10,0,10*StringLen(u_Remarks)+10,20,u_Remarks,10);
//----- [ 顯示選單 ] -------
    g_menu_right_upper.show(true);     
}
/* ================================================================= */
/* ================================================================= */
/* ================================================================= */

string getUserParm()
{
   string userParm="";
#ifdef AUTH_ENABLE
   userParm+="UserSN="+u_sn+";;";
   userParm+="UserEmail="+u_email+";;";
   userParm+="UserMobile="+u_mobile+";;";
#endif
   return(userParm);
}

void userParmCheck()
{
   g_lotsDigital=getLotsDigital(_Symbol);
/*
//--- 提示參數設定錯誤  
   if(B_TpPips<MarketInfo(Symbol(),MODE_STOPLEVEL))Alert("BUY "+MSG_ERROR_STOPLEVEL+"("+DoubleToString(MarketInfo(Symbol(),MODE_STOPLEVEL),0)+")");
   if(S_TpPips<MarketInfo(Symbol(),MODE_STOPLEVEL))Alert("SELL"+MSG_ERROR_STOPLEVEL+"("+DoubleToString(MarketInfo(Symbol(),MODE_STOPLEVEL),0)+")");
   if(B_Lots  <MarketInfo(Symbol(),MODE_MINLOT))Alert("BUY "+MSG_ERROR_MODE_MINLOT+"("+DoubleToString(MarketInfo(Symbol(),MODE_MINLOT),2)+")");
   if(S_Lots  <MarketInfo(Symbol(),MODE_MINLOT))Alert("SELL"+MSG_ERROR_MODE_MINLOT+"("+DoubleToString(MarketInfo(Symbol(),MODE_MINLOT),2)+")");
   */
   
}




void showMsgPanelExpertNotEnable()
{
      g_msg_panel.setLabel(MSG_EA_TICK_STOP,MSG_EXPERT_NOT_ENABLE,getInfoUrl(SYS_CODE,EA_CODE,"Help-ExpertNotEnable"),clrPink);
      g_msg_panel.showPanel(true);   
}