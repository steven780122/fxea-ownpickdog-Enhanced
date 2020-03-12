#include <Wofu\\trade\\selectOpOrderByTicketNo.mqh>
#include <Wofu\\trade\\omsSetTpByPrice.mqh>
void setTpByPrice(int fTicket,double fTpPrice,bool fSelectBeforeSet=true) 
{
   if(fSelectBeforeSet)
      if( fTicket<0 || !selectOpOrderByTicketNo(fTicket))return;

   omsSetTpByPrice(fTicket,fTpPrice);
}
