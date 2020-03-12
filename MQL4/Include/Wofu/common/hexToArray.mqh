#define HEXCHAR_TO_DECCHAR(h)  (h<=57 ? (h-48) : (h-55))
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool hexToArray(string str,uchar &arr[])
  {
   int strcount = StringLen(str);
   int arrcount = ArraySize(arr);
   if(arrcount < strcount / 2) return false;

   uchar tc[];
   StringToCharArray(str,tc);

   int i=0, j=0;
   for(i=0; i<strcount; i+=2)
     {
      uchar tmpchr=(HEXCHAR_TO_DECCHAR(tc[i])<<4)+HEXCHAR_TO_DECCHAR(tc[i+1]);
      arr[j]=tmpchr;
      j++;
     }

   return true;
  }
  
/*
bool HexToArray(string str, uchar &arr[])
{
   int arrcount = ArraySize(arr);
   int strcount = StringLen(str);
   ArrayResize(arr,strcount / 2);
   if (arrcount < strcount / 2) return false;
   
   int i=0, j=0;
   
   for (i=0; i<strcount; i+=2)
   {
      string sub = StringSubstr(str, i, 2);
      uchar tmpchr = HexToDecimal(StringSubstr(str, i, 1))*16 + HexToDecimal(StringSubstr(str, i+1, 1));     
      arr[j] = tmpchr;
      j++;
   }
   
   return true;
}

uchar HexToDecimal(string hex)
{
   // assumes hex is 1 character
   if (!StringCompare(hex, "0"))
      return 0;
   if (!StringCompare(hex, "1"))
      return 1;
   if (!StringCompare(hex, "2"))
      return 2;
   if (!StringCompare(hex, "3"))
      return 3;
   if (!StringCompare(hex, "4"))
      return 4;
   if (!StringCompare(hex, "5"))
      return 5;
   if (!StringCompare(hex, "6"))
      return 6;
   if (!StringCompare(hex, "7"))
      return 7;
   if (!StringCompare(hex, "8"))
      return 8;
   if (!StringCompare(hex, "9"))
      return 9;
   if (!StringCompare(hex, "A"))
      return 10;
   if (!StringCompare(hex, "B"))
      return 11;
   if (!StringCompare(hex, "C"))
      return 12;
   if (!StringCompare(hex, "D"))
      return 13;
   if (!StringCompare(hex, "E"))
      return 14;
   if (!StringCompare(hex, "F"))
      return 15;
   return 0;
}

*/