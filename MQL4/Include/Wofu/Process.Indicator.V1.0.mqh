/* ================================================================= */
#include <Wofu\\common\\DefaultDefines.mqh>
#include <Wofu\\common\\getInfoUrl.mqh>



#include <Wofu\\draw\\deleteAllObjects.mqh>
#include <Wofu\\auth\\isAuth.mqh>
#include <Wofu\\auth\\doReAuth.mqh>
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
            //isAuth(AUTH_TYPE_TIMER,SYS_CODE,EA_CODE,EA_NAME_E,u_sn,u_email,u_mobile);         
         //----- [ 顯示是否暫停，暫停時間判斷 ] -------
            //g_tick_stop.showMsg();
            
         //----- [ 共用訊息看板 ] -------   

         //----- [ 廣告輪播     ] -------
            g_banner_ad.show(true);
         //----- [ 自動開啟網頁 ] -------
            g_auto_web.openByTimer();
               
         //--- 假日寫程式
            //OnTick();
      }      
  }
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
      /*
         else if(StringFind(sparam,EA_NAME_E+"TickStopBtn")>=0 )
            g_tick_stop.setGvStop(StringToTime("2999.12.31"));
      //----- [ 點擊人工啟動 ] -------
         else if(StringFind(sparam,EA_NAME_E+g_tickStop+"Btn")>=0 )
            g_tick_stop.cancelGvStop();
      */
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