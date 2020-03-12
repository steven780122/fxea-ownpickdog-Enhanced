#include <Wofu\\draw\\getAnchorSame.mqh>
void writeImage(string fObjName,string iLableDoc,int iLableX,int iLableY,color iDocColor,ENUM_BASE_CORNER iLabelCorner=CORNER_LEFT_UPPER,bool back=true) export
  {
   ObjectCreate(0,fObjName,OBJ_BITMAP_LABEL,0,0,0);
   ObjectSetString(0,fObjName,OBJPROP_BMPFILE,0,iLableDoc);
   ObjectSetString(0,fObjName,OBJPROP_BMPFILE,1,iLableDoc);
   ObjectSetInteger(0,fObjName,OBJPROP_CORNER,iLabelCorner );
   ObjectSetInteger(0,fObjName,OBJPROP_ANCHOR,getAnchorSame(iLabelCorner));
   ObjectSetInteger(0,fObjName,OBJPROP_XDISTANCE,iLableX);
   ObjectSetInteger(0,fObjName,OBJPROP_YDISTANCE,iLableY);
   ObjectSet(fObjName,OBJPROP_BACK,back);
   
   ChartRedraw(0);
  }

  