#include <Wofu\\trade\\selectOpOrderByTicketNo.mqh>
#include <Wofu\\trade\\omsSetTpSlByPrice.mqh>
void setTpSlByPrice(int fTicket,double fTpPrice,double fSlPrice,bool fSelectBeforeSet=true) 
{
   if(fSelectBeforeSet)
      if( fTicket<0 || !selectOpOrderByTicketNo(fTicket))return;

   omsSetTpSlByPrice(fTicket,fTpPrice,fSlPrice);
}
