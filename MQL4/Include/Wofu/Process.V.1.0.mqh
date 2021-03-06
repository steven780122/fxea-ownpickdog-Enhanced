/* ================================================================= */
#include <Wofu\\common\\DefaultDefines.mqh>
#include <Wofu\\common\\isNewBar.mqh>
#include <Wofu\\common\\isNewPeriod.mqh>
#include <Wofu\\common\\getInfoUrl.mqh>


#include <Wofu\\draw\\showProcessComment.mqh>
#include <Wofu\\draw\\deleteAllObjects.mqh>
/*--- 認證 ---*/
#include <Wofu\\auth\\isAuth.mqh>
#include <Wofu\\auth\\doReAuth.mqh>

/* ================================================================= */
int OnInit()
  {
   EventSetMillisecondTimer(100);
   //----- [ 設定紀錄模式 ] -------
      #ifdef ZONE51
         setLogLevel(LOG_ALL);
      #else 
         setLogLevel(LOG_INFO);
      #endif 
   //----- [ 左上資訊顯示 ] -------
      showProcessComment(EA_CODE,PROCESS_COMMENT_MODE_INIT_BEGIN);
   //----- [ 判斷是否是切換時區 ] -------
      if(!isNewPeriod())
      {
          deleteAllObjects(0,EA_NAME_E);
          logger(LOG_INFO,"BUILD"+(string)__MQLBUILD__+",CPL_DATE:"+(string)__DATETIME__);
       //----- [ 使用者參數檢查與校正 ] -------
          userParmCheck();
          if( !IsOptimization() && !IsTesting() )
          { 
           //----- [ 初始畫面繪製 ] -------
              drawOnInit();
           //----- [ 必要設定檢查 ] -------
              if( !IsDllsAllowed()      ){Alert(MSG_DLL_NOT_ALLOW);showProcessComment(EA_CODE,PROCESS_COMMENT_MODE_INIT_FAIL);return(INIT_FAILED);} 
             //if( !IsLibrariesAllowed() ){Alert(MSG_LIB_NOT_ALLOW);showProcessComment(EA_CODE,"InitF");return(INIT_FAILED);}   
              if( !AccountInfoInteger(ACCOUNT_TRADE_EXPERT)){Alert(MSG_ACCOUNT_TRADE_EXPERT_NOT_ALLOWED);showProcessComment(EA_CODE,PROCESS_COMMENT_MODE_INIT_FAIL);return(INIT_FAILED);}
          }
      }
   //----- [ 認證處理-TICK時再做判斷 避免參數需要重打 ] -------
      if(!isAuth(AUTH_TYPE_INIT,SYS_CODE,EA_CODE,EA_NAME_E,u_sn,u_email,u_mobile)){g_isAuth=false;}else{g_isAuth=true;}

   showProcessComment(EA_CODE,PROCESS_COMMENT_MODE_INIT_END);   
   return(INIT_SUCCEEDED);
  }

/* ================================================================= */
void OnTick()
  {
   //----- [ Tick管理(沒通過認證、必要開啟沒開) ] -------
      g_isTickWork=isTickWork();
      if(!g_isTickWork){showProcessComment(EA_CODE,PROCESS_COMMENT_MODE_TICK_STOP); return;}
   //----- [ 顯示左上角訊息 ] -------
      showProcessComment(EA_CODE,PROCESS_COMMENT_MODE_TICK);   
   //----- [ 掛載時區產生新K棒 ] -------
      g_isNewBar=isNewBar(Symbol(),PERIOD_CURRENT,true);
   //----- [ 在倉管理 ] -------
      if(OrdersTotal()>0)riskManager();   
   //----- [ 開倉管理 ] ------- 
      tradeManager();
   //----- [ 顯示資訊 ] ------- 
      drawOnTick();
  }
/* ================================================================= */
void OnDeinit(const int reason)
  {
   //--- destroy timer
      EventKillTimer();
      if( UninitializeReason()!=3 &&  UninitializeReason()!=8 )deleteAllObjects(999);    
  }
