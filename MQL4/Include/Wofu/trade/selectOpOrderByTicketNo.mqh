#include <Wofu\\common\\getOdMultiplier.mqh>
#include <Wofu\\common\\logTradeError.mqh>
bool selectOpOrderByTicketNo(int fTicket)
{
   if( OrderSelect(fTicket,SELECT_BY_TICKET,MODE_TRADES) )
   {
      return(true);
   }
   else
   {   
      logTradeError(__FUNCTION__,fTicket,GetLastError(),"OrderSelect ERROR");
      return(false);
   }

}