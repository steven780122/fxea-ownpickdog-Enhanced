#include <Wofu\\trade\\selectOpOrderByTicketNo.mqh>
#include <Wofu\\trade\\omsSetSlByPrice.mqh>
void setSlByPrice(int fTicket,double fSlPrice,bool fSelectBeforeSet=true) 
{
   if(fSelectBeforeSet)
      if( fTicket<0 || !selectOpOrderByTicketNo(fTicket))return;

   omsSetSlByPrice(fTicket,fSlPrice);
}
