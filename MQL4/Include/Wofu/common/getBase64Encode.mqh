#include <Wofu\\common\\logger.mqh>
#include <Wofu\\common\\errorDescriptions.mqh>
string getBase64Encode(string CodeTxt)
{
   uchar src[],dst[],key[];
   string dstString;
   StringToCharArray("CHCHWA8888",key);
   StringToCharArray(CodeTxt,src);
   int res=CryptEncode(CRYPT_BASE64,src,key,dst);
   if(res>0)
      return(CharArrayToString(dst));
   else
      logger(LOG_DEBUG,__FUNCTION__+":ERROR! "+(string)GetLastError()+","+ErrorDescription(GetLastError()));
   return "";   
}