//#include <Wofu\\common\\getCryptEncodeToHex.mqh>
//#include <Wofu\\common\\getBase64Encode.mqh>
#include <Wofu\\common\\stringExtractAlpha.mqh>

#define DEFAULT_EA_ROUTE_WEBSITE "http://info.wofucapital.com"
#ifndef EA_ROUTE_WEBSITE
   #define EA_ROUTE_WEBSITE DEFAULT_EA_ROUTE_WEBSITE
#endif
string getInfoUrl
(
   string sysCode,
   string eaCode,
   string doWork
)
{

   return(EA_ROUTE_WEBSITE+"/?utm_source=MtEa&w="+doWork+"&s="+sysCode+"&e="+eaCode+"&a="+stringExtractAlpha((string)AccountInfoInteger(ACCOUNT_LOGIN),"1")+"&b="+stringExtractAlpha(AccountInfoString(ACCOUNT_COMPANY),"Aa1-#!()_"));

}
