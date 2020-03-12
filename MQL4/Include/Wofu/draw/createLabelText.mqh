#include <Wofu\\draw\\createRectLabel.mqh>
#include <Wofu\\draw\\writeLabel.mqh>
#include <Wofu\\draw\\deleteAllObjects.mqh>

void createLabelTextLU
(
   string           name="RectLabel",         // label name
   int              x=0,                      // X coordinate
   int              y=0,                      // Y coordinate
   string           text="",
   int iDocSize=12,
   color iDocColor=clrBlack,
   color            back_clr=C'236,233,216',  // background color
   ENUM_BORDER_TYPE border=BORDER_RAISED,     // border type
   color            clr=clrRed,               // flat border color (Flat)
   ENUM_LINE_STYLE  style=STYLE_SOLID,        // flat border style
   int              line_width=0              // flat border width
                     
                     
)
{
   int w=(int)(iDocSize*StringLen(text)+10);
   int h=iDocSize+10;
   createRectLabel(0,name,0,x,y,w,h,back_clr,border,CORNER_LEFT_UPPER,clr,style,line_width);
   writeLabel(name+"Lb",text,(int)(x+0.5*w),(int)(y+0.5*h),iDocSize,"Arial",iDocColor,CORNER_LEFT_UPPER,ANCHOR_CENTER);




}
                     
void createLabelTextRU
(
   string           name,         // label name
   int              x,                      // X coordinate
   int              y,                      // Y coordinate
   int              w,
   int              h,
   string           text,
   int iDocSize=12,
   color iDocColor=clrBlack,
   color            back_clr=C'236,233,216',  // background color
   ENUM_BORDER_TYPE border=BORDER_FLAT,     // border type
   color            clr=clrRed,               // flat border color (Flat)
   ENUM_LINE_STYLE  style=STYLE_SOLID,        // flat border style
   int              line_width=0              // flat border width
                     
                     
)
{
   //int w=(int)(iDocSize*StringLen(text)+10);
   //int h=iDocSize+10;
   createRectLabel(0,name,0,x,y,w,h,back_clr,border,CORNER_RIGHT_UPPER,clr,style,line_width);
   writeLabel(name+"Lb",text,(int)(x-0.5*w),(int)(y+0.5*h),iDocSize,"Arial",iDocColor,CORNER_RIGHT_UPPER,ANCHOR_CENTER);
}
