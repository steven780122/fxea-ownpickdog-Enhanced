#include <Wofu\\common\\logger.mqh>
#include <Wofu\\common\\errorDescriptions.mqh>
void logTradeError(string fFuncId,int fTicketNo,int fErrorCode,string fSomeThingToSay="")
{
   if(!GlobalVariableCheck("FNO1_SHOW_FUNC_ID"))
      logger(LOG_WARN,"** Warning ** "+fSomeThingToSay+" OrderTicket="+IntegerToString(fTicketNo)+","+ErrorDescription(fErrorCode)+"("+IntegerToString(fErrorCode)+")"); 
   else
      logger(LOG_WARN,"** Warning ** ["+fFuncId+"]:"+fSomeThingToSay+" OrderTicket="+IntegerToString(fTicketNo)+","+ErrorDescription(fErrorCode)+"("+IntegerToString(fErrorCode)+")"); 
}