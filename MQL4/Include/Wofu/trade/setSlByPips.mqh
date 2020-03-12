#include <Wofu\\trade\\selectOpOrderByTicketNo.mqh>
#include <Wofu\\trade\\omsSetSlByPips.mqh>
void setSlByPips(int fTicket,int fSlPips=-1,bool fKeepCloser=false,bool fSelectBeforeSet=true)
{
   if(fSelectBeforeSet)
      if( fTicket<0 || !selectOpOrderByTicketNo(fTicket))return;

   omsSetSlByPips(fTicket,fSlPips,fKeepCloser);
}
