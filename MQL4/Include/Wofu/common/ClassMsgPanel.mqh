#include <Wofu\\Message.mqh>
#include <Wofu\\common\\DefaultDefines.mqh>
#include <Wofu\\common\\openWebBroswer.mqh>
#include <Wofu\\draw\\deleteAllObjects.mqh>
#include <Wofu\\draw\\writeImage.mqh>
#include <Wofu\\draw\\createRectLabel.mqh>
#include <Wofu\\draw\\writeLabel.mqh>
#include <Wofu\\draw\\createButton.mqh>

class ClassMsgPanel
  {
   //----
   public:
      void setLabel( string fmsgTextLine1,string fmsgTextLine2,string fmsgHelpUrl,color  fmsgColor );
      void setLocation( int fmsgPanelX,int fmsgPanelY,int fmsgPanelW=0,int fmsgPanelH=0  );
      void setButton( string fbuttonText,color fbuttonTextColor=clrNONE,color fbuttonBackColor=clrNONE,color fbuttonBorderColor=clrNONE );
      void showPanel(bool enable,bool showButton=false);
      void clickButton();
      void clickHelp();
      ClassMsgPanel(string fsysCode="",string feaCode="",string fMsgId="",string fmsgTextLine1="",string fmsgTextLine2="",string fmsgHelpUrl="",color  fmsgColor=clrSnow);      
      void setMsgId(string fsysCode,string feaCode,string fMsgId);
   private:
      void changeLabel();
   protected: 
      string sysCode;
      string eaCode;
      string msgId;
      int    msgPanelX;
      int    msgPanelY;
      int    msgPanelW;
      int    msgPanelH;
      string msgPanelFont;
      string msgTextLine1;
      string msgTextLine2;
      string msgHelpText;
      string msgHelpUrl;
      color  msgColor;
      bool   isShowButton;
      string buttonText;
      color  buttonTextColor;
      color  buttonBackColor;
      color  buttonBorderColor;
   //---- 
  };
  
ClassMsgPanel::ClassMsgPanel(string fsysCode="",string feaCode="",string fMsgId="",string fmsgTextLine1="",string fmsgTextLine2="",string fmsgHelpUrl="",color  fmsgColor=clrSnow)
{
   eaCode=feaCode;
   setMsgId(fsysCode,feaCode,fMsgId);
   setLabel(fmsgTextLine1,fmsgTextLine2,fmsgHelpUrl,fmsgColor);
   setLocation(180,45,600,100);
   
   msgColor=clrWhite;
   isShowButton=false;
   msgPanelFont=EA_FONT;
   msgHelpText=MSG_MSG_PANEL_HELP;
   buttonTextColor=clrWhite;
   buttonBackColor=clrDimGray;
   buttonBorderColor=clrWhite;
}

void ClassMsgPanel::setMsgId(string fsysCode,string feaCode,string fMsgId)
{
   sysCode=fsysCode;
   eaCode=feaCode;
   msgId=fMsgId;
}
void ClassMsgPanel::setLabel( string fmsgTextLine1,string fmsgTextLine2,string fmsgHelpUrl,color fmsgColor )
{
   if(fmsgTextLine1!=NULL)msgTextLine1=fmsgTextLine1;
   if(fmsgTextLine2!=NULL)msgTextLine2=fmsgTextLine2;
   if(fmsgHelpUrl!=NULL)msgHelpUrl=fmsgHelpUrl;
   if(fmsgColor!=clrNONE)msgColor=fmsgColor;
   changeLabel();
}

void ClassMsgPanel::setLocation( int fmsgPanelX,int fmsgPanelY,int fmsgPanelW=0,int fmsgPanelH=0  )
{
   if(fmsgPanelX!=0)msgPanelX=fmsgPanelX;
   if(fmsgPanelY!=0)msgPanelY=fmsgPanelY;
   if(fmsgPanelW!=0)msgPanelW=fmsgPanelW;
   if(fmsgPanelH!=0)msgPanelH=fmsgPanelH;
}

void ClassMsgPanel::setButton( string fbuttonText,color fbuttonTextColor=clrNONE,color fbuttonBackColor=clrNONE,color fbuttonBorderColor=clrNONE )
{
   if(fbuttonText!=NULL)buttonText=fbuttonText;
   if(fbuttonTextColor  !=clrNONE)buttonTextColor  =fbuttonTextColor;
   if(fbuttonBackColor  !=clrNONE)buttonBackColor  =fbuttonBackColor;
   if(fbuttonBorderColor!=clrNONE)buttonBorderColor=fbuttonBorderColor;
   ObjectSetString( 0,msgId+"Btn",OBJPROP_TEXT,buttonText);
   ObjectSetInteger(0,msgId+"Btn",OBJPROP_COLOR,buttonTextColor);
   ObjectSetInteger(0,msgId+"Btn",OBJPROP_BGCOLOR,buttonBackColor);
   ObjectSetInteger(0,msgId+"Btn",OBJPROP_BORDER_COLOR,buttonBorderColor);
   ChartRedraw();
}

void ClassMsgPanel::showPanel(bool enable,bool showButton=false)
{
   if(enable)
   {
      createRectLabel(0,msgId+"LbR",0,msgPanelX,msgPanelY,msgPanelW,msgPanelH,clrBlack,BORDER_RAISED,CORNER_LEFT_UPPER,clrWhite,STYLE_SOLID,2);
      writeLabelLU(msgId+"Lb1", msgTextLine1, msgPanelX+15, msgPanelY+15, 14, msgPanelFont, msgColor );
      writeLabelLU(msgId+"Lb2", msgTextLine2, msgPanelX+15, msgPanelY+40, 14, msgPanelFont, msgColor );
      if(msgHelpUrl!="")writeLabelLU(msgId+"LbHelp", msgHelpText , msgPanelX+15, msgPanelY+75, 9, msgPanelFont, clrSnow );
      if(showButton)
      {
            createButton(0,msgId+"Btn",0,msgPanelX+470,msgPanelY+55,StringLen(buttonText)*2*13,30,CORNER_LEFT_UPPER,buttonText,msgPanelFont,12,buttonTextColor,buttonBackColor,buttonBorderColor);
            ObjectSetInteger(0,msgId+"Btn",OBJPROP_WIDTH,3);
      }
   }
   else
      if(ObjectFind(msgId+"LbR")>=0)deleteAllObjects(DELETE_OBJECT_BY_PREFIX,msgId);
}

void ClassMsgPanel::clickHelp()
{ 
   openWebBroswer(msgHelpUrl);
}

void ClassMsgPanel::clickButton()
{ 
      showPanel(false);
}

void ClassMsgPanel::changeLabel()
{

   ObjectSetText(msgId+"Lb1",msgTextLine1,14,msgPanelFont,msgColor);
   ObjectSetText(msgId+"Lb2",msgTextLine2,14,msgPanelFont,msgColor);
   ChartRedraw();

}