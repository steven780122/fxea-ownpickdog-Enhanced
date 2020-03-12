#include <Wofu\\common\\logger.mqh>
bool isNewPeriod() export
{
   static ulong PeriodPre;
   bool fIsNewPeriod=false;
   fIsNewPeriod=(PeriodPre!=0 && PeriodPre!=Period());
   PeriodPre=Period();
   logger(LOG_INFO,"NewPeriod="+(string)fIsNewPeriod+","+(string)Period());
   return(fIsNewPeriod);
}
