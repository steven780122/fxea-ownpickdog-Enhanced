class ClassOrderCount
  {
   public:
      //void setNew( string text,string url);
      ClassOrderCount();
      void getCount(string fSymbol,int fMagicNumber);
      int buy;
      int buystop;
      int buylimit;
      int sell;
      int sellstop;
      int selllimit;
      
      int all;
      int open;
      int stop;
      int limit;
      int pre;
      int pre_buy;
      int pre_sell;
      
   private:

   protected: 
      string sysCode;
      string eaCode;
      string objId;      
   //---- 
  };


ClassOrderCount::ClassOrderCount()
{
};

void ClassOrderCount::getCount(string fSymbol,int fMagicNumber)
{
   this.buy=0;
   this.buystop=0;
   this.buylimit=0;
   this.sell=0;
   this.sellstop=0;
   this.selllimit=0;
      
     for(int i=0;i<OrdersTotal();i++)
     {
         if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && 
             ( fSymbol=="ALL"   || OrderSymbol()==fSymbol ) && 
             ( fMagicNumber==-1 || OrderMagicNumber()==fMagicNumber ) )
         { 
            switch(OrderType())
            {
               case ORDER_TYPE_BUY:
                  this.buy++;
                  break;
               case ORDER_TYPE_SELL:
                  this.sell++;
                  break;
               case ORDER_TYPE_BUY_STOP:
                  this.buystop++;
                  break;
               case ORDER_TYPE_SELL_STOP:
                  this.sellstop++;
                  break;
               case ORDER_TYPE_BUY_LIMIT:
                  this.buylimit++;
                  break;
               case ORDER_TYPE_SELL_LIMIT:
                  this.selllimit++;
                  break;               
               default:
                  break;
            }      
         }
      }
      this.open=this.buy+this.sell;
      this.stop=this.buystop+this.sellstop;
      this.limit=this.buylimit+this.selllimit;
      
      this.pre=this.stop+this.limit;
      this.pre_buy=this.buystop+this.buylimit;
      this.pre_sell=this.sellstop+this.selllimit;
      this.all=this.open+this.stop+this.limit;
}
