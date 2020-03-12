//#include <Wofu\\common\\logger.mqh>
#include <Wofu\\trade\\getLotsDigital.mqh>

double getLotsBySlPips
(
   string fSymbol,
   int fSlPips,
   double fSlAmt
//   int fmode=0, //0:Account Balance,1:Equility
) 
{
   //printf(fSlPips+","+fSlAmt+","+(fSlPips*MathAbs(MarketInfo(fSymbol,MODE_TICKVALUE)))+","+fSlAmt/(fSlPips*MathAbs(MarketInfo(fSymbol,MODE_TICKVALUE))) );
   if( fSlPips<=0 )return(0);
   return ( NormalizeDouble( fSlAmt/(fSlPips*MathAbs(MarketInfo(fSymbol,MODE_TICKVALUE))),getLotsDigital(fSymbol)) );
   


}