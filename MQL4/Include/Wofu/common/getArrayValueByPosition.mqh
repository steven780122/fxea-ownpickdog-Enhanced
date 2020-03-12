string getArrayValueByPosition(string& SearchArray[],int index)
{
   int indexMax=ArraySize(SearchArray)-1;
   if(index<=indexMax)
      return( SearchArray[index] );
   else
      return( SearchArray[indexMax] );
}
double getArrayValueByPosition(double& SearchArray[],int index)
{
   int indexMax=ArraySize(SearchArray)-1;
   if(index<=indexMax)
      return( SearchArray[index] );
   else
      return( SearchArray[indexMax] );
}
int getArrayValueByPosition(int& SearchArray[],int index)
{
   int indexMax=ArraySize(SearchArray)-1;
   if(index<=indexMax)
      return( SearchArray[index] );
   else
      return( SearchArray[indexMax] );
}
