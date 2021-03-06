#include <Wofu\\draw\\createRectLabel.mqh>
#include <Wofu\\draw\\writeLabel.mqh>
#include <Wofu\\common\\openWebBroswer.mqh>
#include <Wofu\\common\\downloadFile.mqh>
#include <Wofu\\common\\getInfoFromServer.mqh>
#include <Wofu\\common\\getInfoUrl.mqh>
#include <Wofu\\draw\\deleteAllObjects.mqh>



class ClassShowInfo
  {
   //----
   public:
      //void setNew( string text,string url);
      ClassShowInfo(string fsysCode,string feaCode,string fobjId);
      void show(bool enable);
      void click();
      void clickClose();
   private:
      void changeLabel();
      bool draw();
      void setText(string ftext=NULL,color ftextColor=clrBlack,color ftextBackgroundColor=clrIvory,string fheader="",color fheadColor=clrBlack,color fheaderBackgroundColor=clrRed);

   protected: 
      string sysCode;
      string eaCode;
      string objId;
      int    objX;
      int    objY;
      int    objW;
      int    objH;
      int    headerW;
      string clickUrl;
      string textFont;
      string header;
      color  headColor;
      string text;
      color  textColor;
      string aryText[];
      string showText;
      int    showIndex;
      string showTextSpace;
      color  textBackgroundColor;
      color  headerBackgroundColor;
      datetime lastGetfromServerTime;
      int    scrollTextStart;
      int    scrollLength;
      int    fontSize;
      datetime getInfoTime;
      int      getinfoWaitSecs;
      string   infoString;
      datetime clickCloseTime;
      int      clickCloseSecs;
      int      showTextPos;
   //---- 
  };
  
ClassShowInfo::ClassShowInfo(string fsysCode,string feaCode,string fobjId)
{
   objId=fobjId;
   sysCode=fsysCode;
   eaCode=feaCode;
   objX=300;
   objY=0;
   objW=520;
   objH=30;
   fontSize=12;
   showTextSpace="　　　　　　　　　　　　　　　　　　　　"; //20Space

   showIndex=0;
   showTextPos=1;
   scrollLength=200;
   textFont="微軟正黑體";
   getinfoWaitSecs=1800;
   clickCloseSecs=3600;
   
};


void ClassShowInfo::show(bool enable)
{
   
   if(enable && draw()){}
   else
      if(ObjectFind(objId)>=0)deleteAllObjects(DELETE_OBJECT_BY_PREFIX,objId);
}

void ClassShowInfo::click()
{
   if(clickUrl!="")openWebBroswer(clickUrl);
}


void ClassShowInfo::setText(string ftext=NULL,color ftextColor=clrBlack,color ftextBackgroundColor=clrIvory,string fheader="",color fheadColor=clrBlack,color fheaderBackgroundColor=clrRed)
{
   if(ftext!=NULL)text=ftext;
   if(ftextColor!=clrNONE)textColor=ftextColor;
   if(ftextBackgroundColor!=clrNONE)textBackgroundColor  =ftextBackgroundColor;
   
   if(fheader!=NULL)header=fheader;
   if(fheadColor!=clrNONE)headColor=fheadColor;
   if(fheaderBackgroundColor!=clrNONE)headerBackgroundColor=fheaderBackgroundColor;
   ArrayFree(aryText);
   StringSplit(text,',',aryText);
   if(MathMod(ArraySize(aryText),2)==1)
      ArrayResize(aryText,ArraySize(aryText)+1);
    
   showText=showTextSpace+aryText[showIndex];
   clickUrl=aryText[showIndex+1];
   
   headerW=StringLen(fheader)*(fontSize+2)+10;
}

bool ClassShowInfo::draw()
{


      //點擊關閉
      if(clickCloseTime+clickCloseSecs>TimeCurrent())return(false);
      //每個多久重新讀取
      if(getInfoTime+getinfoWaitSecs<TimeCurrent())
      {
         infoString=getInfoFromServer(getInfoUrl(sysCode,eaCode,"getTextInfo"));
         logger(LOG_DEBUG,"Info[T] (*´▽`*)"+infoString);
         getInfoTime=TimeCurrent();
      }
      if(infoString!="ERROR"&&infoString!="")setText(infoString,clrBlack,clrIvory,"NEWS",clrWhite,clrRed);
      else{return(false);};
      
      
      if(ObjectFind(0,objId)      !=0)createRectLabel(0,objId    ,0,objX+headerW-3 ,objY       ,objW    ,objH,textBackgroundColor  ,BORDER_FLAT,CORNER_LEFT_UPPER,clrNONE,STYLE_DASH,0);
      if(ObjectFind(0,objId+"H")  !=0)createRectLabel(0,objId+"H",0,objX           ,objY       ,headerW ,objH,headerBackgroundColor,BORDER_FLAT,CORNER_LEFT_UPPER,clrNONE,STYLE_DASH,0);
      if(ObjectFind(0,objId+"LbH")!=0)writeLabel(objId+"LbH",header,objX+headerW/2 ,objY+objH/2,fontSize,header,headColor,CORNER_LEFT_UPPER,ANCHOR_CENTER); 
      
      showText=StringSubstr(showText,showTextPos,scrollLength);
      showTextPos++;
      writeLabel(objId+"LbT",showText,objX+headerW+10,objY+objH/2,fontSize,textFont,textColor,CORNER_LEFT_UPPER,ANCHOR_LEFT); 
   
      if(showText=="")
      {
         showIndex+=2;
         if(showIndex>=ArraySize(aryText))showIndex=0;
         showTextPos=1;
         showText=showTextSpace+aryText[showIndex];
         clickUrl=aryText[showIndex+1];
      }   
      
      return(true);
      
}

void ClassShowInfo::clickClose()
{
   clickCloseTime=TimeCurrent();
   show(false);
}
