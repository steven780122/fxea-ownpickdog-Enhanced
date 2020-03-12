void writeLabel
(
   string fObjName,
   string iLableDoc,
   int iLableX,
   int iLableY,
   int iDocSize,
   string iDocStyle,
   color iDocColor,
   ENUM_BASE_CORNER iLabelCorner,
   ENUM_ANCHOR_POINT iAnchorCorner
)  export
{
   ObjectCreate(fObjName,OBJ_LABEL,0,0,0);
   ObjectSetText(fObjName,iLableDoc,iDocSize,iDocStyle,iDocColor);
   ObjectSet(fObjName, OBJPROP_CORNER,iLabelCorner );
   ObjectSet(fObjName, OBJPROP_ANCHOR,iAnchorCorner );
   ObjectSet(fObjName,OBJPROP_XDISTANCE,iLableX);
   ObjectSet(fObjName,OBJPROP_YDISTANCE,iLableY);
}


  

void writeLabelLU(string fObjName,string iLableDoc,int iLableX,int iLableY,int iDocSize,string iDocStyle,color iDocColor) export
{ writeLabel(fObjName,iLableDoc,iLableX,iLableY,iDocSize,iDocStyle,iDocColor,CORNER_LEFT_UPPER,ANCHOR_LEFT_UPPER);}

void writeLabelLL(string fObjName,string iLableDoc,int iLableX,int iLableY,int iDocSize,string iDocStyle,color iDocColor) export
{ writeLabel(fObjName,iLableDoc,iLableX,iLableY,iDocSize,iDocStyle,iDocColor,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);}

   
void writeLabelRU(string fObjName,string iLableDoc,int iLableX,int iLableY,int iDocSize,string iDocStyle,color iDocColor) export
{ writeLabel(fObjName,iLableDoc,iLableX,iLableY,iDocSize,iDocStyle,iDocColor,CORNER_RIGHT_UPPER,ANCHOR_RIGHT_UPPER);}

void writeLabelRL(string fObjName,string iLableDoc,int iLableX,int iLableY,int iDocSize,string iDocStyle,color iDocColor) export
{ writeLabel(fObjName,iLableDoc,iLableX,iLableY,iDocSize,iDocStyle,iDocColor,CORNER_RIGHT_LOWER,ANCHOR_RIGHT_LOWER);}


void writeLabelRUS(string fObjName,string iLableDoc,int iLableX,int iLableY,int iDocSize,string iDocStyle,color iDocColor ,  string fHeader ,int ScrollLength) export
{ 
   if(StringLen(iLableDoc)==0)iLableDoc=iLableDoc+" ";
   writeLabel(fObjName,fHeader+StringSubstr(iLableDoc,(int)TimeLocal()%StringLen(iLableDoc),ScrollLength),iLableX,iLableY,iDocSize,iDocStyle,iDocColor,CORNER_RIGHT_UPPER,ANCHOR_LEFT_UPPER);
}
void writeLabelLUS(string fObjName,string iLableDoc,int iLableX,int iLableY,int iDocSize,string iDocStyle,color iDocColor ,  string fHeader, int ScrollLength) export
{ 
   if(StringLen(iLableDoc)==0)iLableDoc=iLableDoc+" ";
   writeLabel(fObjName,fHeader+StringSubstr(iLableDoc,(int)TimeLocal()%StringLen(iLableDoc),ScrollLength),iLableX,iLableY,iDocSize,iDocStyle,iDocColor,CORNER_LEFT_UPPER,ANCHOR_LEFT_UPPER);
}
