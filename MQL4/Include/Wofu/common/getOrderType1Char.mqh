string getOrderType1Char(ENUM_ORDER_TYPE odtype)
{
   return( StringSubstr(EnumToString(odtype),11,1) );
}