#include <Wofu\\common\\logger.mqh>
#include <Wofu\\common\\errorDescriptions.mqh>
string getBase64Decode(string CodeTxt)
{
   uchar src[],dst[],key[];
   StringToCharArray("CHCHWA8888",key);
   StringToCharArray(StringSubstr(CodeTxt,0,StringLen(CodeTxt)-1),src);
   int res=CryptDecode(CRYPT_BASE64,src,key,dst);
   if(res>0)
      return(CharArrayToString(dst));
   else
      Print("Error in CryptDecode. Error code=",GetLastError());
   return "";   
}

/*

string getBase64Decode(string in)
  {
   string out="";
   static int ExtBase64Decode[256]={-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,  -1,  63,52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -2,  -1,  -1,-1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,-1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,-1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 };
   int i=0,len=StringLen(in);
   int shift=0,accum=0;
   while(i<len)
     {
      int value=ExtBase64Decode[StringGetChar(in,i)];
      if(value<0 || value>63) break;
      accum<<=6;
      shift+=6;
      accum|=value;
      if(shift>=8)
        {
         shift-=8;
         value=accum >> shift;
         out=out+CharToStr((char)(value & 0xFF));
        } 
      i++;
     }
     return(out);
  }

*/