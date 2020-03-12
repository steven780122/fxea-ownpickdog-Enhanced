#include <Wofu\\trade\\selectOpOrderByTicketNo.mqh>
#include <Wofu\\trade\\omsSetSlByBreakEven.mqh>
void setSlByBreakEven
(
   int fTicket,
   int fBEStPips,    
   int fBEAddPips,
   bool fSelectBeforeSet=true,
)export
{
   if(fSelectBeforeSet)
      if( fTicket<0 || !selectOpOrderByTicketNo(fTicket))return;
      
   omsSetSlByBreakEven( fTicket, fBEStPips, fBEAddPips );
}