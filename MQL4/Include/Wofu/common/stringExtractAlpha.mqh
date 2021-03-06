//如果要找大寫英文字other="A"，小寫other="a"，數字other="1"，其他就直接輸入
//比方時間HH:MM-HH:MM stringExtractAlpha(inputtime,"1-:");

string stringExtractAlpha(string istr, string other="Aa1")   {
//+------------------------------------------------------------------+
// Returns alphabetic (or other) characters in a string, strips out everything else
// parameter 'other' defaults to 'Aa' which will return all uppercase & lowercase alpha chars
// appending '1' to 'other' will return digits 0-9 also
// appending any other chars to 'other' will cause those chars to be returned also
// Example: ExtractAlpha("-34.5蚓","1-.") will return "-34.5" 
// Note: to strip a numeric value from a string, see StrToNumber() function
  string ostr = "";
  for (int i=0; i<StringLen(istr); i++)  {
    string s = StringSubstr(istr,i,1);
    if ((s >= "A" && s <= "Z" && StringFind(other,"A") >= 0) 
    ||  (s >= "a" && s <= "z" && StringFind(other,"a") >= 0) 
    ||  (s >= "0" && s <= "9" && StringFind(other,"1") >= 0) 
    ||  StringFind(other,s) >= 0)
      ostr = ostr + s;
  }    
  return(ostr);
}  