void stringSplitToArray
(
   string fString,
   ushort fSeperator,
   string& fArray[],
   ENUM_DATATYPE fDataType=TYPE_STRING
)
 {
   StringSplit(fString,fSeperator,fArray); 
 }


void stringSplitToArray
(
   string fString,
   ushort fSeperator,
   double& fArray[]
)
 {
   string strArray[];
   StringSplit(fString,fSeperator,strArray);
   ArrayResize(fArray,ArraySize(strArray));
   for(int fIdx=0;fIdx<ArraySize(fArray);fIdx++)
      fArray[fIdx]=StringToDouble(strArray[fIdx]);
 }

void stringSplitToArray
(
   string fString,
   ushort fSeperator,
   int& fArray[]
)
 {
   string strArray[];
   StringSplit(fString,fSeperator,strArray);
   ArrayResize(fArray,ArraySize(strArray));
   for(int fIdx=0;fIdx<ArraySize(fArray);fIdx++)
      fArray[fIdx]=(int)StringToInteger(strArray[fIdx]);
 }
