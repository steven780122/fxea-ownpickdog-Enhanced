#include <Wofu\\draw\\writeImage.mqh>
void showSysBackground(string fBgName,int BgX=0,int BgY=0,ENUM_BASE_CORNER fcorner=CORNER_LEFT_UPPER,bool InBg=true) export
{
         writeImage(EA_NAME_E+"Sys"+fBgName+"Img","::Files\\"+SysCode+"\\"+fBgName+".bmp",BgX,BgY,clrBlack,fcorner,InBg);
         ChartRedraw();
         //WindowRedraw(); 
         /*
         ObjectSetInteger(0,EA_NAME_E+"SysBgImg",OBJPROP_XSIZE,ChartGetInteger(0,CHART_WIDTH_IN_PIXELS));
         ObjectSetInteger(0,EA_NAME_E+"SysBgImg",OBJPROP_YSIZE,ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS));  
         int ChartShiftSize=(int)(ChartGetDouble(0,CHART_SHIFT_SIZE)*ChartGetInteger(0,CHART_WIDTH_IN_PIXELS)/100);

         writeImage(EA_NAME_E+"SysRBgImg",FileRBg,ChartShiftSize,0,clrBlack,CORNER_RIGHT_UPPER,true); 
         ObjectSetInteger(0,EA_NAME_E+"SysRBgImg",OBJPROP_XSIZE,ChartShiftSize);
         ObjectSetInteger(0,EA_NAME_E+"SysRBgImg",OBJPROP_YSIZE,ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS));
         */
         
         //writeImage(EA_NAME_E+"SysBgImg",FileBg,BgX,BgY,clrBlack);
         //ChartSetInteger(0,CHART_SHIFT,true);
         //ChartSetDouble(0,CHART_SHIFT_SIZE,(int)MathRound(RSize*100/ChartGetInteger(0,CHART_WIDTH_IN_PIXELS))+1);
         //int ChartShiftSize=(int)(ChartGetDouble(0,CHART_SHIFT_SIZE)*ChartGetInteger(0,CHART_WIDTH_IN_PIXELS)/100);
         //writeImage(EA_NAME_E+"SysRBgImg",FileRBg,RBgX,RBgY,clrBlack,CORNER_RIGHT_UPPER,false); 
         //ObjectSetInteger(0,EA_NAME_E+"SysRBgImg",OBJPROP_XSIZE,RSize);
         //ObjectSetInteger(0,EA_NAME_E+"SysRBgImg",OBJPROP_YSIZE,ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS));  
         

}     