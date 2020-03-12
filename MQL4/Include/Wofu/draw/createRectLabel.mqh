
bool createRectLabel(long             chart_ID=0,               // chart's ID
                     string           name="RectLabel",         // label name
                     int              sub_window=0,             // subwindow index
                     int              x=0,                      // X coordinate
                     int              y=0,                      // Y coordinate
                     int              width=50,                 // width
                     int              height=18,                // height
                     color            back_clr=C'236,233,216',  // background color
                     ENUM_BORDER_TYPE border=BORDER_RAISED,     // border type
                     ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER, // chart corner for anchoring
                     color            clr=clrRed,               // flat border color (Flat)
                     ENUM_LINE_STYLE  style=STYLE_SOLID,        // flat border style
                     int              line_width=0,             // flat border width
                     bool             back=false,               // in the background
                     bool             selection=false,          // highlight to move
                     bool             hidden=true,              // hidden in the object list
                     long             z_order=0)  export               // priority for mouse click 
  {
//--- reset the error value
   ResetLastError();
//--- create a rectangle label
   if(!ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
      return(false);
//--- set label coordinates
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
//--- set label size
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
//--- set background color
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
//--- set border type
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,border);
//--- set the chart's corner, relative to which point coordinates are defined
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
   //ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,GetAnchor(corner));  not support anchor
//--- set flat border color (in Flat mode)
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set flat border line style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set flat border width
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the label by mouse
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
  