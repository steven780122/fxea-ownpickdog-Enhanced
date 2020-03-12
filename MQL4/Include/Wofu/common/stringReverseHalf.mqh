#include <Wofu\\common\\stringReverse.mqh>
#include <Wofu\\common\\logger.mqh>

string stringReverseHalf(string fsrc)
{
   string fout="";
   //StringReverse
   int cutno=(int)MathFloor(StringLen(fsrc)/2);
   fout=stringReverse(StringSubstr(fsrc,cutno,StringLen(fout)-cutno));
   fout+=stringReverse(StringSubstr(fsrc,0,cutno));
   logger(LOG_DEBUG,__FUNCTION__+":StringReverseHalf fsrc="+fsrc+",fout="+fout);
   return(fout);
}