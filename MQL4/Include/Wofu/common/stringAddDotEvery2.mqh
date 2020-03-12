string stringAddDotEvery2(string datestring)
{
   return(StringSubstr(datestring,0,4)+"."+StringSubstr(datestring,4,2)+"."+StringSubstr(datestring,6,2));
}