
//刪除預掛單 
#include <Wofu\\trade\\isMyOrder.mqh>
#include <Wofu\\trade\\setTpByPrice.mqh>

void setAllTpByPrice(string fSymbol,ENUM_MIXED_ORDER_TYPE fOdType,int fMagicNumber,double fTpPrice) export
{
   if( OrdersTotal()>0 )
      for(int i=0;i<OrdersTotal();i++)
         if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && isMyOrder(fSymbol,fOdType,fMagicNumber) ) 
            setTpByPrice(OrderTicket(),fTpPrice,false);
}

