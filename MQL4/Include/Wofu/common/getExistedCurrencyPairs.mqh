#include <Wofu\\common\\isExistCurrencyPair.mqh>
void getExistedCurrencyPairs(string& CPair[]) export
{
   string CPairResult="";
    for (int i=0;i<ArraySize(CPair);i++)
    {
         if(isExistCurrencyPair(CPair[i]))
         { CPairResult+=(CPairResult=="")?CPair[i]:(","+CPair[i]); }
    }
    //printf(CPairResult);
    StringSplit(CPairResult,',',CPair);
}
