//把輸入字串倒排
//+------------------------------------------------------------------+
string stringReverse(string str)
//+------------------------------------------------------------------+
// Reverses the content of a string, e.g. "ABCDE" becomes "EDCBA"
{
  string outstr = "";
  for (int i=StringLen(str)-1; i>=0; i--)
    outstr = outstr + StringSubstr(str,i,1);
  return(outstr);
}
