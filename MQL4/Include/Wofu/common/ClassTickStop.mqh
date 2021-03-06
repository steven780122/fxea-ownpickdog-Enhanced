#include <Wofu\\common\\ClassMsgPanel.mqh>

class ClassTickStop
  {
   public:
      //void setNew( string text,string url);
      ClassTickStop(string fsysCode,string feaCode,string fobjId);
      bool isStop();
      void cancelStop();
      void setStop(datetime fTickStopEnd);
      void setStop(datetime fTickStopBegin,datetime fTickStopEnd);
      void showMsg();
      
      
      bool isGvStop();
      void cancelGvStop();
      void setGvStop(datetime fTickStopEnd);
      void setGVStop(datetime fTickStopBegin,datetime fTickStopEnd);
   private:
      void resetTime();

   protected: 
      string sysCode;
      string eaCode;
      string objId;
      datetime TickStopBegin;
      datetime TickStopEnd;
      ClassMsgPanel tickStopMsgPanel;
      
   //---- 
  };


ClassTickStop::ClassTickStop(string fsysCode,string feaCode,string fobjId)
{
   sysCode=fsysCode;
   eaCode=feaCode;
   objId=fobjId;
   tickStopMsgPanel.setMsgId(sysCode,eaCode,objId);
   resetTime();
};

bool ClassTickStop::isStop()
{
   if( TimeLocal() >= TickStopBegin && TimeLocal() <= TickStopEnd )return(true);
   
   return(false);
}

void ClassTickStop::showMsg()
{
   if(isStop())
   {
   
      string stopNotify=MSG_EA_TICK_STOP;
      if(TickStopEnd>=D'2999.12.31')
         stopNotify+="，需要手動恢復執行";
      else
         stopNotify+="，將於"+TimeToString(TickStopEnd,TIME_DATE+TIME_MINUTES)+"自動恢復執行";
         
      
      
      tickStopMsgPanel.setLabel(stopNotify,NULL,"",clrPink);
      tickStopMsgPanel.setButton("立即恢復");
      tickStopMsgPanel.showPanel(true,true); 
   }
   else
      tickStopMsgPanel.showPanel(false);


}
bool ClassTickStop::isGvStop()
{
   if(!GlobalVariableCheck(objId+"_B") || !GlobalVariableCheck(objId+"_E"))return(false);
   setStop((datetime)GlobalVariableGet(objId+"_B"),(datetime)GlobalVariableGet(objId+"_E"));
   return(isStop());
}

void ClassTickStop::cancelStop()
{
   resetTime();
   
}


void ClassTickStop::resetTime()
{
   TickStopBegin=D'2999.12.31 23:59:59'; 
   TickStopEnd=D'2999.12.31 23:59:59';  
}

void ClassTickStop::setStop(datetime fTickStopBegin,datetime fTickStopEnd)
{
   TickStopBegin=fTickStopBegin;
   TickStopEnd=fTickStopEnd;
}

void ClassTickStop::setStop(datetime fTickStopEnd)
{
   TickStopBegin=TimeLocal();
   TickStopEnd=fTickStopEnd;
}

void ClassTickStop::setGvStop(datetime fTickStopEnd)
{
   GlobalVariableSet(objId+"_B",TimeLocal());
   GlobalVariableSet(objId+"_E",fTickStopEnd);
}

void ClassTickStop::cancelGvStop()
{
   cancelStop();
   GlobalVariableDel(objId+"_B");
   GlobalVariableDel(objId+"_E");
   
}




