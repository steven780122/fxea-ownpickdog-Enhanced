void printArray(string& StrArray[])export
{
    for (int i=0;i<ArraySize(StrArray);i++)
    {
         printf("StrArray["+(string)i+"]="+StrArray[i]);
         
    }
}