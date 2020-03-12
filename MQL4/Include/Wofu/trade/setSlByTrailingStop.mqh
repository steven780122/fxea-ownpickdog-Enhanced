#include <Wofu\\trade\\selectOpOrderByTicketNo.mqh>
#include <Wofu\\trade\\omsSetSlByTrailingStop.mqh>
void setSlByTrailingStop
(
   int fTicket,
   int fSlPips,
   int fStPips,
   int fSlGapPips,
   int fSpPips,
   bool fSelectBeforeSet=true,
)export
{
   if(fSelectBeforeSet)
      if( fTicket<0 || !selectOpOrderByTicketNo(fTicket))return;

   omsSetSlByTrailingStop( fTicket, fSlPips, fStPips, fSlGapPips, fSpPips);
}