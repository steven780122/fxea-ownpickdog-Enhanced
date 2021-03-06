//#include <Wofu\\common\\getCryptDecodeFromHex.mqh>
#include <Wofu\\common\\hexToArray.mqh>
string getCryptDecodeFromHex
(
   ENUM_CRYPT_METHOD cipher,
   string encodehex,
   string key
)
{
   uchar arrText[],arrKey[],arrEncode[];
   StringToCharArray(key, arrKey,0 ,StringLen(key));
   ArrayResize(arrEncode,StringLen(encodehex)/2);
   hexToArray(encodehex,arrEncode);
   CryptDecode(cipher,arrEncode,arrKey,arrText);
   return(CharArrayToString(arrText));
}


