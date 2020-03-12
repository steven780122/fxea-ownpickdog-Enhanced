//#include <Wofu\\common\\getCryptEncodeToHex.mqh>
#include <Wofu\\common\\arrayToHex.mqh>
string getCryptEncodeToHex
(
   ENUM_CRYPT_METHOD cipher,
   string text,
   string key
)
{
   uchar arrText[],arrKey[],arrEncode[];
   
   StringToCharArray(text, arrText,0 ,StringLen(text));
   StringToCharArray(key,  arrKey ,0 ,StringLen(key));
   
   
   int len=CryptEncode(cipher, arrText, arrKey, arrEncode);
   return(arrayToHex(arrEncode));   
}