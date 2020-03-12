

ENUM_ANCHOR_POINT getAnchorSame(ENUM_BASE_CORNER fcorner)
{
   switch(fcorner)
   {
      case CORNER_LEFT_LOWER:
         return ANCHOR_LEFT_LOWER;
      case CORNER_LEFT_UPPER :
         return ANCHOR_LEFT_UPPER;      
      case CORNER_RIGHT_LOWER:
         return ANCHOR_RIGHT_LOWER;
      case CORNER_RIGHT_UPPER :
         return ANCHOR_RIGHT_UPPER;      
   }
   return ANCHOR_LEFT_UPPER;
   //Ref: https://docs.mql4.com/constants/objectconstants/enum_basecorner
}