/* ================================================================= */
void OnTimer()
  {
   //Timer設定成0.1秒
      static int timerCount;
      //----- [ 訊息廣播     ] -------
         if(MathMod(timerCount,3)==0)g_info_news.show(true);
      timerCount++;
      if(timerCount>=864000)timerCount=0;

   //每秒執行一次
      static int prevTime;
      if((int)TimeCurrent()>prevTime)
      {
         prevTime=(int)TimeCurrent();
         
         //----- [ 認證處理 ] -------
            isAuth(AUTH_TYPE_TIMER,SYS_CODE,EA_CODE,EA_NAME_E,u_sn,u_email,u_mobile);
         
         //----- [ 顯示是否暫停，暫停時間判斷 ] -------
            g_tick_stop.showMsg();
            
         //----- [ 共用訊息看板 ] -------   
            //----- [ 檢測提示EA按鈕是否按下 ] -------
            if(!IsExpertEnabled())
               showMsgPanelExpertNotEnable();
            else 
               g_msg_panel.showPanel(false);
         //----- [ 廣告輪播     ] -------
            g_banner_ad.show(true);
         //----- [ 自動開啟網頁 ] -------
            g_auto_web.openByTimer();
               
         //--- 假日寫程式
            //OnTick();
      }      
  }
/* ================================================================= */
void OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
   if( id==CHARTEVENT_OBJECT_CLICK )
   {
      logger(LOG_DEBUG,(string)id+","+(string)lparam+","+(string)dparam+","+sparam+",");
      if(StringFind(sparam,EA_NAME_E)<0)return;
      
      //----- [ 處理鈕按變色 ] -------
         if(ObjectType(sparam)==OBJ_BUTTON)ObjectSetInteger(0,sparam,OBJPROP_STATE,false); 
      
      //----- [ 點擊重新認證 ] -------
         if(StringFind(sparam,EA_NAME_E+"reAuthPanelImgBg")>=0)
         doReAuth(SYS_CODE,EA_NAME_E,u_sn,u_email,u_mobile,id,lparam,dparam,sparam);
      //----- [ 點擊選單 ] -------
         else if(StringFind(sparam,EA_NAME_E+g_menu)>=0 )
            g_menu_right_upper.click(sparam);
      //----- [ 點擊人工暫停 ] -------
         else if(StringFind(sparam,EA_NAME_E+"TickStopBtn")>=0 )
            g_tick_stop.setGvStop(StringToTime("2999.12.31"));
      //----- [ 點擊人工啟動 ] -------
         else if(StringFind(sparam,EA_NAME_E+g_tickStop+"Btn")>=0 )
            g_tick_stop.cancelGvStop();
      //----- [ 點擊NEWS ] -------
         else if(StringFind(sparam,EA_NAME_E+g_infoNews+"Lb")>=0 )
            g_info_news.click();
      //----- [ 點擊BANNER ] -------
         else if(StringFind(sparam,EA_NAME_E+g_bannerAD)>=0 )
         {
            //----- [ 關閉BANNER ] -------
            if(StringFind(sparam,"BtnClose")>=0 )
               g_banner_ad.clickClose();
            //----- [ 開啟BANNER URL ] -------
            else
               g_banner_ad.click();
         }
      //----- [ 共用顯示面板 ] -------
         else if(StringFind(sparam,EA_NAME_E+g_msgPanel)>=0 )
         {
            if(StringFind(sparam,"LbHelp")>=0 )g_msg_panel.clickHelp();
         }
      //else if(sparam==EA_NAME_E+"BtnCloseAll" && MessageBox("是否全部平倉?", "再次確認", 0x00000001)==1){ChkTickErr="MGO_MANUAL_CLOSE";SetStartTime(BtStartMode);BarsPre=Bars;  DeleteAllOrder(); CloseAllOrder(99);}
      //else if(sparam==EA_NAME_E+"Logo")OpenURL("http://www.herofx.biz/"+UrlS);


      


   }
  }
/* ================================================================= */

