#include <Wofu\\enums\\LogLevel.mqh>
#include <Wofu\\common\\setLogLevel.mqh>
void logger(ENUM_LOG_LEVEL fLogLevel,string fMessage) export
{ 
   if(fLogLevel!=LOG_INFO_DETAIL )
   {
      if(fLogLevel>=LogLevel)printf("***** "+IntegerToString(fLogLevel)+","+fMessage+" *****"); 
   }
   else
   {
      if(GlobalVariableCheck("LOG_INFO_DETAIL") && GlobalVariableGet("LOG_INFO_DETAIL")==19790216 )
         printf("***** "+IntegerToString(fLogLevel)+","+fMessage+" *****");
   }
   if(fLogLevel==LOG_FATAL)Alert(fMessage);
}


