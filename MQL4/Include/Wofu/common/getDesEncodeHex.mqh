#include <Wofu\\common\\arrayToHex.mqh>

string getDesEncodeHex(string CodeTxt,string CodeKey)
{
   uchar src[],dst[],key[];
   string dstString;
   StringToCharArray(CodeKey,key);
   StringToCharArray(CodeTxt,src);
   int res=CryptEncode(CRYPT_DES,src,key,dst);
   if(res>0)
      return arrayToHex(dst);
   else
      Print("Error in CryptEncode. Error code=",GetLastError());
   return "";   
}